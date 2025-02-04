-- Impact sur les réservations futures
SELECT L.id_logement, L.nom, COUNT(Res.id_reservation) AS nb_reservations_impactees
FROM Logement L
JOIN Reservation Res ON L.id_logement = Res.id_logement
WHERE Res.debut > CURRENT_DATE  -- Réservations futures
AND L.id_logement IN (
    SELECT id_logement
    FROM Reservation
    WHERE prolongation = TRUE
)
GROUP BY L.id_logement, L.nom;