CREATE DATABASE IF NOT EXISTS datos_autos;
USE datos_autos;

--USER TABLE

CREATE TABLE IF NOT EXISTS user(
    id                  INT AUTO_INCREMENT NOT NULL,
    name                VARCHAR(50) NOT NULL,
    email               VARCHAR(150),
    password            VARCHAR(150) NOT null,
    created_at          datetime,
    updated_at          datetime,
    CONSTRAINT pk_user PRIMARY KEY (id)
)ENGINE=InnoDB;


--STREET TABLE

CREATE TABLE IF NOT EXISTS street(
    id                      INT AUTO_INCREMENT NOT NULL,
    name                    VARCHAR(50) NOT NULL,
    created_at              datetime,
    updated_at              datetime,
    CONSTRAINT pk_street    PRIMARY KEY (id)
)ENGINE=InnoDB;


--CAR'S IDENTIFICATION
CREATE TABLE IF NOT EXISTS car_ident(
    id                      INT AUTO_INCREMENT NOT NULL,
    enrollment              VARCHAR(200) NOT NULL,
    created_at              datetime,
    updated_at              datetime,
    CONSTRAINT pk_car_ident PRIMARY KEY (id)
)ENGINE=InnoDB;


--DATA
CREATE TABLE IF NOT EXISTS parking(
    id                      INT AUTO_INCREMENT NOT NULL,
    car_ident_fk            INT,
    street_fk               int,
    created_at              datetime,
    updated_at              datetime,
    CONSTRAINT pk_parking PRIMARY KEY (id),
    CONSTRAINT fk_parking_car_ident FOREIGN KEY(car_ident_fk) REFERENCES car_ident(id),
    CONSTRAINT fk_parking_street    FOREIGN KEY(street_fk) REFERENCES street(id)
)ENGINE=InnoDB;