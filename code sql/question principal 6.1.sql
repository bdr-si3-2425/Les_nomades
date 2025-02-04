-- Résidents actuellement dans un logement donné
SELECT R.id_resident, R.nom, R.prenom
FROM Resident R
JOIN Locataire Loc ON R.id_resident = Loc.id_resident
JOIN Reservation Res ON Loc.id_reservation = Res.id_reservation
WHERE Res.id_logement = 1  -- Logement donné
AND CURRENT_DATE BETWEEN Res.debut AND Res.fin;

--Comme il n'y a aucun locataire actuellement il n'y a personne dans la table