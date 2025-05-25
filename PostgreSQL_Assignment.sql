CREATE DATABASE conservation_db ;

CREATE TABLE rangers (
    ranger_id SERIAL PRIMARY key ,
    name  VARCHAR(50) ,
    region  VARCHAR(50)
);

INSERT INTO rangers ( name, region)
VALUES
( 'Alice Green', 'Northern Hills'),
( 'Bob White', 'River Delta'),
( 'Carol King', 'Mountain Range');

SELECT * FROM rangers ;
-- DROP TABLE rangers;

CREATE TABLE species (
    species_id SERIAL PRIMARY KEY ,
    common_name  VARCHAR(100) NOT NULL ,
    scientific_name   VARCHAR(100) NOT NULL,
    discovery_date DATE NOT NULL,
    conservation_status VARCHAR(50) NOT NULL

);


INSERT INTO species (common_name, scientific_name, discovery_date, conservation_status)
VALUES 
('Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
('Bengal Tiger', 'Panthera tigris tigris', '1758-01-01', 'Endangered'),
('Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
('Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered');


SELECT * FROM species;

-- DROP TABLE species;


CREATE TABLE sightings (
    sighting_id SERIAL PRIMARY KEY ,
    species_id INT NOT NULL,
    ranger_id INT NOT NULL ,
    location VARCHAR(100) NOT NULL,
    
    sighting_time TIMESTAMP NOT NULL,
   
    notes TEXT ,
    Foreign Key (ranger_id) REFERENCES rangers (ranger_id),
    Foreign Key (species_id) REFERENCES species (species_id)

);

INSERT INTO sightings (sighting_id, species_id, ranger_id, location, sighting_time, notes)
VALUES 
(1, 1, 1, 'Peak Ridge', '2024-05-10 07:45:00', 'Camera trap image captured'),
(2, 2, 2, 'Bankwood Area', '2024-05-12 16:20:00', 'Juvenile seen'),
(3, 3, 3, 'Bamboo Grove East', '2024-05-15 09:10:00', 'Feeding observed'),
(4, 1, 2, 'Snowfall Pass', '2024-05-18 18:30:00', NULL);

SELECT * FROM sightings ;
-- DROP TABLE sightings ;




#1 

INSERT INTO rangers(name ,region) VALUES ('Derek Fox' , 'Coastal Plains');

#2
SELECT count(DISTINCT species_id ) AS unique_species_count FROM sightings ;

#3

SELECT * FROM sightings  WHERE location LIKE '%Pass%' ;


#4
SELECT ranger.name, COUNT(sight.sighting_id) AS total_sightings
     FROM  rangers ranger
     LEFT JOIN sightings sight ON ranger.ranger_id = sight.ranger_id 
     GROUP BY ranger.name ORDER BY ranger.name;


#5 

SELECT sight.common_name FROM species sight 
   LEFT JOIN sightings si ON sight.species_id =si.species_id
   WHERE si.species_id IS NULL;


#6
SELECT 
    spec.common_name,
    sight.sighting_time,
    ranger.name
FROM 
    sightings sight
JOIN 
    species spec ON sight.species_id = spec.species_id
JOIN 
    rangers ranger ON sight.ranger_id = ranger.ranger_id
ORDER BY 
    sight.sighting_time DESC
LIMIT 2;


#7
UPDATE species SET conservation_status = 'Historic'
  WHERE discovery_date < '1800-01-01';



#8
SELECT 
    sighting_id,
    CASE 
        WHEN EXTRACT(HOUR FROM sighting_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sighting_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS time_of_day
FROM 
    sightings;


#9
DELETE FROM rangers
 WHERE ranger_id NOT IN (
    SELECT DISTINCT ranger_id FROM sightings
);



