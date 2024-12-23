-- CREATION OF TABLES --

CREATE TABLE "user" (
    userid SERIAL PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    username VARCHAR(255),
    "password" VARCHAR(255) NOT NULL
);

CREATE TABLE shelter (
    shelterid SERIAL PRIMARY KEY,
    managed_by INT,
    email VARCHAR(255) UNIQUE NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "password" VARCHAR(255) NOT NULL,
    "address" VARCHAR(255) NOT NULL,
    city VARCHAR(100),
    postal_code INT NOT NULL,
    photo VARCHAR(255),
    description VARCHAR(255),
    "status" VARCHAR(9) NOT NULL CHECK (status IN ('Pending', 'Approved', 'Rejected'))
);

CREATE TABLE pet (
    petid SERIAL PRIMARY KEY,
    "name" VARCHAR(255) NOT NULL,
    race VARCHAR(70),
    shelterid INT NOT NULL,
    type VARCHAR(255),
    gender VARCHAR(10) CHECK (gender IN ('Male', 'Female', 'Unknown')),
    age INT,
    date_added TIMESTAMP,
    photo VARCHAR(255),
    description VARCHAR(255),
    FOREIGN KEY (shelterid) REFERENCES shelter(shelterid) ON DELETE CASCADE
);

CREATE TABLE pet_behavior (
    petid INT,
    userid INT,
    behaviorid SERIAL PRIMARY KEY,
    behavior VARCHAR(255),
    FOREIGN KEY (petid) REFERENCES pet(petid) ON DELETE CASCADE,
    FOREIGN KEY (userid) REFERENCES "user"(userid) ON DELETE CASCADE
);

CREATE TABLE moderator (
    modid SERIAL PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    username VARCHAR(255),
    "password" VARCHAR(255) NOT NULL
);

CREATE TABLE favorite (
    petid INT,
    userid INT,
    PRIMARY KEY (petid, userid),
    FOREIGN KEY (petid) REFERENCES pet(petid) ON DELETE CASCADE,
    FOREIGN KEY (userid) REFERENCES "user"(userid) ON DELETE CASCADE
);


-- MOCK DATA --
--
INSERT INTO "user" (email, username, "password") VALUES 
('user1@gmail.com', 'user1', '$2a$10$TxcmfrY7qJkpSRsyybQDwu3gPJdKuckdF1nmQDuMZRbqXTVBP4g1e'),
('user2@gmail.com', 'user2', '$2a$10$ijbV39slbGLqzlnHPLTag.xwDuarrcMNvcDBfSQWIp3ONGXtToqeO');
-- Mock data for the moderator table
INSERT INTO moderator (email, username, "password") VALUES
('moderator@gmail.com', 'moderator', '$2b$10$LBtK0B0.PEIhnbC5jTiGPuByCvtLQFFvmSERAmSZrxErlldZhF5Wq');
--('moderator2@gmail.com', 'moderator2', '$2b$10$EFtxG8UcLBwbLI9yyrD3c.fABrO3yBHCXj4NUwytZuUIWunqmH50S');--

-- Mock data for the shelter table

INSERT INTO shelter (email, managed_by, "name", "password", "address", city, postal_code, "status", photo, description) VALUES
('shelter1@example.com', 1, 'Sunny Shelter', '$2a$10$IvwJDtrvlXHOJDuvQA/LouLkRV/gQgjqs6Yu72l10g9WFlV9iXhNS', 'Sonderbo 23', 'Copenhagen', '1000', 'Approved', './assets/shelter1.jpg', 'Description of shelter 1'),
('shelter2@example.com', 1, 'Dansk dyreværn Århus', '$2a$10$4s9rBJli64BmSbWt9KHfjOM2QSB.u3fO5U3CeMnkD8q6EqvHToPkW', 'Tingskoven 5', 'Aarhus', '2000', 'Approved','./assets/shelter2.jpg', 'Description of shelter 2'),
('shelter3@example.com', 1, 'Dyrenes beskyttelse', '$2a$10$88SVNiRZ.ZDNniowWNWnNebtEJbAzmzqJmkEpREkHVIiND7PzzYny', 'Darupvej 131', 'Roskilde', '4000', 'Approved', './assets/shelter3.jpg', 'Description of shelter 3'),
('shelter4@example.com', 1, 'Tøstrup kattehjem & dyrevaern', '$2a$10$BIE9G.WFlbFV3Y8s2qYt0emb.DQ5TapgdjNHzD1oF/jAHSZFOsEYO', 'Sjørupgårdvej 15', 'Tøstrup', '8581', 'Approved','./assets/shelter4.jpg', 'Description of shelter 4'),
('shelter5@example.com', 1, 'Fulglebjerg internat', '$2a$10$VByK.0p6z32jHRFIPRICu.Zb4BORGx3XPgDvZ0jiCJD4yVC9cy2Wm', 'Sandvedvej 36', 'Fuglebjerg', '4250', 'Pending', './assets/shelter5.jpg', 'Description of shelter 5'),
('shelter6@example.com', 1, 'Fyns internat', '$2a$10$YSIUKztAM8CAcLzdrOO7wehXcL/LMuCBCAVGBIwOEXjg7X6h9wpCC', 'Store Landevej 33', 'Ejby', '5592', 'Pending', './assets/shelter6.jpg', 'Description of shelter 6'),
('shelter7@example.com', 1, 'Inges Kattehjem', '$2a$10$rnvSZOSMiFKEJKdbgk.kTuuyBM2YZrxk/GIH93Uk9OOFU.oJG4csW', 'Ejbydalsvej 260', 'Glostrup', '2600', 'Pending', './assets/shelter7.jpg', 'Description of shelter 7'),
('shelter8@example.com', 1, 'Pindsvinevennerne i Danmark', '$2a$10$jLFVgBx2MAvcIcPJJsSfCumYDIpHG3ESyH63fd9O6yeAnsNIIC.zG', 'Harekærgårdsvej 7', 'Kirke Hyllinge', '4070', 'Rejected', './assets/shelter8.jpg', 'Description of shelter 8');



-- Mock data for the pet table
INSERT INTO pet (shelterid, "name", type, race, gender, age, date_added, photo, description) VALUES
-- Pets for Shelter 1
(1, 'Snowball', 'cat', 'Smart', 'Male', 2, '2024-06-01 10:00:00', './assets/pets/snowball.jpg', 'Description of pet Snowball'),
(1, 'Mittens', 'cat', 'Curious', 'Male', 1, '2024-07-15 11:30:00', './assets/pets/kocurek.jpg', 'Description of pet Mittens'), 
(1, 'Ryszard', 'parrot', 'Sociable', 'Male', 3, '2024-08-20 12:00:00', './assets/pets/ryszard.jpg', 'Description of pet Ryszard'), 
(1, 'Whiskers', 'cat', 'Calm', 'Male', 1, '2024-09-05 14:00:00', './assets/pets/koteczka.jpg', 'Description of pet Whiskers'), 
(1, 'Maciej', 'dog', 'Elegant', 'Male', 5, '2024-10-10 15:15:00', './assets/pets/maciej.jpg', 'Description of pet Maciej'), 


-- Pets for Shelter 2
(2, 'Jumbo', 'hedgehog', 'Playful', 'Male', 2, '2024-12-10 19:30:00', './assets/pets/jumbo.jpg', 'Description of pet Jumbo'),
(2, 'Tiger', 'cat', 'Male', 'Male', 1, '2024-12-05 18:00:00', './assets/pets/kocurek2.jpg', 'Description of pet Tiger'), 
(2, 'Lily', 'cat', 'Cautious', 'Female', 1, '2024-12-08 19:00:00', './assets/pets/koteczka2.jpg', 'Description of pet Lily'),
(2, 'Sadie', 'dog', 'Fearful', 'Female', 3, '2024-11-20 16:00:00', './assets/pets/tomasz.jpg', 'Description of pet Sadie'), 
(2, 'Buddy', 'dog','Chihuahua', 'Male', 3, '2024-10-01 17:00:00','./assets/pets/robert.jpg','Description of pet Buddy'),

-- Pets for Shelter 3
(3, 'Bailey', 'parrot','blue parrot', 'Unknown', 4, '2024-11-01 18:15:00','./assets/pets/parot.jpg', 'Description of pet Bailey'),
(3, 'Mira', 'dog','Shiba Inu', 'Female', 8, '2024-12-01 19:30:00','./assets/pets/mira.JPG','Description of pet Mira'),
(3, 'Baloo', 'dog','Staffy', 'Male', 5, '2024-01-15 08:30:00','./assets/pets/baloo.jpg','Description of pet Baloo'),
(3, 'Ruby', 'dog','Corgi', 'Female', 3, '2024-02-05 09:00:00','./assets/pets/sadCorgi.jpg','Description of pet Ruby'),
(3, 'Finn', 'dog','Dachshund', 'Male', 2, '2024-03-10 10:15:00','./assets/pets/dachshund.jpg','Description of pet Finn'),

-- Pets for Shelter 4
(4, 'Mittens', 'cat','Maine Coon', 'Male', 1, '2024-04-25 11:45:00','./assets/pets/mittens.jpg','Description of pet Mittens'),
(4, 'Hampter', 'chamster','Hampter', 'Male', 6, '2024-05-30 12:00:00','./assets/pets/hamper.png','Description of pet Hampter'),
(4, 'Pawel', 'parrot','green parrot', 'Female', 3, '2024-06-20 13:30:00','./assets/pets/parrot.jpg','Description of pet Pawel'),
(4, 'Chloe', 'dog','Pug', 'Female', 4, '2024-07-05 14:45:00','./assets/pets/sadPug.jpg','Description of pet Chloe'),
(4, 'Toby','dog' ,'Yorkshire Terrier', 'Male', 5, '2024-08-01 15:00:00','./assets/pets/yorkshire.jpg','Description of pet Toby'),


-- Pets for Shelter 5
(5, 'Oliver', 'dog','British Shorthair', 'Male', 7, '2024-09-15 16:00:00','./assets/pets/goodBoy.jpg', 'Description of pet Oliver'),
(5, 'Midi', 'Squirrel','regular squirrel', 'Female', 4, '2024-10-10 17:30:00','./assets/pets/squirel.jpg', 'Description of pet Squrwiel'),
(5, 'Martin', 'cat','Burmese', 'Male', 11, '2024-11-20 18:00:00','./assets/pets/martin.jpg' ,'Description of pet Martin'),
(5, 'Penny', 'dog','Basset Hound', 'Female', 4, '2024-12-05 19:00:00','./assets/pets/bassetHound.png','Description of pet Penny'),
(5, 'Semjon', 'cat','Oriental Shorthair', 'Male', 2, '2024-01-20 08:30:00','./assets/pets/semjon.JPG','Description of pet Semjon');


-- Updated mock data for the behavior table with 15 unique behaviors
INSERT INTO pet_behavior (petid, behavior) VALUES
(1, 'Playful'),
(1, 'Energetic'),
(1, 'Friendly'),
(2, 'Energetic'),
(2, 'Playful'),
(2, 'Curious'),
(3, 'Friendly'),
(3, 'Calm'),
(3, 'Loyal'),
(4, 'Shy'),
(4, 'Curious'),
(4, 'Gentle'),
(5, 'Curious'),
(5, 'Friendly'),
(5, 'Relaxed'),
(6, 'Loyal'),
(6, 'Protective'),
(6, 'Energetic'),
(7, 'Energetic'),
(7, 'Playful'),
(7, 'Obedient'),
(8, 'Independent'),
(8, 'Shy'),
(8, 'Calm'),
(9, 'Calm'),
(9, 'Gentle'),
(9, 'Reserved'),
(10, 'Protective'),
(10, 'Loyal'),
(10, 'Adventurous'),
(11, 'Affectionate'),
(11, 'Gentle'),
(11, 'Cuddly'),
(12, 'Gentle'),
(12, 'Calm'),
(12, 'Friendly'),
(13, 'Playful'),
(13, 'Energetic'),
(13, 'Lively'),
(14, 'Alert'),
(14, 'Protective'),
(14, 'Curious'),
(15, 'Energetic'),
(15, 'Lively'),
(15, 'Adventurous'),
(16, 'Friendly'),
(16, 'Curious'),
(16, 'Playful'),
(17, 'Relaxed'),
(17, 'Calm'),
(17, 'Obedient'),
(18, 'Loyal'),
(18, 'Gentle'),
(18, 'Cuddly'),
(19, 'Obedient'),
(19, 'Protective'),
(19, 'Adventurous'),
(20, 'Adventurous'),
(20, 'Sociable'),
(20, 'Playful'),
(21, 'Adventurous'),
(21, 'Playful'),
(21, 'Lively'),
(22, 'Calm'),
(22, 'Shy'),
(22, 'Independent'),
(23, 'Reserved'),
(23, 'Calm'),
(23, 'Loyal'),
(24, 'Cuddly'),
(24, 'Playful'),
(24, 'Affectionate'),
(25, 'Active'),
(25, 'Energetic'),
(25, 'Alert');




