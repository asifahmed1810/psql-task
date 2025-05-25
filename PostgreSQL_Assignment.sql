CREATE DATABASE conservation_db ;

CREATE TABLE rangers (
    ranger_id SERIAL PRIMARY key ,
    name  VARCHAR(50) ,
    region  VARCHAR(50)
);