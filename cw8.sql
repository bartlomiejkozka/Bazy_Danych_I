--1.
create or replace function fibonacci(n INT)
returns SETOF INT
language plpgsql
as
$$
declare
	a INT := 0;
    b INT := 1;
    result INT;
    i INT := 0;
begin

WHILE i < n LOOP
	IF i = 0 THEN
    	result := a;
	ELSE
    	result := b;
        b := a + b;
        a := b - a;
	END IF;

	i := i + 1;
    RETURN NEXT result;
END LOOP;

end;
$$;

create or replace procedure Fibonacciii(n int)
language plpgsql
as $$
begin
SELECT * FROM fibonacci(n);
end; $$;

call Fibonacciii(10);


--2.
CREATE FUNCTION upper_function()
RETURNS TRIGGER
LANGUAGE PLPGSQL
AS $$
BEGIN
	NEW.lastname = UPPER(OLD.lastname);
	RETURN NEW;
END;
$$;

CREATE TRIGGER last_name_changes
BEFORE INSERT ON person.person
FOR EACH ROW
EXECUTE PROCEDURE upper_function();


--3.
CREATE OR REPLACE FUNCTION taxRateMonitoring()
RETURNS TRIGGER
LANGUAGE PLPGSQL
AS $$
BEGIN
	IF NEW.taxrate > 1,3 * OLD.texrate OR NEW.textrate < 1,3 * OLD.textrate THEN
	RAISE EXCEPTION 'Error: texrate change more than 30 percent!';
	END IF;
END;
$$;

CREATE OR REPLACE TRIGGER taxRateMonitoring
BEFORE UPDATE ON sales.salestaxrate
FOR EACH ROW
EXECUTE PROCEDURE taxRateMonitoring();