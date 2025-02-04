--Sélectionner les logements disponibles en prenant en compte le type, la ville et le prix
-- Notion SQL utilisée : sous-requête
SELECT L.id_logement, L.nom, L.capacite, L.prix_hebdomadaire, Lieu.ville, Lieu.adresse
FROM Logement L
JOIN Localisation Loc ON L.id_logement = Loc.id_logement
JOIN Lieu ON Loc.id_lieu = Lieu.id_lieu
JOIN Caracteriser C ON L.id_logement = C.id_logement
JOIN Type T ON C.id_type = T.id_type
WHERE L.id_logement NOT IN (
    SELECT id_logement
    FROM Reservation
    WHERE (debut <= '2023-12-15' AND fin >= '2023-12-01')  -- Période donnée
)
AND T.maison = TRUE  -- Critère : type de logement (exemple : maison)
AND Lieu.ville = 'Paris'  -- Critère : emplacement (exemple : Paris)
AND L.prix_hebdomadaire <= 600.00;  -- Critère : prix maximum (exemple 600 euros)
