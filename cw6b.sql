/*a*/
/*UPDATE rozliczenia.pracownicy
SET telefon = CONCAT('(+48) ', telefon);*/

/*b*/
/*UPDATE rozliczenia.pracownicy
SET telefon = CONCAT_WS('-',SUBSTRING(telefon, 7, 3), SUBSTRING(telefon, 10, 3), SUBSTRING(telefon, 13, 3));*/

/*c*/
/*SELECT * FROM rozliczenia.pracownicy
WHERE LENGTH(UPPER(nazwisko)) = (SELECT MAX(LENGTH(UPPER(nazwisko))) FROM rozliczenia.pracownicy);*/

/*d*/
SELECT wynagrodzenie.id_pracownika, MD5(pracownicy.imie) AS "imie pracownika",
		MD5(pracownicy.nazwisko) AS "nazwisko", MD5(pracownicy.adres) AS "adres",
		MD5(pracownicy.telefon) AS "numer tel", pensje.kwota
FROM rozliczenia.wynagrodzenie
INNER JOIN rozliczenia.pracownicy ON wynagrodzenie.id_pracownika = pracownicy.id_pracownika
INNER JOIN rozliczenia.pensje ON wynagrodzenie.id_pensji = pensje.id_pensji
ORDER BY pracownicy.id_pracownika;

/*f*/
SELECT wynagrodzenie.id_pracownika, pracownicy.imie, pracownicy.nazwisko, pensje.kwota, premie.kwota FROM rozliczenia.wynagrodzenie
LEFT JOIN rozliczenia.pracownicy ON wynagrodzenie.id_pracownika = pracownicy.id_pracownika
LEFT JOIN rozliczenia.pensje ON wynagrodzenie.id_pensji = pensje.id_pensji
LEFT JOIN rozliczenia.premie ON wynagrodzenie.id_premii = premie.id_premii
ORDER BY pracownicy.id_pracownika;

/*g*/
/*przyjąłem iż nagdzoiny są od 160 godzin w górę*/
SELECT 'Pracownik ' || pracownicy.imie || ', w dniu ' || wynagrodzenie.data || ' otrzymał pensje całkowitą na kwotę '
		|| (pensje.kwota + COALESCE(premie.kwota, 0)) || ' zł, gdzie wynagrodzenie zasadnicze wynosiło: ' || pensje.kwota
		|| ' zł, premia: ' || COALESCE(premie.kwota, 0) || ' zł, nadgodziny: ' || 
		CASE
			WHEN godziny.liczba_godzin - 160 > 0 THEN (godziny.liczba_godzin - 160) * (pensje.kwota/godziny.liczba_godzin) || ' zł'
			ELSE 'brak nadgodzin'
		END
AS raport
FROM rozliczenia.wynagrodzenie
LEFT JOIN rozliczenia.pracownicy ON wynagrodzenie.id_pracownika = pracownicy.id_pracownika
LEFT JOIN rozliczenia.premie ON wynagrodzenie.id_premii = premie.id_premii
LEFT JOIN rozliczenia.pensje ON wynagrodzenie.id_pensji = pensje.id_pensji
LEFT JOIN rozliczenia.godziny ON wynagrodzenie.id_godziny = godziny.id_godziny
ORDER BY pracownicy.id_pracownika;



