-- Création de la table Type
CREATE TABLE Type (
    id_type SERIAL PRIMARY KEY,
    maison BOOLEAN DEFAULT FALSE,
    appartement BOOLEAN DEFAULT FALSE,
    meuble BOOLEAN DEFAULT FALSE,
    escalier BOOLEAN DEFAULT FALSE,
    ascenseur BOOLEAN DEFAULT FALSE,
    jardin BOOLEAN DEFAULT FALSE,
    balcon BOOLEAN DEFAULT FALSE
);-- Création de la table Logement
CREATE TABLE Logement (
    id_logement SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    capacite INT NOT NULL CHECK (capacite > 0),
    entretien_requis BOOLEAN DEFAULT FALSE,
    prix_hebdomadaire DECIMAL(10,2) NOT NULL CHECK (prix_hebdomadaire > 0),
    nb_de_fois_reservee INT DEFAULT 0,
    note DECIMAL(3,2) CHECK (note BETWEEN 0 AND 5)
);-- Création de la table Caracteriser (relation entre Logement et Type)
CREATE TABLE Caracteriser (
    id_logement INT REFERENCES Logement(id_logement) ON DELETE CASCADE,
    id_type INT REFERENCES Type(id_type) ON DELETE CASCADE,
    PRIMARY KEY (id_logement, id_type)
);-- Création de la table Resident
CREATE TABLE Resident (
    id_resident SERIAL PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    prenom VARCHAR(50) NOT NULL,
    age INT CHECK (age >= 18)
);-- Création de la table Reservation avec l'ajout de id_resident
CREATE TABLE Reservation (
    id_reservation SERIAL PRIMARY KEY,
    debut DATE NOT NULL,
    fin DATE NOT NULL,
    nombre_residant INT NOT NULL CHECK (nombre_residant > 0),
    prix DECIMAL(10,2) NOT NULL CHECK (prix > 0),
    prolongation BOOLEAN DEFAULT FALSE,
    id_logement INT REFERENCES Logement(id_logement) ON DELETE CASCADE,
    id_resident INT REFERENCES Resident(id_resident) ON DELETE CASCADE  -- Ajout de la clé étrangère
);-- Création de la table Locataire
CREATE TABLE Locataire (
    id_resident INT REFERENCES Resident(id_resident) ON DELETE CASCADE,
    id_reservation INT REFERENCES Reservation(id_reservation) ON DELETE CASCADE,
    PRIMARY KEY (id_resident, id_reservation)
);-- Création de la table Intervention
CREATE TABLE Intervention (
    id_intervention SERIAL PRIMARY KEY,
    type VARCHAR(50) NOT NULL,
    urgence VARCHAR(20) CHECK (urgence IN ('Basse', 'Moyenne', 'Élevée')),
    id_logement INT REFERENCES Logement(id_logement) ON DELETE CASCADE
);-- Création de la table Societe_exterieure
CREATE TABLE Societe_exterieure (
    id_societe SERIAL PRIMARY KEY,
    description TEXT NOT NULL
);-- Création de la table Effectuer (relation entre Intervention et Societe_exterieure)
CREATE TABLE Effectuer (
    id_intervention INT REFERENCES Intervention(id_intervention) ON DELETE CASCADE,
    id_societe INT REFERENCES Societe_exterieure(id_societe) ON DELETE CASCADE,
    PRIMARY KEY (id_intervention, id_societe)
);-- Création de la table Lieu
CREATE TABLE Lieu (
    id_lieu SERIAL PRIMARY KEY,
    pays VARCHAR(50) NOT NULL,
    ville VARCHAR(50) NOT NULL,
    adresse TEXT NOT NULL
);-- Création de la table Localisation
CREATE TABLE Localisation (
    id_logement INT REFERENCES Logement(id_logement) ON DELETE CASCADE,
    id_lieu INT REFERENCES Lieu(id_lieu) ON DELETE CASCADE,
    PRIMARY KEY (id_logement, id_lieu)
);-- Création de la table Loisir
CREATE TABLE Loisir (
    id_loisir SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL
);-- Création de la table Activite
CREATE TABLE Activite (
    id_loisir INT REFERENCES Loisir(id_loisir) ON DELETE CASCADE,
    id_resident INT REFERENCES Resident(id_resident) ON DELETE CASCADE,
    date_activite DATE NOT NULL,
    description TEXT,
    PRIMARY KEY (id_loisir, id_resident, date_activite)
);-- Création de la table Interaction
CREATE TABLE Interaction (
    id_interaction SERIAL PRIMARY KEY,
    description_interaction TEXT NOT NULL
);-- Création de la table Rencontre (interactions entre résidents)
CREATE TABLE Rencontre (
    id_resident1 INT REFERENCES Resident(id_resident) ON DELETE CASCADE,
    id_resident2 INT REFERENCES Resident(id_resident) ON DELETE CASCADE,
    id_interaction INT REFERENCES Interaction(id_interaction) ON DELETE CASCADE,
    PRIMARY KEY (id_resident1, id_resident2, id_interaction)
);