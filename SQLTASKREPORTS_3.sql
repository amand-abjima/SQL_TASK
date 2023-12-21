-- INNER JOIN

SELECT * FROM SALESLT.ADDRESS;

SELECT * FROM SALESLT.CUSTOMER;

SELECT * FROM SALESLT.CUSTOMER C INNER JOIN SALESLT.ADDRESS A ON C.CUSTOMERID = A.ADDRESSID;

-- By writing SQL query.

-- Here we will also use table alias for clean code query.

SELECT C.CUSTOMERID, C.TITLE, C.FIRSTNAME, C.LASTNAME, A.ADDRESSID,A.CITY,A.POSTALCODE 
FROM SALESLT.CUSTOMER AS C 
INNER JOIN SALESLT.ADDRESS AS A 
ON C.CUSTOMERID=A.ADDRESSID;

-- By using Graphic query editor.

SELECT SalesLT.Customer.CustomerID, SalesLT.Customer.Title, SalesLT.Customer.FirstName, SalesLT.Customer.LastName, 
SalesLT.Address.AddressID, SalesLT.Address.City, SalesLT.Address.PostalCode
FROM SalesLT.Customer 
iNNER JOIN SalesLT.Address 
ON SalesLT.Customer.CustomerID = SalesLT.Address.AddressID;

-- JOIN KEYWORD

SELECT C.CUSTOMERID, C.TITLE, C.FIRSTNAME,C.MIDDLENAME, C.LASTNAME, A.ADDRESSID,A.CITY,A.COUNTRYREGION,A.POSTALCODE
FROM SALESLT.CUSTOMER AS C 
JOIN SALESLT.ADDRESS AS A 
ON C.CUSTOMERID=A.ADDRESSID WHERE C.MIDDLENAME IS NOT NULL;


SELECT C.CUSTOMERID, C.TITLE, C.FIRSTNAME,C.MIDDLENAME, C.LASTNAME, A.ADDRESSID,A.CITY,A.COUNTRYREGION,A.POSTALCODE
FROM SALESLT.CUSTOMER AS C 
JOIN SALESLT.ADDRESS AS A 
ON C.CUSTOMERID=A.ADDRESSID WHERE C.MIDDLENAME IS NULL;


SELECT C.CUSTOMERID, C.TITLE, C.FIRSTNAME,C.MIDDLENAME, C.LASTNAME, A.ADDRESSID,A.CITY,A.COUNTRYREGION,A.POSTALCODE
FROM SALESLT.CUSTOMER AS C 
JOIN SALESLT.ADDRESS AS A 
ON C.CUSTOMERID=A.ADDRESSID WHERE C.LASTNAME='EVANS';

-- Here we are using logical AND operator with JOIN.

SELECT C.CUSTOMERID, C.TITLE, C.FIRSTNAME,C.MIDDLENAME, C.LASTNAME, A.ADDRESSID,A.CITY,A.COUNTRYREGION,A.POSTALCODE
FROM SALESLT.CUSTOMER AS C 
JOIN SALESLT.ADDRESS AS A 
ON C.CUSTOMERID=A.ADDRESSID AND C.LASTNAME='EVANS';

--We can also join tables by using WHERE clause.

SELECT * FROM SALESLT.CUSTOMER C,SALESLT.ADDRESS A WHERE C.CUSTOMERID=A.ADDRESSID;

SELECT * FROM SALESLT.PRODUCTMODEL;

SELECT * FROM SALESLT.PRODUCTCATEGORY;

SELECT P1.PRODUCTMODELID,P1.NAME,P2.PRODUCTCATEGORYID,P2.NAME
FROM SALESLT.PRODUCTMODEL AS P1 
INNER JOIN SALESLT.PRODUCTCATEGORY AS P2
ON P1.PRODUCTMODELID=P2.PRODUCTCATEGORYID;

--LEFT OUTER JOIN/ LEFT JOIN

SELECT SalesLT.Customer.CustomerID, SalesLT.Customer.Title, SalesLT.Customer.FirstName, SalesLT.Customer.LastName, 
SalesLT.Address.AddressID, SalesLT.Address.City, SalesLT.Address.PostalCode
FROM SalesLT.Customer 
LEFT JOIN SalesLT.Address 
ON SalesLT.Customer.CustomerID = SalesLT.Address.AddressID;

SELECT SalesLT.Customer.CustomerID, SalesLT.Customer.Title, SalesLT.Customer.FirstName, SalesLT.Customer.LastName, 
SalesLT.Address.AddressID, SalesLT.Address.City, SalesLT.Address.PostalCode
FROM SalesLT.Customer 
LEFT OUTER JOIN SalesLT.Address 
ON SalesLT.Customer.CustomerID = SalesLT.Address.AddressID;

SELECT * FROM SALESLT.PRODUCTMODEL;

SELECT * FROM SALESLT.PRODUCTCATEGORY;

SELECT P1.PRODUCTMODELID,P1.NAME,P2.PRODUCTCATEGORYID,P2.NAME
FROM SALESLT.PRODUCTMODEL AS P1 
LEFT JOIN SALESLT.PRODUCTCATEGORY AS P2
ON P1.PRODUCTMODELID=P2.PRODUCTCATEGORYID;

SELECT C.CUSTOMERID, C.TITLE, C.FIRSTNAME,C.MIDDLENAME, C.LASTNAME, A.ADDRESSID,A.CITY,A.COUNTRYREGION,A.POSTALCODE
FROM SALESLT.CUSTOMER AS C 
LEFT JOIN SALESLT.ADDRESS AS A 
ON C.CUSTOMERID=A.ADDRESSID WHERE C.LASTNAME='EVANS';

SELECT C.CUSTOMERID, C.TITLE, C.FIRSTNAME,C.MIDDLENAME, C.LASTNAME, A.ADDRESSID,A.CITY,A.COUNTRYREGION,A.POSTALCODE
FROM SALESLT.CUSTOMER AS C 
LEFT JOIN SALESLT.ADDRESS AS A 
ON C.CUSTOMERID=A.ADDRESSID;

--RIGHT OUTER JOIN

SELECT C.CUSTOMERID, C.TITLE, C.FIRSTNAME,C.MIDDLENAME, C.LASTNAME, A.ADDRESSID,A.CITY,A.COUNTRYREGION,A.POSTALCODE
FROM SALESLT.CUSTOMER AS C 
RIGHT OUTER JOIN SALESLT.ADDRESS AS A 
ON C.CUSTOMERID=A.ADDRESSID;

-- OUTER KEYWORD is optional.

SELECT C.CUSTOMERID, C.TITLE, C.FIRSTNAME,C.MIDDLENAME, C.LASTNAME, A.ADDRESSID,A.CITY,A.COUNTRYREGION,A.POSTALCODE
FROM SALESLT.CUSTOMER AS C 
RIGHT JOIN SALESLT.ADDRESS AS A 
ON C.CUSTOMERID=A.ADDRESSID;


SELECT P1.PRODUCTMODELID,P1.NAME,P2.PRODUCTCATEGORYID,P2.NAME
FROM SALESLT.PRODUCTMODEL AS P1 
RIGHT OUTER JOIN SALESLT.PRODUCTCATEGORY AS P2
ON P1.PRODUCTMODELID=P2.PRODUCTCATEGORYID;

--FULL OUTER JOIN/ FULL JOIN

SELECT P1.PRODUCTMODELID,P1.NAME,P2.PRODUCTCATEGORYID,P2.NAME
FROM SALESLT.PRODUCTMODEL AS P1 
FULL OUTER JOIN SALESLT.PRODUCTCATEGORY AS P2
ON P1.PRODUCTMODELID=P2.PRODUCTCATEGORYID;

SELECT C.CUSTOMERID, C.TITLE, C.FIRSTNAME,C.MIDDLENAME, C.LASTNAME, A.ADDRESSID,A.CITY,A.COUNTRYREGION,A.POSTALCODE
FROM SALESLT.CUSTOMER AS C 
FULL JOIN SALESLT.ADDRESS AS A 
ON C.CUSTOMERID=A.ADDRESSID;

--CROSS JOIN

SELECT *
FROM SALESLT.CUSTOMER AS C 
CROSS JOIN SALESLT.ADDRESS AS A ;

SELECT *
FROM SALESLT.CUSTOMER AS C,SALESLT.ADDRESS AS A ;

SELECT C.CUSTOMERID, C.TITLE, C.FIRSTNAME,C.MIDDLENAME, C.LASTNAME, A.ADDRESSID,A.CITY,A.COUNTRYREGION,A.POSTALCODE
FROM SALESLT.CUSTOMER AS C 
CROSS JOIN SALESLT.ADDRESS AS A;


SELECT P1.PRODUCTMODELID,P1.NAME,P2.PRODUCTCATEGORYID,P2.NAME
FROM SALESLT.PRODUCTMODEL AS P1 
CROSS JOIN SALESLT.PRODUCTCATEGORY AS P2;

--SELF JOIN

SELECT * FROM SALESLT.CUSTOMER;

SELECT C1.CUSTOMERID,C1.TITLE,C1.FIRSTNAME,C1.LASTNAME FROM SALESLT.CUSTOMER C1 JOIN SALESLT.CUSTOMER C2 ON C1.CUSTOMERID=C2.CUSTOMERID;

SELECT C1.CUSTOMERID,C1.TITLE,C1.FIRSTNAME,C1.LASTNAME FROM SALESLT.CUSTOMER C1 JOIN SALESLT.CUSTOMER C2 ON C1.CUSTOMERID>=C2.CUSTOMERID;

SELECT C1.CUSTOMERID,C1.TITLE,C1.FIRSTNAME,C1.LASTNAME FROM SALESLT.CUSTOMER C1 JOIN SALESLT.CUSTOMER C2 ON C1.CUSTOMERID<>C2.CUSTOMERID;

SELECT C1.CUSTOMERID,C1.TITLE,C1.FIRSTNAME,C1.LASTNAME 
FROM SALESLT.CUSTOMER C1 
JOIN SALESLT.CUSTOMER C2
ON C1.CUSTOMERID<>C2.CUSTOMERID AND C1.FIRSTNAME=C2.FIRSTNAME AND C1.LASTNAME=C2.LASTNAME;

--MULTI JOIN QUERY.

SELECT * FROM SALESLT.CUSTOMER;

SELECT * FROM SALESLT.ADDRESS;

SELECT * FROM SALESLT.CUSTOMERADDRESS;

SELECT * FROM SALESLT.PRODUCT;

SELECT T1.TITLE,T1.FIRSTNAME,T2.CITY,T2.POSTALCODE,T3.ADDRESSTYPE,T4.NAME
FROM SALESLT.CUSTOMER T1 
INNER JOIN SALESLT.ADDRESS T2 ON T1.CUSTOMERID=T2.ADDRESSID
LEFT JOIN SALESLT.CUSTOMERADDRESS T3 ON T2.ADDRESSID=T3.ADDRESSID
FULL JOIN SALESLT.PRODUCT T4 ON T4.PRODUCTID=T2.ADDRESSID;

--SET OPERATORS.

CREATE TABLE FB(ID NVARCHAR(10),FIRSTNAME VARCHAR(20),LASTNAME VARCHAR(20));

INSERT INTO FB VALUES('A1','AMAN','DHAKRE');

UPDATE FB SET ID='D1' WHERE FIRSTNAME='RAVI';

SELECT * FROM FB;

CREATE TABLE IG(ID NVARCHAR(10),FIRSTNAME VARCHAR(20),LASTNAME VARCHAR(20));

INSERT INTO IG VALUES('Y1','MAHI','GOYAL');

SELECT * FROM IG;

--UNION

SELECT * FROM FB UNION SELECT * FROM IG;

SELECT F1.FIRSTNAME FROM FB F1 UNION SELECT I1.LASTNAME FROM IG I1;

SELECT * FROM FB UNION SELECT * FROM IG ORDER BY FIRSTNAME;

--UNION ALL.

SELECT * FROM FB UNION ALL SELECT * FROM IG;

SELECT * FROM FB UNION ALL SELECT * FROM IG ORDER BY FIRSTNAME;

--INTERSECT

SELECT * FROM FB INTERSECT SELECT * FROM IG;

SELECT * FROM FB INTERSECT SELECT * FROM IG ORDER BY LASTNAME DESC;

(
  SELECT 'A' AS P1
  UNION 
  SELECT 'B'
  UNION
  SELECT 'C'
)
INTERSECT
(
   SELECT 'B' AS P1
  UNION 
  SELECT 'C'
  UNION
  SELECT 'D'
)

--EXCEPT

SELECT * FROM FB EXCEPT SELECT * FROM IG;

SELECT * FROM FB EXCEPT SELECT * FROM IG ORDER BY FIRSTNAME DESC;

(
  SELECT 'A' AS P1
  UNION 
  SELECT 'B'
  UNION
  SELECT 'C'
)
EXCEPT
(
   SELECT 'B' AS P1
  UNION 
  SELECT 'C'
  UNION
  SELECT 'D'
)

--SUBQUERIES

SELECT * FROM SALESLT.PRODUCT;

SELECT PRODUCTID, NAME, COLOR, SIZE FROM SALESLT.PRODUCT WHERE WEIGHT =(SELECT MAX(WEIGHT) FROM SALESLT.PRODUCT);

SELECT * FROM SALESLT.CUSTOMER;

SELECT * FROM SALESLT.ADDRESS;

SELECT CUSTOMERID,TITLE,FIRSTNAME,LASTNAME FROM SALESLT.CUSTOMER WHERE MODIFIEDDATE=(SELECT MIN(MODIFIEDDATE) FROM SALESLT.CUSTOMER);

SELECT COUNT(*) FROM SALESLT.CUSTOMER WHERE LASTNAME IN ('GATES','GASH','GARZA');

SELECT COUNT(*) FROM SALESLT.ADDRESS WHERE CITY IN ('BOTHELL','TORONTO','RENTON');

--SUBQUERIES BY USING TWO TABLES.

SELECT TITLE, FIRSTNAME, LASTNAME FROM SALESLT.CUSTOMER WHERE CUSTOMERID IN (SELECT ADDRESSID FROM SALESLT.ADDRESS);

SELECT CITY,STATEPROVINCE,COUNTRYREGION,POSTALCODE FROM SALESLT.ADDRESS WHERE ADDRESSID IN(SELECT CUSTOMERID FROM SALESLT.CUSTOMER WHERE TITLE='MR.');

--SUBQUERIES BY USING DERIVED TABLE.

SELECT * FROM SALESLT.CUSTOMER
WHERE FIRSTNAME IN
(
SELECT FIRSTNAME FROM
(
    SELECT 'HARRY' AS FIRSTNAME, 'POTTER' AS LASTNAME
    UNION
    SELECT 'THE' AS FIRSTNAME, 'ROCK' AS LASTNAME
) AS MOVIECHARACTER
)

SELECT * FROM SALESLT.CUSTOMER
WHERE FIRSTNAME IN
(
SELECT FIRSTNAME FROM
(
    SELECT 'HARRY' AS FIRSTNAME, 'POTTER' AS LASTNAME
    UNION
    SELECT 'DONNA' AS FIRSTNAME, 'ROCK' AS LASTNAME
) AS MOVIECHARACTER
)















