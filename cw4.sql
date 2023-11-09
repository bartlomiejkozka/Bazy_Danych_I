/*CREATE TABLE rozliczenia.pracownicy(
	id_pracownika INT GENERATED ALWAYS AS IDENTITY,
	imie VARCHAR(20) NOT NULL,
	nazwisko VARCHAR(20) NOT NULL,
	adres VARCHAR(50),
	telefon VARCHAR(15),
	PRIMARY KEY(id_pracownika)
);*/

/*INSERT INTO rozliczenia.pracownicy(imie, nazwisko, adres, telefon)
VALUES ('Bartek', 'Kozka', 'Zabieniec Krakow', '+48 607551824'),
	('Kacper', 'Fido', 'Zabieniec Krakow', '+48 834244234'),
	('Kuba', 'Stasz', 'Prondnicka Krakow', '+48 666666666'),
	('Antek', 'Kowal', 'Kawowa Warszawa', '+48 999999999'),
	('Robert', 'Lewandowski', 'Klubowa Krakow', '+48 845235345'),
	('Ludiwk', 'Boski', 'Jasna Warszawa', '+48 345345345'),
	('Szymon', 'Nowakowski', 'Biała Krakow', '+48 123456789'),
	('Bro', 'Code', 'Zlota Warszawa', '+48 555666777'),
	('Wiktor', 'Lambda', 'Filokowa Krakow', '+48 111222333'),
	('Ola', 'Janas', 'Krowodrza Krakow', '+48 449903274');*/
	
	
/*CREATE TABLE rozliczenia.godziny(
	id_godziny INT GENERATED ALWAYS AS IDENTITY,
	data DATE,
	liczba_godzin INT,
	id_pracownika INT,
	PRIMARY KEY(id_godziny),
	FOREIGN KEY(id_pracownika) REFERENCES rozliczenia.pracownicy(id_pracownika)
);*/

/*ALTER TABLE rozliczenia.godziny
ALTER COLUMN liczba_godzin SET NOT NULL;*/

/*ALTER TABLE rozliczenia.godziny
ALTER COLUMN id_pracownika SET NOT NULL;*/

/*ALTER TABLE rozliczenia.godziny
ALTER COLUMN data SET NOT NULL;*/


/*INSERT INTO rozliczenia.godziny(data, liczba_godzin, id_pracownika)
VALUES ('2023-10-02', 140, 10),
	('2023-10-05', 122, 7),
	('1023-10-01', 150, 6),
	('2023-10-10', 100, 1),
	('2023-10-11', 98, 2),
	('2023-10-01', 151, 4),
	('2023-10-13', 74, 3),
	('2023-10-01', 191, 9),
	('2023-10-05', 111, 8),
	('2023-10-04', 116, 5);*/
	
/*COMMENT ON COLUMN rozliczenia.godziny.data IS 'Klumna data zawiera datę rozpoczęcia pracy przez danego pracownika w miesiącu';*/


/*CREATE TABLE rozliczenia.pensje(
	id_pensji INT GENERATED ALWAYS AS IDENTITY,
	stanowisko VARCHAR(30) NOT NULL,
	kwota NUMERIC(7,2) NOT NULL,
	PRIMARY KEY(id_pensji)
);*/

/*INSERT INTO rozliczenia.pensje(stanowisko, kwota)
VALUES ('Junior Developer', 5000.00),
	('Mid Developer', 10000.00),
	('Senior Developer', 15000.00),
	('Fronted Developer', 16000.00),
	('Backend Developer', 17000.00),
	('Fullstack Developer', 18000.00),
	('Team Leader', 20000.00),
	('Tester Oprogramowania', 22000.00),
	('Wdrożeniowiec', 25000.00),
	('DevOps Engineer', 30000.00);*/


/*CREATE TABLE rozliczenia.premie(
	id_premii INT GENERATED ALWAYS AS IDENTITY,
	rodzaj VARCHAR(50) NOT NULL,
	kwota NUMERIC(6,2),
	PRIMARY KEY(id_premii)
);*/

/*INSERT INTO rozliczenia.premie(rodzaj, kwota)
VALUES ('Podzial Zyskow', 100.00),
	('Bonus Powitalny', 300.00),
	('Home office bonus', 500.00),
	('Bonus Rocznicowy', 700.00),
	('Bonus Okolicznosciowy', 1000.00),
	('Bonus za polecenie', 1100.00),
	('Bonus Swiateczny', 1200.00),
	('Peer-to-peer', 1300.00),
	('Bonus Szkoleniowy', 1500.00),
	('Bonus Uznaniowy', 2000.00);*/
	

/*CREATE TABLE rozliczenia.wynagrodzenie(
	id_wynagrodzenia INT GENERATED ALWAYS AS IDENTITY,
	data DATE NOT NULL,
	id_pracownika INT NOT NULL,
	id_godziny INT NOT NULL,
	id_pensji INT NOT NULL,
	id_premii INT,
	PRIMARY KEY(id_wynagrodzenia),
	FOREIGN KEY(id_pracownika) REFERENCES rozliczenia.pracownicy(id_pracownika),
	FOREIGN KEY(id_godziny) REFERENCES rozliczenia.godziny(id_godziny),
	FOREIGN KEY(id_pensji) REFERENCES rozliczenia.pensje(id_pensji),
	FOREIGN KEY(id_premii) REFERENCES rozliczenia.premie(id_premii)
);*/



/*INSERT INTO rozliczenia.wynagrodzenie(data, id_pracownika, id_godziny, id_pensji, id_premii)
VALUES ('2023-11-01', 10, 1, 1, 8),
		('2023-11-01', 7, 2, 2, 5),
		('2023-11-01', 6, 3, 3, 9),
		('2023-11-01', 1, 4, 4, NULL),
		('2023-11-01', 2, 5, 5, 1),
		('2023-11-05', 4, 6, 6, 9),
		('2023-11-05', 3, 7, 7, NULL),
		('2023-11-05', 9, 8, 8, 10),
		('2023-11-05', 8, 9, 9, 6),
		('2023-11-05', 5, 10, 10, NULL);*/
		

/*COMMENT ON TABLE rozliczenia.wynagrodzenie IS 'Tabela wynagrodzenie wyświetla zetawienie wszytkich kosztów jakie otrzyma pracownik na koniec miesiąca.';
COMMENT ON COLUMN rozliczenia.wynagrodzenie.data IS 'Kolumna data zawiera daty kiedy dany pracownik jest rozliczany za poprzedni miesiąc';*/




/*=================ZAPYTANIA====================*/

/*a*/
SELECT id_pracownika, nazwisko FROM rozliczenia.pracownicy;

/*b*/
SELECT id_pracownika, SUM(pensje.kwota + COALESCE(premie.kwota, 0)) placa
FROM rozliczenia.wynagrodzenie 
INNER JOIN rozliczenia.pensje ON wynagrodzenie.id_pensji = pensje.id_pensji
LEFT JOIN rozliczenia.premie ON wynagrodzenie.id_premii = premie.id_premii
GROUP BY id_pracownika
HAVING SUM(pensje.kwota + COALESCE(premie.kwota, 0)) > 1000.00
ORDER BY id_pracownika;

/*c*/
SELECT id_pracownika
FROM rozliczenia.wynagrodzenie
INNER JOIN rozliczenia.pensje ON wynagrodzenie.id_pensji = pensje.id_pensji
LEFT JOIN rozliczenia.premie ON wynagrodzenie.id_premii = premie.id_premii
WHERE premie.kwota IS NULL
GROUP BY id_pracownika
HAVING SUM(pensje.kwota + COALESCE(premie.kwota, 0)) > 2000.00
ORDER BY id_pracownika;

/*d*/
SELECT *
FROM rozliczenia.pracownicy
WHERE imie LIKE 'J%';

/*e*/
SELECT *
FROM rozliczenia.pracownicy
WHERE nazwisko LIKE '%n%' AND imie LIKE '%a';

/*f*/
SELECT imie, nazwisko, liczba_godzin-160
FROM rozliczenia.pracownicy
INNER JOIN rozliczenia.godziny ON pracownicy.id_pracownika = godziny.id_godziny
WHERE liczba_godzin-160 > 0;

/*g*/
SELECT imie, nazwisko
FROM rozliczenia.wynagrodzenie
INNER JOIN rozliczenia.pensje ON wynagrodzenie.id_pensji = pensje.id_pensji
INNER JOIN rozliczenia.pracownicy ON wynagrodzenie.id_pracownika = pracownicy.id_pracownika
WHERE kwota > 1500 AND kwota < 3000;

/*h*/
SELECT imie, nazwisko
FROM rozliczenia.wynagrodzenie
INNER JOIN rozliczenia.pracownicy ON wynagrodzenie.id_pracownika = pracownicy.id_pracownika
INNER JOIN rozliczenia.godziny ON wynagrodzenie.id_pracownika = godziny.id_pracownika
WHERE id_premii IS NULL AND liczba_godzin > 160;

/*i*/
SELECT wynagrodzenie.id_pracownika, imie, nazwisko, kwota
FROM rozliczenia.wynagrodzenie
INNER JOIN rozliczenia.pracownicy ON wynagrodzenie.id_pracownika = pracownicy.id_pracownika
INNER JOIN rozliczenia.pensje ON wynagrodzenie.id_pensji = pensje.id_pensji
ORDER BY kwota ASC;

/*j*/
SELECT wynagrodzenie.id_pracownika, imie, nazwisko, pensje.kwota pensja, premie.kwota premia
FROM rozliczenia.wynagrodzenie
INNER JOIN rozliczenia.pracownicy ON wynagrodzenie.id_pracownika = pracownicy.id_pracownika
INNER JOIN rozliczenia.pensje ON wynagrodzenie.id_pensji = pensje.id_pensji
LEFT JOIN rozliczenia.premie ON wynagrodzenie.id_premii = premie.id_premii
ORDER BY pensje.kwota ASC, premie.kwota DESC;

/*k*/
/*INSERT INTO rozliczenia.pracownicy(imie, nazwisko, adres, telefon)
VALUES ('Bob', 'Barber', 'Krakow Amerykanska', '+48 888888888');*/
/*INSERT INTO rozliczenia.wynagrodzenie(data, id_pracownika, id_godziny, id_pensji, id_premii)
VALUES ('2023-11-05', 11, 4, 4, 4);*/
/*Dodalem rekord aby przynjamniej jedno stanowisko bylo przypisane do dwoch roznych osob aby
sprawodzic czy aby napewno funkcja COUNT dobrze zlicza*/

SELECT stanowisko, COUNT(stanowisko)
FROM rozliczenia.wynagrodzenie
INNER JOIN rozliczenia.pensje ON wynagrodzenie.id_pensji = pensje.id_pensji
GROUP BY stanowisko;

/*l*/
SELECT stanowisko, AVG(pensje.kwota+COALESCE(premie.kwota, 0)), MIN(pensje.kwota+COALESCE(premie.kwota, 0)), MAX(pensje.kwota+COALESCE(premie.kwota, 0))
FROM rozliczenia.wynagrodzenie
INNER JOIN rozliczenia.pensje ON wynagrodzenie.id_pensji = pensje.id_pensji
LEFT JOIN rozliczenia.premie ON wynagrodzenie.id_premii = premie.id_premii
GROUP BY stanowisko;

/*m*/
/*suma wszytkich wynagrodzen =? suma wszytkich płac*/

SELECT SUM(pensje.kwota+COALESCE(premie.kwota, 0)) suma_wszytkich_wynagrodzen
FROM rozliczenia.wynagrodzenie
INNER JOIN rozliczenia.pensje ON wynagrodzenie.id_pensji = pensje.id_pensji
LEFT JOIN rozliczenia.premie ON wynagrodzenie.id_premii = premie.id_premii;

/*n*/
SELECT stanowisko, SUM(pensje.kwota+COALESCE(premie.kwota, 0)) suma_wszytkich_wynagrodzen
FROM rozliczenia.wynagrodzenie
INNER JOIN rozliczenia.pensje ON wynagrodzenie.id_pensji = pensje.id_pensji
LEFT JOIN rozliczenia.premie ON wynagrodzenie.id_premii = premie.id_premii
GROUP BY stanowisko;

/*o*/
/*dodam jeszcze jeden rekord gdyż w obecnych tabelach nie ma takich przynjamnije dwóch pracowników
na tym samym stanowisku, którzy oboje dostawali by premie*/

/*INSERT INTO rozliczenia.pracownicy(imie, nazwisko, adres, telefon)
VALUES ('Kayper', 'Fade', 'Warszawa Miodowa', '+48 111111111');*/
/*INSERT INTO rozliczenia.wynagrodzenie(data, id_pracownika, id_godziny, id_pensji, id_premii)
VALUES ('2023-11-01', 12, 2, 1, 3);*/

SELECT stanowisko, COUNT(id_premii) liczba_premii
FROM rozliczenia.wynagrodzenie
INNER JOIN rozliczenia.pensje ON wynagrodzenie.id_pensji = pensje.id_pensji
GROUP BY stanowisko;

/*p*/
DELETE FROM rozliczenia.pracownicy
WHERE id_pracownika IN (SELECT id_pracownika
					   FROM rozliczenia.wynagrodzenie
					   INNER JOIN rozliczenia.pensje ON wynagrodzenie.id_pensji = pensje.id_pensji
					   WHERE kwota < 1200);
					   