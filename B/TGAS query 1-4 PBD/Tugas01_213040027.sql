-- modul 1---------------------------------------------------

SELECT contactname, address
FROM sales.Customers

SELECT contactname, address
FROM sales.Customers
WHERE country = 'France'

SELECT contactname, address
FROM sales.Customers
WHERE country = 'France' AND (city = 'Paris' OR city = 'Nantes')

SELECT city, COUNT(custid) AS countcust
FROM sales.Customers
WHERE country = 'France' AND (city = 'Paris' OR city = 'Nantes')
GROUP BY country, city
HAVING COUNT(custid) > 1

SELECT contactname, city, country
FROM sales.Customers
WHERE city DESC, country

SELECT contactname, city, country
FROM sales.Customers
ORDER BY city ASC, country

SELECT TOP(10) contactname, address
FROM sales.Customers
WHERE country = 'France' OR country = 'Germany'

SELECT TOP(10) PERCENT contactname, address
FROM sales.Customers
WHERE country = 'France' OR country = 'Germany'

SELECT contactname, address
FROM sales.Customers
WHERE country = 'France' OR country = 'Germany'
ORDER BY contactname
OFFSET 4 ROWS FETCH NEXT 7 ROWS ONLY

SELECT productid, productname, categoryid,
CASE categoryid
WHEN 1 THEN 'Beverages'
WHEN 2 THEN 'Condiments'
WHEN 3 THEN 'Confections'
WHEN 4 THEN 'Dairy Products'
WHEN 5 THEN 'Grains/Cereals'
WHEN 6 THEN 'Meat/Poultry'
WHEN 7 THEN 'Produce'
WHEN 8 THEN 'Seafood'
ELSE 'Unknown Category'
END AS categoryname
FROM Production.Products;

SELECT prd.productid, prd.productname, prd.categoryid, cgs.categoryname
FROM Production.Products AS Prd INNER JOIN Production.Categories AS cgs
ON Prd.categoryid = cgs.categoryid

SELECT c.contactname, c.companyname, o.orderid, o.orderdate, o.requireddate,
o.shippeddate
FROM Sales.Customers AS C LEFT OUTER JOIN Sales.Orders AS O ON C.custid = O.custid;

-- QUEST MODUL 1 ++++++++++++++++++++++++++++

SELECT shipcountry, AVG(freight) AS avgfreight
FROM Sales.Orders
WHERE YEAR(orderdate) = 2007
GROUP BY shipcountry
ORDER BY avgfreight DESC, shipcountry
OFFSET 0 ROWS FETCH NEXT 3 ROWS ONLY;

-- modul 2-----------------------------------

SELECT country, region, city FROM HR.Employees
UNION ALL
SELECT country, region, city FROM Sales.Customers;

SELECT country, region, city FROM HR.Employees
UNION 
SELECT country, region, city FROM Sales.Customers;

SELECT country, region, city FROM HR.Employees
INERSECT
SELECT country, region, city FROM Sales.Customers;

SELECT country, region, city FROM HR.Employees
EXCEPT
SELECT country, region, city FROM Sales.Customers;

SELECT country, region, city FROM Sales.Customers
EXCEPT
SELECT country, region, city FROM HR.Employees

SELECT country, region, city FROM Production.Suppliers
EXCEPT
SELECT country, region, city FROM HR.Employees
INTERSECT
SELECT country, region, city FROM Sales.Customers;

SELECT country, COUNT(*) AS numlocations
FROM (SELECT country, region, city FROM HR.Employees
 UNION
 SELECT country, region, city FROM Sales.Customers) AS U
GROUP BY country;

SELECT empid, orderid, orderdate
FROM (SELECT TOP (2) empid, orderid, orderdate
 FROM Sales.Orders
WHERE empid = 3
ORDER BY orderdate DESC, orderid DESC) AS D1
UNION ALL
SELECT empid, orderid, orderdate
FROM (SELECT TOP (2) empid, orderid, orderdate
 FROM Sales.Orders
WHERE empid = 5
ORDER BY orderdate DESC, orderid DESC) AS D2;

IF OBJECT_ID('dbo.Orders', 'U') IS NOT NULL DROP TABLE dbo.Orders;
CREATE TABLE dbo.Orders
(
orderid INT NOT NULL
CONSTRAINT PK_Orders PRIMARY KEY,
orderdate DATE NOT NULL
CONSTRAINT DFT_orderdate DEFAULT(SYSDATETIME()),
empid INT NOT NULL,
custid VARCHAR(10) NOT NULL
)

INSERT INTO dbo.Orders(orderid, orderdate, empid, custid)
SELECT orderid, orderdate, empid, custid
FROM Sales.Orders
WHERE shipcountry = 'UK'

IF OBJECT_ID('dbo.Orders', 'U') IS NOT NULL DROP TABLE dbo.Orders; 
SELECT orderid, orderdate, empid, custid
INTO dbo.Orders
FROM Sales.Orders;

BULK INSERT dbo.Orders FROM 'c:\orders.txt'
WITH
(
DATAFILETYPE = 'char',
FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n'
);

DELETE FROM dbo.Orders
WHERE orderdate < '20070101';

TRUNCATE FROM dbo.Customers;

DELETE FROM O
FROM dbo.Orders AS O
JOIN dbo.Customers AS C
ON O.custid = C.custid
WHERE C.country = N'USA';

UPDATE OD
SET discount += 0.05
FROM dbo.OrderDetails AS OD
JOIN dbo.Orders AS O
ON OD.orderid = O.orderid
WHERE O.custid = 1;

UPDATE dbo.OrderDetails
SET discount += 0.05
WHERE EXISTS
(SELECT * FROM dbo.Orders AS O
WHERE O.orderid = OrderDetails.orderid
AND O.custid = 1);

MERGE INTO dbo.Customers AS TGT
USING dbo.CustomersStage AS SRC
ON TGT.custid = SRC.custid
WHEN MATCHED THEN
UPDATE SET
TGT.companyname = SRC.companyname,
TGT.phone = SRC.phone,
TGT.address = SRC.address
WHEN NOT MATCHED THEN
INSERT (custid, companyname, phone, address)
VALUES (SRC.custid, SRC.companyname, SRC.phone, SRC.address)
WHEN NOT MATCHED BY SOURCE THEN
DELETE;

-- modul 3-----------------------------------

SELECT orderid, custid, val,
SUM(val) OVER() AS totalvalue,
SUM(val) OVER(PARTITION BY custid) AS custtotalvalue
FROM Sales.OrderValues
WHERE Custid IN (1,2,3)

SELECT
ROW_NUMBER() OVER(ORDER BY custid ASC) AS "RowNum",
orderid, custid, val,
SUM(val) OVER() AS totalvalue,
SUM(val) OVER(PARTITION BY custid) AS custtotalvalue
FROM Sales.OrderValues
WHERE Custid IN (1,2,3)

SELECT empid, ordermonth, val,
SUM(val) OVER(PARTITION BY empid
ORDER BY ordermonth
ROWS BETWEEN UNBOUNDED PRECEDING
AND CURRENT ROW) AS runval
FROM Sales.EmpOrders;

SELECT orderid, custid, val,
ROW_NUMBER() OVER(ORDER BY val) AS rownum,
RANK() OVER(ORDER BY val) AS rank,
DENSE_RANK() OVER(ORDER BY val) AS dense_rank,
NTILE(100) OVER(ORDER BY val) AS ntile
FROM Sales.OrderValues
ORDER BY val;

-- Quiz modul 3 ++++++++++++++++++++++++++++++++++++++++++

SELECT 
 GROUPING_ID(empid, custid, YEAR(Orderdate)) AS groupingset, 
 empid, custid, YEAR(Orderdate) AS orderyear, SUM(qty) AS sumqty 
FROM dbo.Orders 
GROUP BY 
 GROUPING SETS 
 ( 
 (empid, custid, YEAR(orderdate)), 
 (empid, YEAR(orderdate)), 
 (custid, YEAR(orderdate)) 
 );

  SELECT empid, 
 COUNT(CASE WHEN orderyear = 2007 THEN orderyear END) AS cnt2007, 
 COUNT(CASE WHEN orderyear = 2008 THEN orderyear END) AS cnt2008, 
 COUNT(CASE WHEN orderyear = 2009 THEN orderyear END) AS cnt2009 
FROM (SELECT empid, YEAR(orderdate) AS orderyear 
 FROM dbo.Orders) AS Ord
GROUP BY empid

-- Modul 4------------------------------------------------------------

DELETE FROM dbo.Orders OUTPUT
deleted.orderid,
deleted.orderdate,
deleted.empid,
deleted.custid
WHERE orderdate < '20080101'

UPDATE dbo.OrderDetails
SET discount += 0.05 OUTPUT
inserted.productid,
deleted.discount AS olddiscount,
inserted.discount AS newdiscount
WHERE productid = 51;
 
MERGE INTO dbo.Customers AS TGT
USING dbo.CustomersStage AS SRC
ON TGT.custid = SRC.custid
WHEN MATCHED THEN
UPDATE SET
TGT.companyname = SRC.companyname,
TGT.phone = SRC.phone,
TGT.address = SRC.address
WHEN NOT MATCHED THEN
INSERT (custid, companyname, phone, address)
VALUES (SRC.custid, SRC.companyname, SRC.phone, SRC.address)
OUTPUT $action AS theaction, inserted.custid,
deleted.companyname AS oldcompanyname,
inserted.companyname AS newcompanyname,
deleted.phone AS oldphone,
inserted.phone AS newphone,
deleted.address AS oldaddress,
inserted.address AS newaddress;

INSERT INTO dbo.ProductsAudit(productid, colname, oldval, newval)
SELECT productid, 'unitprice', oldval, newval
FROM (UPDATE dbo.Products
SET unitprice *= 1.15
OUTPUT
inserted.productid,
deleted.unitprice AS oldval,
inserted.unitprice AS newval
WHERE supplierid = 1) AS D
WHERE oldval < 20.0 AND newval >= 20.0;
SELECT * FROM dbo.ProductsAudit;