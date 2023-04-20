/*Kreiranje baze i tablica*/

CREATE DATABASE tvrtka;

USE tvrtka;

CREATE TABLE zaposlenici (
  id int NOT NULL AUTO_INCREMENT,
  ime varchar(100) NOT NULL,
  prezime varchar(100) NOT NULL,
  placa float NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE odjeli (
  id int NOT NULL AUTO_INCREMENT,
  ime varchar(100) NOT NULL,
  voditelj_id int NOT NULL,
  PRIMARY KEY (id),
  KEY voditelj_id (voditelj_id),
  CONSTRAINT odjeli_ibfk_1 FOREIGN KEY (voditelj_id) REFERENCES zaposlenici (id)
);

CREATE TABLE odjel_zaposlenik (
  id int NOT NULL AUTO_INCREMENT,
  odjel_id int NOT NULL,
  zaposlenik_id int NOT NULL,
  PRIMARY KEY (id),
  KEY zaposlenik_id (zaposlenik_id),
  KEY odjel_id (odjel_id),
  CONSTRAINT odjel_zaposlenik_ibfk_1 FOREIGN KEY (zaposlenik_id) REFERENCES zaposlenici (id),
  CONSTRAINT odjel_zaposlenik_ibfk_2 FOREIGN KEY (odjel_id) REFERENCES odjeli (id)
);

/*Populacija baze*/

INSERT INTO zaposlenici (ime, prezime, placa)
VALUES ('Ivo', 'Ivic', 1000),
	('Duro', 'Duric', 500),
	('Ana', 'Anic', 650),
	('Ema', 'Emic', 800),
	('Tvrtko', 'Tvrtkic', 1200);

INSERT INTO odjeli (ime, voditelj_id)
VALUES ('HR', 5),
('Development', 1),
('Sales', 4);

INSERT INTO odjel_zaposlenik (odjel_id, zaposlenik_id)
VALUES (1, 5),
(2, 1),
(3, 4),
(1, 2),
(2,3);

/*Dohvacanje zaposlenika i placa*/

SELECT ime, prezime, placa FROM zaposlenici;

/*Dohvacanje voditelja i prosjeka njihovih placa*/

SELECT AVG(zaposlenici.placa) FROM zaposlenici
INNER JOIN odjeli ON odjeli.voditelj_id = zaposlenici.id;

/*Kreiranje procedure i poziv*/

DELIMITER //

CREATE PROCEDURE ProsjekPlaca()
BEGIN
	SELECT AVG(placa) FROM zaposlenici;
END //

DELIMITER ;

CALL ProsjekPlaca();