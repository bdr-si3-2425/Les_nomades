-- Empêcher d'insérer une réservation si le logement est déjà réservé sur la période demandée
-- Notion SQL utilisée : trigger
CREATE OR REPLACE FUNCTION verifier_disponibilite_logement()
RETURNS TRIGGER AS $$
DECLARE
    capacite_max INT;
    nombre_reservations INT;
BEGIN
    -- Récupérer la capacité maximale du logement
    SELECT capacite INTO capacite_max
    FROM Logement
    WHERE id_logement = NEW.id_logement;    -- Compter le nombre de réservations actives pour ce logement aux mêmes dates
    SELECT COUNT(*) INTO nombre_reservations
    FROM Reservation
    WHERE id_logement = NEW.id_logement
    AND ((NEW.debut BETWEEN debut AND fin) OR (NEW.fin BETWEEN debut AND fin) OR (debut BETWEEN NEW.debut AND NEW.fin));    -- Si le nombre de réservations atteint la capacité maximale, empêcher l'insertion
    IF nombre_reservations >= capacite_max THEN
        RAISE EXCEPTION 'Ce logement est déjà complet pour cette période.';
    END IF;    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE OR REPLACE TRIGGER trigger_verif_disponibilite
BEFORE INSERT ON Reservation
FOR EACH ROW
EXECUTE FUNCTION verifier_disponibilite_logement();