-- Insérer une réservation pour un logement tout en s'assurant qu'il n'est pas déjà réservé aux mêmes dates
-- Notion SQL utilisée : transaction

BEGIN;

-- Vérifie que le logement est disponible pour les dates données
SELECT id_reservation
FROM Reservation
WHERE id_logement = 2
  AND ('2025-07-01' BETWEEN debut AND fin OR '2025-07-10' BETWEEN debut AND fin)
  FOR UPDATE;

-- Si aucun résultat, on peut insérer une réservation
INSERT INTO Reservation (debut, fin, nombre_resident, prix, prolongation, id_logement)
VALUES ('2025-07-01', '2025-07-10', 2, 800, FALSE, 2);

-- Met à jour le nombre de réservations pour le logement
UPDATE Logement
SET nb_de_fois_reservee = nb_de_fois_reservee + 1
WHERE id_logement = 2;

COMMIT;