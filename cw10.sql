--1
BEGIN TRANSACTION;

UPDATE production.product
SET listprice = listprice + 0.1 * listprice
WHERE productid = 680;

COMMIT TRANSACTION;


--2
BEGIN TRANSACTION;

INSERT INTO production.product(productid, name, productnumber, safetystocklevel, reorderpoint,
							  standardcost, listprice, daystomanufacture, sellstartdate)
VALUES (1000, 'Air-pods-max', 'AR-01', 100, 75, 1799.99, 2499.99, 1, '2024-01-01 00:00:00');

COMMIT TRANSACTION;


--3
BEGIN TRANSACTION;

DELETE FROM production.product WHERE productid = 1000;

ROLLBACK;


--4
DO $$
DECLARE
    sum_all NUMERIC;
BEGIN
    UPDATE production.product
    SET standardcost = standardcost + 0.1 * standardcost;
	
	SELECT SUM(standardcost) into sum_all from production.product;

    IF sum_all >= 50000 THEN
        RAISE EXCEPTION 'Sum over than 50000 ==> rollback transaction'; --zamiast rollback
    END IF;
END $$;


--5
do $$
declare
	prnum varchar(10);
	tempp varchar(10);
begin
insert into production.product(productid, name, productnumber, safetystocklevel, reorderpoint,
							  standardcost, listprice, daystomanufacture, sellstartdate)
values (1008, 'Air-pods-max', 'AR-5381', 100, 75, 1799.99, 2499.99, 1, '2024-01-01 00:00:00');

select productnumber into prnum from production.product order by modifieddate desc limit 1;
select productnumber from production.product where productnumber = prnum into tempp;

if found then
	raise exception 'This product number alrady exist!';
end if;
	
end $$;


--6
do $$
declare
	temp int;
begin
update sales.salesorderdetail set orderqty = orderqty * 1.1;

select 1 into temp from sales.salesorderdetail where orderqty = 0;
raise notice 'temp: %', temp;
if found then
	raise exception 'orderqty can not be zero!';
end if;

end $$;


--7
do $$
declare
	temp int := 0;
	average numeric;
begin
select avg(standardcost) into average from production.product;

with deleted_rows as(
	delete from production.product where standardcost > average returning *
)
select count(productid) into temp from deleted_rows;

if temp > 10 then
	raise exception 'The count of deleted rows is over 10!';
end if;

end $$;
