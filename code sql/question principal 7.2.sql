-- Améliorations suggérées (exemple : ajouter un jardin ou un balcon)
SELECT L.id_logement, L.nom, T.jardin, T.balcon
FROM Logement L
JOIN Caracteriser C ON L.id_logement = C.id_logement
JOIN Type T ON C.id_type = T.id_type
WHERE T.jardin = FALSE OR T.balcon = FALSE;  -- Logements sans jardin ou balcon
