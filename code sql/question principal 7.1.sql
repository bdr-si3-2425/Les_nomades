-- Types de logements les plus demandés
SELECT T.maison, T.appartement, T.meuble, COUNT(Res.id_reservation) AS nb_reservations
FROM Type T
JOIN Caracteriser C ON T.id_type = C.id_type
JOIN Logement L ON C.id_logement = L.id_logement
JOIN Reservation Res ON L.id_logement = Res.id_logement
GROUP BY T.maison, T.appartement, T.meuble
ORDER BY nb_reservations DESC;
