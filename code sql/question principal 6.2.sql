-- Activités préférées des résidents
SELECT L.nom AS activite, COUNT(A.id_resident) AS nb_participants
FROM Loisir L
JOIN Activite A ON L.id_loisir = A.id_loisir
WHERE A.id_resident IN (
    SELECT R.id_resident
    FROM Resident R
    JOIN Locataire Loc ON R.id_resident = Loc.id_resident
    JOIN Reservation Res ON Loc.id_reservation = Res.id_reservation
    WHERE Res.id_logement = 1  -- Logement donné
)
GROUP BY L.nom
ORDER BY nb_participants DESC;
