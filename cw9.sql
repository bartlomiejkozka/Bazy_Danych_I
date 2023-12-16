--1 (PostgreSQL)

WITH TempEmployeeInfo AS (
	SELECT emp.businessentityid, nationalidnumber, loginid, jobtitle, birthdate, maritalstatus, gender, hiredate, pay.rate
	FROM humanresources.employee emp
	INNER JOIN humanresources.employeepayhistory pay ON emp.businessentityid = pay.businessentityid
)
SELECT * FROM TempEmployeeInfo ORDER BY businessentityid;



--(SQL Server)
--2
WITH SelectCTE (CompanyContact, Renevue) AS (
	SELECT	   
	cust.CompanyName +' (' + cust.FirstName + ' ' + cust.LastName + ')',
	det.UnitPrice * det.OrderQty
	FROM
	SalesLT.Customer cust
	INNER JOIN SalesLT.SalesOrderHeader head ON cust.CustomerID = head.CustomerID
	INNER JOIN SalesLT.SalesOrderDetail det ON head.SalesOrderID = det.SalesOrderID
)
select CompanyContact, sum(Renevue) from SelectCTE group by CompanyContact order by CompanyContact;



--3
WITH SalesCTE AS (
    SELECT
        p.ProductCategoryID,
        pc.Name AS CategoryName,
        SUM(sod.UnitPrice * sod.OrderQty) AS SalesAmount
    FROM
        SalesLT.SalesOrderDetail sod
    INNER JOIN
        SalesLT.Product p ON sod.ProductID = p.ProductID
    INNER JOIN
        SalesLT.ProductCategory pc ON p.ProductCategoryID = pc.ProductCategoryID
    GROUP BY
        p.ProductCategoryID, pc.Name
)
SELECT
    CategoryName,
	SalesAmount
FROM
    SalesCTE
ORDER BY
    CategoryName;



