-- Insertion des types de logements
INSERT INTO Type (maison, appartement, meuble, escalier, ascenseur, jardin, balcon) VALUES
(TRUE, FALSE, TRUE, FALSE, TRUE, TRUE, FALSE),
(FALSE, TRUE, TRUE, TRUE, TRUE, FALSE, TRUE),
(TRUE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE);-- Insertion des logements
INSERT INTO Logement (nom, capacite, entretien_requis, prix_hebdomadaire, nb_de_fois_reservee, note) VALUES
('Maison Paris 1', 4, FALSE, 550.00, 2, 4.5),
('Appartement Paris 2', 2, FALSE, 450.00, 3, 4.2),
('Maison Lyon 1', 6, TRUE, 700.00, 1, 3.8);-- Insertion des relations entre logements et types
INSERT INTO Caracteriser (id_logement, id_type) VALUES (1, 1), (2, 2), (3, 3);-- Insertion des lieux
INSERT INTO Lieu (pays, ville, adresse) VALUES
('France', 'Paris', '12 Rue de Rivoli'),
('France', 'Lyon', '34 Avenue de la République');-- Insertion des localisations
INSERT INTO Localisation (id_logement, id_lieu) VALUES (1, 1), (2, 1), (3, 2);-- Insertion des résidents
INSERT INTO Resident (nom, prenom, age) VALUES
('Dupont', 'Jean', 30),
('Martin', 'Claire', 25),
('Durand', 'Paul', 28);-- Insertion des réservations
INSERT INTO Reservation (debut, fin, nombre_residant, prix, prolongation, id_logement, id_resident) VALUES
('2023-12-01', '2023-12-15', 2, 900.00, FALSE, 1, 1),
('2023-12-05', '2023-12-20', 1, 700.00, TRUE, 2, 2);-- Insertion des locataires
INSERT INTO Locataire (id_resident, id_reservation) VALUES (1, 1), (2, 2);-- Insertion des interventions
INSERT INTO Intervention (type, urgence, id_logement) VALUES
('Plomberie', 'Élevée', 1),
('Électricité', 'Moyenne', 2);-- Insertion des sociétés d’intervention
INSERT INTO Societe_exterieure (description) VALUES
('Plombiers Express'),
('Électricité Lyon');-- Lier les interventions et sociétés
INSERT INTO Effectuer (id_intervention, id_societe) VALUES (1, 1), (2, 2);-- Insertion des loisirs
INSERT INTO Loisir (nom) VALUES
('Yoga'),
('Football');-- Insertion des activités des résidents
INSERT INTO Activite (id_loisir, id_resident, date_activite, description) VALUES
(1, 1, '2023-12-10', 'Cours de Yoga'),
(2, 2, '2023-12-12', 'Match de football');-- Insertion des interactions
INSERT INTO Interaction (description_interaction) VALUES
('Partagé un repas'),
('Dispute sur le ménage');-- Insertion des rencontres entre résidents
INSERT INTO Rencontre (id_resident1, id_resident2, id_interaction) VALUES
(1, 2, 1),
(2, 3, 2);-- Ajout d'une réservation prolongée pour tester la première requête
INSERT INTO Reservation (debut, fin, nombre_residant, prix, prolongation, id_logement, id_resident) VALUES
('2024-01-01', '2024-01-20', 2, 1200.00, TRUE, 3, 3);-- Ajout d'un locataire associé à cette réservation prolongée
INSERT INTO Locataire (id_resident, id_reservation) VALUES (3, (SELECT id_reservation FROM Reservation WHERE id_logement = 3 AND prolongation = TRUE));-- Ajout d’une réservation future pour tester l'impact des prolongations
INSERT INTO Reservation (debut, fin, nombre_residant, prix, prolongation, id_logement, id_resident) VALUES
('2024-01-21', '2024-01-30', 1, 600.00, FALSE, 3, 1);-- Ajout d'un logement qui respecte les critères de la requête
INSERT INTO Logement (nom, capacite, entretien_requis, prix_hebdomadaire, nb_de_fois_reservee, note) VALUES
('Maison Paris 2', 3, FALSE, 500.00, 0, 4.0);-- Lier ce logement à un type qui est une maison
INSERT INTO Caracteriser (id_logement, id_type) VALUES
((SELECT id_logement FROM Logement WHERE nom = 'Maison Paris 2'), 1);-- Ajouter la localisation de ce logement à Paris
INSERT INTO Localisation (id_logement, id_lieu) VALUES
((SELECT id_logement FROM Logement WHERE nom = 'Maison Paris 2'), 1);
INSERT INTO Reservation (debut, fin, nombre_residant, prix, prolongation, id_logement, id_resident)
VALUES ('2025-03-01', '2025-03-10', 2, 800.00, FALSE, 2, 3),
('2024-02-01', '2024-02-15', 1, 600.00, FALSE,(SELECT id_logement FROM Logement WHERE nom = 'Appartement Paris'),(SELECT id_resident FROM Resident WHERE nom = 'Durand' AND prenom = 'Alice')),
('2024-02-05', '2024-02-20', 1, 600.00, FALSE,(SELECT id_logement FROM Logement WHERE nom = 'Appartement Paris'),(SELECT id_resident FROM Resident WHERE nom = 'Martin' AND prenom = 'Lucas')),
('2024-02-10', '2024-02-25', 1, 600.00, FALSE,(SELECT id_logement FROM Logement WHERE nom = 'Appartement Paris'),(SELECT id_resident FROM Resident WHERE nom = 'Bernard' AND prenom = 'Sophie'));