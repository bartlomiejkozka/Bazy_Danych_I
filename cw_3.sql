/*3-a-b-c-d*/
/*CREATE TABLE rozliczenia.pracownicy(
	id_pracownika INTEGER PRIMARY KEY,
	imie VARCHAR(20) NOT NULL,
	nazwisko VARCHAR(20) NOT NULL,
	adres VARCHAR(30),
	telefon VARCHAR(15)
	);*/
	
/*CREATE TABLE rozliczenia.godziny(
id_godziny VARCHAR(10),
data DATE,
liczba_godzin INTEGER,
id_pracownika INT,
FOREIGN KEY(id_pracownika) REFERENCES rozliczenia.pracownicy(id_pracownika)
);*/

/*CREATE TABLE rozliczenia.premie(
id_premii INTEGER PRIMARY KEY,
rodzaj VARCHAR(20),
kwota NUMERIC(5,2)
);*/

/*CREATE TABLE rozliczenia.pensje(
id_pensji INTEGER PRIMARY KEY,
stanowisko VARCHAR(20),
kwota DECIMAL(5,2),
id_premii INT,
FOREIGN KEY(id_premii) REFERENCES rozliczenia.premie(id_premii)
);*/

/*==========================================================*/

/*4*/
/*INSERT INTO rozliczenia.pracownicy(id_pracownika, imie, nazwisko, adres, telefon)
VALUES (1, 'Bartek', 'Kozka', 'Zabieniec Krakow', '+48 607551824'),
	(2, 'Kacper', 'Fido', 'Zabieniec Krakow', '+48 834244234'),
	(3, 'Kuba', 'Stasz', 'Prondnicka Krakow', '+48 666666666'),
	(4, 'Antek', 'Kowal', 'Kawowa Warszawa', '+48 999999999'),
	(5, 'Robert', 'Lewandowski', 'Klubowa Krakow', '+48 845235345'),
	(6, 'Ludiwk', 'Boski', 'Jasna Warszawa', '+48 345345345'),
	(7, 'Szymon', 'Nowakowski', 'Biała Krakow', '+48 123456789'),
	(8, 'Bro', 'Code', 'Zlota Warszawa', '+48 555666777'),
	(9, 'Wiktor', 'Lambda', 'Filokowa Krakow', '+48 111222333'),
	(10, 'Ola', 'Janas', 'Krowodrza Krakow', '+48 449903274');*/
/*SELECT * FROM rozliczenia.pracownicy*/

/*INSERT INTO rozliczenia.godziny(id_godziny, data, liczba_godzin, id_pracownika)
VALUES (1, '10/02/2022', 140, 10),
	(2, '11/23/2021', 122, 7),
	(3, '8/19/2020', 150, 6),
	(4, '9/12/2021', 100, 1),
	(5, '11/01/2020', 98, 2),
	(6, '10/10/2023', 151, 4),
	(7, '1/22/2022', 74, 3),
	(8, '12/12/2020', 191, 9),
	(9, '01/09/2023', 111, 8),
	(10, '9/06/2023', 116, 5);*/
/*SELECT * FROM rozliczenia.godziny;*/

/*ALTER TABLE rozliczenia.pensje
ALTER COLUMN kwota TYPE DECIMAL(7,2);*/

/*ALTER TABLE rozliczenia.premie
ALTER COLUMN kwota TYPE DECIMAL(6,2)*/

/*ALTER TABLE rozliczenia.premie
ALTER COLUMN rodzaj TYPE VARCHAR(50);*/

/*INSERT INTO rozliczenia.premie(id_premii, rodzaj, kwota)
VALUES (1, 'Bonus Uznaniowy', 600.00),
	(2, 'Bonus Powitalny', 400.00),
	(3, 'Home office bonus', 1000.00),
	(4, 'Bonus Rocznicowy', 1500.00),
	(5, 'Bonus Okolicznosciowy', 900.00),
	(6, 'Bonus za polecenie', 200.00),
	(7, 'Bonus Swiateczny', 700.00),
	(8, 'Peer-to-peer', 300.00),
	(9, 'Bonus Szkoleniowy', 500.00),
	(10, 'Podzial Zyskow', 100.00);*/
/*SELECT * FROM rozliczenia.premie;*/

/*INSERT INTO rozliczenia.pensje(id_pensji, stanowisko, kwota, id_premii)
VALUES (1, 'Junior Developer', 6000.00, 10),
	(2, 'Mid Developer', 8000.00, 1),
	(3, 'Senior Developer', 10000.00, 9),
	(4, 'Team Leader', 15000.00, 7),
	(5, 'CEO', 16000.00, 2),
	(6, 'Junior Developer', 6000.00, 3),
	(7, 'Senior Developer', 10000.00, 4),
	(8, 'Mid Developer', 8000.00, 8),
	(9, 'Mid Developer', 8000.00, 5),
	(10, 'Junior Developer', 6000.00, 6);*/
/*SELECT * FROM rozliczenia.pensje;*/
/*SELECT * FROM rozliczenia.premie*/

/*UPDATE rozliczenia.pensje
SET id_premii = 4
WHERE id_pensji = 5;*/

/*UPDATE rozliczenia.pensje
SET id_premii = 1
WHERE id_pensji = 6;*/

/*==========================================================*/

/*5.*/
/*SELECT nazwisko, adres FROM rozliczenia.pracownicy;*/

/*==========================================================*/

/*6.*/
/*SELECT id_godziny, date_part('day', data) AS day, date_part('month', data) AS month, liczba_godzin, id_pracownika
FROM rozliczenia.godziny;*/

/*==========================================================*/

/*7*/
/*ALTER TABLE rozliczenia.pensje
RENAME COLUMN kwota TO kwota_brutto;*/

/*ALTER TABLE rozliczenia.pensje
ADD COLUMN kwota_netto DECIMAL(7,2);
SELECT * FROM rozliczenia.pensje;*/

/*UPDATE rozliczenia.pensje
SET kwota_netto = kwota_brutto/1.23
WHERE kwota_netto IS null;*/

/*SELECT * FROM rozliczenia.pensje;*/
