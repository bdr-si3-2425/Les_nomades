-- Créer une vue qui permet d’obtenir facilement les colocataires actuels pour être réutilisée dans d'autres requêtes
-- Notion SQL utilisée : vue
CREATE VIEW Vue_Colocataires AS
SELECT 
    R1.id_resident AS id_resident_1, R1.nom AS nom_resident_1, R1.prenom AS prenom_resident_1,
    R2.id_resident AS id_resident_2, R2.nom AS nom_resident_2, R2.prenom AS prenom_resident_2,
    L.id_logement, L.nom AS nom_logement, Res1.debut, Res1.fin
FROM Reservation Res1
JOIN Reservation Res2 ON Res1.id_logement = Res2.id_logement
AND Res1.id_resident < Res2.id_resident  -- Évite les doublons
AND Res1.fin > Res2.debut  -- Vérifie si les réservations se chevauchent
JOIN Resident R1 ON Res1.id_resident = R1.id_resident
JOIN Resident R2 ON Res2.id_resident = R2.id_resident
JOIN Logement L ON Res1.id_logement = L.id_logement;

SELECT * FROM Vue_Colocataires;
