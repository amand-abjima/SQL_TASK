--TRIGGERS IN SQL.

--SYNTAX OF TRIGGER.

CREATE TRIGGER Trigger_name
(BEFORE | AFTER)
[INSERT | UPDATE | DELETE]
ON [Table_Name]
[FOR EACH ROW]        --This specifies a row level trigger.This means trigger will be executed for each row.
[Trigger_Body]

CREATE TRIGGER Trigger_name
(BEFORE | AFTER)
[INSERT | UPDATE | DELETE]
ON [Table_Name]
[FOR EACH COLUMN]     --This specifies a column level trigger.This means trigger will be executed for each column.
[Trigger_Body]

CREATE [OR ALTER] TRIGGER
[schema_name .]trigger_name
ON {table | view}
[WITH <options> [,...n] ]
{FOR | AFTER | INSTEAD OF}
{[INSERT][,] [UPDATE] [,] [DELETE]}
[NOT FOR REPLICATION]
AS {sql_statement [;] [,...n]}
[WITH ENCRYPTION]

--If we want to see all the trigger names from the system.

SELECT NAME FROM SYS.TRIGGERS;

--DROP a TRIGGER.

DROP TRIGGER trigger_name;

--DML AFTER INSERT UPDATE TRIGGER.

/*A stored procedure on a database table that is automatically launched or triggered after a sql transaction 
and done successfully on the designated table is known as the AFTER INSERT UPDATE TRIGGER in a SQL Server. */

--SYNTAX:

CREATE TRIGGER [schema_name .]trigger_name
ON {table_NAME}
{FOR | AFTER}
{[INSERT]|[UPDATE]}
AS  
{sql_statement [;] [,...n]}

UPDATE table_name SET COLUMN_NAME = VALUE1,.....VALUEN WHERE[conditions];

INSERT INTO table_name VALUES(VALUE1,VALUE2,VALUEN);

SELECT * FROM STUDENT;

CREATE TRIGGER DBO.AFTERINSERTUPDATE
ON STUDENT
AFTER INSERT,UPDATE
AS 
SELECT * FROM STUDENT WHERE RNO > = 5;

INSERT INTO STUDENT VALUES(9,'RAJ','DIE');

UPDATE STUDENT SET NAMES = 'PRIYANSHU' WHERE RNO = 7;

SELECT * FROM STUDENT;


--------------------------------------------------------------------------------------------------------------------------------------------
--CREATE a trigger for INSERT of rows.

SELECT * FROM EMPLOYEE2;

CREATE TRIGGER TR_EMPLOYEE_INSERT       /*This trigger will run only when we will perform DML INSERT operation.*/
ON EMPLOYEE2
AFTER INSERT
AS
BEGIN
     PRINT 'Something happened in SQL Server.'
END

--Now we will INSERT a row into EMPLOYEE2 table.

INSERT INTO EMPLOYEE2 VALUES(11,'Gaurav Singh','Male',60000,'Sales','5 years');

--If we want to ALTER the existing trigger.

ALTER TRIGGER TR_EMPLOYEE_INSERT
ON EMPLOYEE2
AFTER INSERT
AS
BEGIN
     SELECT * FROM INSERTED
END

--Now we will again INSERT a row into EMPLOYEE2 table after altering trigger.

INSERT INTO EMPLOYEE2 VALUES(12,'Vishal Pratap','Male',40000,'IT','6 years'); /*This row will show on result window which comes from 
                                                                                INSERTED table.Whenever a row will be inserted into a main table 
																				then a copy of this row will come in INSERTED table.INSERTED table 
																				will contain only latest inserted rows after that this trigger will 
																				run,not all rows*/
																				

-- CREATE a trigger for DELETE a row.

CREATE TRIGGER TR_EMPLOYEE_DELETE    /*This trigger will run only when we will perform DML DELETE operation.*/
ON EMPLOYEE2
AFTER DELETE
AS
BEGIN
     SELECT * FROM DELETED 
END

--Now we will DELETE 12th row of Employee2 table.

DELETE FROM EMPLOYEE2 WHERE EMPLOYEEID=12;  /*This row will show on result window which comes from 
                                              DELETED table.Whenever a row will be deleted from a main table 
					                          then a copy of this row will come in DELETED table.DELETED table 
								              will contain only latest inserted rows after that DELETE trigger will 
											  run,not all rows.
											  *We can insert and delete multiple rows from a table which will show by INSERTED and DELETED
											  table.*/

--Now we will INSERT multiple rows into a EMPLOYEE2 table.

SELECT * FROM EMPLOYEE2;

INSERT INTO EMPLOYEE2 VALUES(12,'Vishal Pratap','Male',40000,'IT','6 years');         /* As soon as we will insert these 3 rows,then INSERT trigger 
                                                                                         will also run 3 times.*/
INSERT INTO EMPLOYEE2 VALUES(13,'Rajesh Sharma','Male',49000,'Marketing','8 years');

INSERT INTO EMPLOYEE2 VALUES(14,'Manjari Singh','Female',52000,'IT','9 years');

--Now we will DELETE multiple rows from a EMPLOYEE2 table.

DELETE FROM EMPLOYEE2 WHERE EMPLOYEEID=12;    /* As soon as we will delete these 3 rows,then DELETE trigger 
                                                 will also run 3 times.*/
DELETE FROM EMPLOYEE2 WHERE EMPLOYEEID=13;

DELETE FROM EMPLOYEE2 WHERE EMPLOYEEID=14;

--Now we want whatever we will insert and remove from the EMPLOYEE2 table,the description of those operations will go in AUDIT table. 

CREATE TABLE EMPLOYEE2_AUDIT
(AUDIT_ID INT PRIMARY KEY IDENTITY,
AUDIT_INFO VARCHAR(MAX));

SELECT * FROM EMPLOYEE2_AUDIT;

CREATE TRIGGER TR_AUDIT_EMPLOYEE_INSERT
ON EMPLOYEE2
AFTER INSERT
AS
BEGIN
     DECLARE @ID INT                                    /* we can also print NAME insted of ID by taking NAME variable*/
	 SELECT @ID = EMPLOYEEID FROM INSERTED

	 INSERT INTO EMPLOYEE2_AUDIT VALUES 
	 ('Employee with ID' + CAST(@ID AS VARCHAR(50)) + ' is added at' + CAST(GETDATE() AS VARCHAR(50)));
END

SELECT * FROM EMPLOYEE2;

--Now we will again INSERT a row into EMPLOYEE2 table after creating TR_AUDIT_EMPLOYEE_INSERT trigger.

INSERT INTO EMPLOYEE2 VALUES(12,'Vishal Pratap','Male',40000,'IT','6 years'); --Here Insert trigger will run.

--Now we will see AUDIT table.

SELECT * FROM EMPLOYEE2_AUDIT;

--Now we want whatever record we will remove from the EMPLOYEE2 table,the description of those operations will go in AUDIT table. 

CREATE TRIGGER TR_AUDIT_EMPLOYEE_DELETE
ON EMPLOYEE2
AFTER DELETE
AS
BEGIN
     DECLARE @NAME VARCHAR(50)                                    /* we can also print ID insted of NAME by taking ID variable*/
	 SELECT @NAME = NAME FROM DELETED

	 INSERT INTO EMPLOYEE2_AUDIT VALUES 
	 ('Existing Employee with NAME' + @NAME + ' is deleted at' + CAST(GETDATE() AS VARCHAR(50)));
END

--Now we will delete any row from EMPLOYEE2 table.

DELETE FROM EMPLOYEE2 WHERE NAME = 'Vishal Pratap'; --Here,first TR_EMPLOYEE_DELETE trigger will run,then TR_AUDIT_EMPLOYEE_DELETE trigger will run.

SELECT * FROM EMPLOYEE2_AUDIT;

--Now we will create trigger for DML UPDATE statement.

CREATE TRIGGER TR_EMPLOYEE_UPDATE
ON EMPLOYEE2
AFTER UPDATE
AS
BEGIN
     SELECT * FROM INSERTED
	 SELECT * FROM DELETED
END

--Now we will UPDATE a row.

SELECT * FROM EMPLOYEE2;

UPDATE EMPLOYEE2 SET NAME = 'Yuvi Bhadouriya',GENDER='Male' WHERE EMPLOYEEID=9;  /* It will show 2 rows first row is for updated record 
                                                                                     and second row is for deleted record.*/


--To see the code of our triggers.

SP_HELPTEXT TR_EMPLOYEE_UPDATE;

SP_HELPTEXT TR_EMPLOYEE_INSERT;

SP_HELPTEXT TR_EMPLOYEE_DELETE;

SP_HELPTEXT TR_AUDIT_EMPLOYEE_INSERT;

SP_HELPTEXT TR_AUDIT_EMPLOYEE_DELETE;

--VIEWS.

SELECT * FROM PRODUCT;

CREATE VIEW VWPRODUCT
AS 
SELECT PRODUCT_ID,COMPANY,PRICE 
FROM PRODUCT;

SELECT * FROM VWPRODUCT;

INSERT INTO VWPRODUCT VALUES(109,'C5',345.77); /*This row will be inserted into view as well as in PRODUCT table.But some columns of Product 
                                                table will remain empty.*/

ALTER VIEW VWPRODUCT
AS
SELECT * FROM PRODUCT
WHERE COMPANY='C1';

SELECT * FROM VWPRODUCT;

CREATE VIEW VWPRODUCT1
AS
SELECT PRODUCT_ID,PRODUCT_NAME,PRICE 
FROM PRODUCT
WITH CHECK OPTION;

ALTER VIEW VWPRODUCT1
AS
SELECT PRODUCT_ID,PRODUCT_NAME,COMPANY,PRICE
FROM PRODUCT
WHERE COMPANY = 'C2'
WITH CHECK OPTION;

SELECT * FROM VWPRODUCT1;

INSERT INTO VWPRODUCT1 VALUES(110,'ITEM 12','C3',453.21); --This row will not inserted into neither view nor table.
 
INSERT INTO VWPRODUCT1 VALUES(110,'ITEM 12','C2',453.21);

DELETE FROM VWPRODUCT1 WHERE PRODUCT_ID=110;

--STORED PROCEDURE.

SELECT * FROM SALESLT.CUSTOMERADDRESS;

CREATE PROCEDURE SPCUSTOMER
AS
BEGIN
SELECT * FROM SALESLT.CUSTOMERADDRESS WHERE ADDRESSTYPE = 'MAIN OFFICE';
END

SPCUSTOMER;

--How to modify Stored procedure.

ALTER PROCEDURE SPCUSTOMER
AS
BEGIN
SELECT * FROM SALESLT.CUSTOMERADDRESS WHERE ADDRESSTYPE = 'MAIN OFFICE';
SELECT * FROM SALESLT.CUSTOMERADDRESS WHERE ADDRESSID = 1086;
END

EXEC SPCUSTOMER;

ALTER PROCEDURE SPCUSTOMER
AS
BEGIN
SELECT * FROM SALESLT.CUSTOMERADDRESS WHERE ADDRESSTYPE = 'MAIN OFFICE';
SELECT * FROM SALESLT.CUSTOMERADDRESS WHERE ADDRESSID = 1086;
SELECT * FROM SALESLT.CUSTOMERADDRESS WHERE MODIFIEDDATE ='2005-07-01 00:00:00.000';
END

EXECUTE SPCUSTOMER;

SELECT * FROM SALESLT.CUSTOMER;

SELECT * FROM SALESLT.ADDRESS;

CREATE PROCEDURE SP1
AS
BEGIN
SELECT * FROM SALESLT.CUSTOMER T1 JOIN SALESLT.ADDRESS T2 
ON T1.CUSTOMERID = T2.ADDRESSID;
END

EXEC SP1;

CREATE PROCEDURE SP2
AS
BEGIN
SELECT ADDRESSID,CITY FROM SALESLT.ADDRESS
GROUP BY ADDRESSID,CITY;
END

EXEC SP2;

--USER DEFINED SCALAR FUNCTION.

--CREATE a function without parameter.

CREATE FUNCTION SHOWMESSAGE()
RETURNS VARCHAR(100)
AS 
BEGIN
    RETURN 'HELLO WORLD!!!'
END

SELECT DBO.SHOWMESSAGE();


--CREATE a function with ONE parameter.

CREATE FUNCTION NUMBER(@NUM AS INT)
RETURNS INT
AS 
BEGIN
    RETURN (@NUM * @NUM)
END

SELECT DBO.NUMBER(12);

--CREATE a function with multiple parameters.

CREATE FUNCTION ADDITION(@NUM1 AS INT,@NUM2 AS INT)
RETURNS INT
AS 
BEGIN
    RETURN (@NUM1 + @NUM2)
END

SELECT DBO.ADDITION(12,15);
SELECT DBO.ADDITION(22,15);
SELECT DBO.ADDITION(37,15);

--ALTER a function.

ALTER FUNCTION NUMBER(@NUM AS INT)
RETURNS INT
AS 
BEGIN
    RETURN (@NUM * @NUM * @NUM)
END

SELECT DBO.NUMBER(3);
SELECT DBO.NUMBER(4);

--DROP a function.

DROP FUNCTION function_name;

DROP FUNCTION NUMBER;

--IF and ELSE blocks inside function.

CREATE FUNCTION CHECKAGE(@AGE INT)
RETURNS VARCHAR(100)
AS
BEGIN
    DECLARE @STR VARCHAR(100)
	IF @AGE >= 18
	BEGIN
	SET @STR = 'You are eligible to vote.'
	END
	ELSE
	BEGIN
	SET @STR = 'You are not eligible to vote.'
	END
	RETURN @STR
END

SELECT DBO.CHECKAGE(20);
SELECT DBO.CHECKAGE(16);

SELECT * FROM SALESLT.PRODUCT;

--CALL function inside another function.

CREATE FUNCTION GETMYDATE()
RETURNS DATETIME
AS
BEGIN
    RETURN GETDATE()
END

SELECT DBO.GETMYDATE();


CREATE FUNCTION AddCost(@PRODUCTID INT)
RETURNS INT
AS
BEGIN
    DECLARE @SUM INT
	SELECT @SUM= SUM(P.PRODUCTMODELID)
	FROM SALESLT.PRODUCT P
	WHERE P.PRODUCTID= @PRODUCTID
	AND P.SIZE=58;
	IF (@SUM IS NULL)
	   SET @SUM = 0;
	RETURN @SUM;
END;

SELECT DBO.ADDCOST(706);














