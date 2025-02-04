-- Top 2 des logements avec le plus d'interventions
SELECT L.id_logement, L.nom, COUNT(I.id_intervention) AS nb_interventions
FROM Logement L
JOIN Intervention I ON L.id_logement = I.id_logement
GROUP BY L.id_logement, L.nom
ORDER BY nb_interventions DESC
LIMIT 2;  
