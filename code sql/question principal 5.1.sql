-- Résidents ayant prolongé leur séjour
SELECT R.id_resident, R.nom, R.prenom, Res.debut, Res.fin
FROM Resident R
JOIN Locataire Loc ON R.id_resident = Loc.id_resident
JOIN Reservation Res ON Loc.id_reservation = Res.id_reservation
WHERE Res.prolongation = TRUE;

--Voir "question principal 5.2" pour voir les appartements impactées

