-- Cette fonction permet de vérifier la disponibilité d'un logement pour des dates données, d'ajouter une réservation si possible, et de mettre à jour les informations associées.
-- Notion SQL utilisée : transaction
CREATE OR REPLACE FUNCTION reserver(
    debut DATE,
    fin DATE,
    nombre_resident INT,
    prix NUMERIC,
    id_logement INT,
    id_resident INT
) RETURNS VOID AS $$

BEGIN

    IF EXISTS (
        SELECT 1
        FROM Reservation
        WHERE Reservation.id_logement = id_logement
          AND (debut <= fin AND fin >= debut) -- Vérifie le chevauchement des dates
          FOR UPDATE
    ) THEN
        RAISE EXCEPTION 'Le logement % est déjà réservé pour les dates demandées.', id_logement;
    END IF;

    -- Insère une nouvelle réservation
    INSERT INTO Reservation (debut, fin, nombre_resident, prix, prolongation, id_logement, id_resident)
    VALUES (debut, fin, nombre_resident, prix, FALSE, id_logement, id_resident);

    -- Récupère l'ID de la réservation insérée
    INSERT INTO Locataire (id_resident, id_reservation)
    VALUES (
        id_resident,
        (SELECT id_reservation 
         FROM Reservation 
         WHERE Reservation.id_logement = id_logement AND debut = debut LIMIT 1)
    );

    -- Met à jour le compteur de réservations du logement
    UPDATE Logement
    SET nb_de_fois_reservee = nb_de_fois_reservee + 1
    WHERE Logement.id_logement = id_logement;
END;
$$ LANGUAGE plpgsql;
