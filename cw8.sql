--1.
create or replace function fibonacci(n int) RETURNS VOID LANGUAGE plpgsql as 
$BODY$
DECLARE
i integer := 0;
j integer := 1;
counter int := 1;
temp int;
BEGIN
	raise notice '%', i;
	if n >= 1 then
		raise notice '%', j;	
	end if;
	
	while counter < n loop
		counter := counter + 1;
		temp := i + j;
		i := j;
		j := temp;
		raise notice '%', j;
	end loop;
END;
$BODY$;


create or replace procedure fibonacci_procedure(n int) language plpgsql as
$BODY$
BEGIN
	select fibonacci(n);
END;
$BODY$;

call fibonacci_procedure(10);



--2.
CREATE or replace FUNCTION upper_function() RETURNS TRIGGER LANGUAGE PLPGSQL AS 
$BODY$
BEGIN
	NEW.lastname = UPPER(NEW.lastname);
	RETURN NEW;
END;
$BODY$;

CREATE or replace TRIGGER last_name_changes
BEFORE INSERT ON person.person
FOR EACH ROW
EXECUTE PROCEDURE upper_function();

--sparwdzenie
INSERT INTO person.person(businessentityid, persontype, firstname, lastname)
VALUES(20778, 'IN', 'Bartek', 'Kowal');

SELECT * FROM person.person;



--3.
CREATE OR REPLACE FUNCTION taxRateMonitoring() RETURNS TRIGGER LANGUAGE PLPGSQL AS 
$BODY$
BEGIN
	IF NEW.taxrate > 1.3 * OLD.taxrate OR NEW.taxrate < 0.7 * OLD.taxrate THEN
		RAISE EXCEPTION 'taxrate change more than 30 percent!';
	END IF;
	RETURN NEW;
END;
$BODY$;

CREATE OR REPLACE TRIGGER taxRateMonitoring
AFTER UPDATE ON sales.salestaxrate
FOR EACH ROW
EXECUTE PROCEDURE taxRateMonitoring();

--sprawdzenie:
UPDATE sales.salestaxrate
SET taxrate = 30
WHERE salestaxrateid = 30
RETURNING *;


	


