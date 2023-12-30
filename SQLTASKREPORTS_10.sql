--TRIGGERS.

--DML INSTEAD OF TRIGGERS.

--INSTEAD OF INSERT TRIGGER.

SELECT * FROM EMPLOYEE2;

CREATE TRIGGER TR_INSTEDOFINSERT
ON EMPLOYEE2
INSTEAD OF INSERT
AS
BEGIN
   PRINT 'You are not allowed to insert data in this table.'
END

--Now we will try to insert one row into EMPLOYEE2 table.

INSERT INTO EMPLOYEE2 VALUES(12,'RAJESH SHARMA','MALE',49000,'IT','8 YEARS'); /* it will show 'You are not allowed to insert data in this table.

                                                                              (1 row affected)' message. This row gone in magic table 'INSERTED' insted of
																			  Employee2 table. Because TR_INSTEDOFINSERT trigger will executed first
																			  before inserting row into the table.*/

--INSTEAD OF UPDATE TRIGGER.

CREATE TRIGGER TR_INSTEDOFUPDATE
ON EMPLOYEE2
INSTEAD OF UPDATE
AS
BEGIN
   PRINT 'You are not allowed to update data in this table.'
END

--Now we will update an existing row into EMPLOYEE2 table.

UPDATE EMPLOYEE2 SET NAME='VISHAL SHARMA' WHERE EMPLOYEEID=8; /* Here no data will be updated in EMPLOYEE2 table.TR_INSTEDOFUPDATE trigger will be 
                                                              executed but data will not be updated.*/


--INSTEAD OF DELETE TRIGGER.

CREATE TRIGGER TR_INSTEDOFDELETE
ON EMPLOYEE2
INSTEAD OF DELETE
AS
BEGIN
   PRINT 'You are not allowed to delete data from this table.'
END

--Now we will delete row from EMPLOYEE2 table.

DELETE FROM EMPLOYEE2 WHERE EMPLOYEEID=8;    /* Here no data will be deleted from EMPLOYEE2 table.TR_INSTEDOFDELETE trigger will be 
                                                executed but data will not be deleted.This query ran into magic table 'DELETED'.*/


/*Now we want to create one audit table and we want if someone try to INSERT,UPDATE and DELETE data from EMPLOYEE2 table then the message will go in this
audit table that someone try to insert,update and delete data from table.*/ 

CREATE TABLE EMPLOYEE_AUDIT(AUDIT_ID INT PRIMARY KEY IDENTITY,AUDIT_INFORMATION VARCHAR(MAX));

SELECT * FROM EMPLOYEE_AUDIT;

--Now we will create trigger for EMPLOYEE_AUDIT table for Inserion.

CREATE TRIGGER TR_INSTEDOFINSERT_AUDIT
ON EMPLOYEE2
INSTEAD OF INSERT
AS
BEGIN
   INSERT INTO EMPLOYEE_AUDIT VALUES('Someone tried to insert data in Employee2 table at:' + CAST(GETDATE() AS VARCHAR(100)));
END

        /* -> It will show Cannot create trigger 'TR_INSTEDOFINSERT_AUDIT' on table 'EMPLOYEE2' because an 
           INSTEAD OF INSERT trigger already exists on this object error,because we will create only one 
		INSTEAD OF INSERT trigger,INSTEAD OF UPDATE trigger,INSTEAD OF DELETE trigger on sinle table.
		   -> Here we already applied INSTEAD OF INSERT TRIGGER on EMPLOYEE2 table and we are again executing TR_INSTEDOFINSERT_AUDIT trigger
		   on EMPLOYEE2 table, so this is not allowed.
		   -> So we need to DROP 'TR_INSTEDOFINSERT'trigger from EMPLOYEE2 table.*/

--Now we will DROP TR_INSTEDOFINSERT trigger from EMPLOYEE2 table.

DROP TRIGGER TR_INSTEDOFINSERT;

--Now we will again execute TR_INSTEDOFINSERT_AUDIT trigger.

--Now we will try to insert data into EMPLOYEE2 table.

SELECT * FROM EMPLOYEE2;

INSERT INTO EMPLOYEE2 VALUES(12,'Rajesh Sharma','Male',49000,'Marketing','9 years'); /* -> It will show '(1 row affected)' 2 times. It means first row will go in 
                                                                                        INSERTED table and second table will go in EMPLOYEE_AUDIT table.
																						-> But this row will not go in EMPLOYEE2 TABLE.*/

SELECT * FROM EMPLOYEE_AUDIT;


--Now we will create trigger for EMPLOYEE_AUDIT table for Updation.

CREATE TRIGGER TR_INSTEDOFUPDATE_AUDIT
ON EMPLOYEE2
INSTEAD OF UPDATE
AS
BEGIN
   INSERT INTO EMPLOYEE_AUDIT VALUES('Someone tried to update data in Employee2 table at:' + CAST(GETDATE() AS VARCHAR(100)));
END

--Now we will DROP TR_INSTEDOFUODATE trigger from EMPLOYEE2 table.

DROP TRIGGER TR_INSTEDOFUPDATE;

--Now we will again execute TR_INSTEDOFUPDATE_AUDIT trigger.

--Now we will try to UPDATE data into EMPLOYEE2 table.

UPDATE EMPLOYEE2 SET NAME='Supriya Sharma' WHERE EMPLOYEEID=5;  /* -> It will show '(1 row affected)' 2 times. It means first row will go in 
                                                                      INSERTED table and second table will go in EMPLOYEE_AUDIT table.
															       -> But this row will not go in EMPLOYEE2 TABLE.*/
SELECT * FROM EMPLOYEE2;

SELECT * FROM EMPLOYEE_AUDIT;

--Now we will create trigger for EMPLOYEE_AUDIT table for Deletion.

CREATE TRIGGER TR_INSTEDOFDELETE_AUDIT
ON EMPLOYEE2
INSTEAD OF DELETE
AS
BEGIN
   INSERT INTO EMPLOYEE_AUDIT VALUES('Someone tried to delete data from Employee2 table at:' + CAST(GETDATE() AS VARCHAR(100)));
END

--Now we will DROP TR_INSTEDOFDELETE trigger from EMPLOYEE2 table.

DROP TRIGGER TR_INSTEDOFDELETE;

--Now we will again execute TR_INSTEDOFDELETE_AUDIT trigger.

--Now we will try to DELETE data from EMPLOYEE2 table.

DELETE FROM EMPLOYEE2 WHERE EMPLOYEEID=5; /* -> It will show '(1 row affected)' 2 times. It means first row will go in 
                                                DELETED table and second table will go in EMPLOYEE_AUDIT table.
								             -> But this row will not go in EMPLOYEE2 TABLE.*/

SELECT * FROM EMPLOYEE2;

SELECT * FROM EMPLOYEE_AUDIT;

--View the definition of triggers.

SP_HELPTEXT TR_INSTEDOFDELETE_AUDIT;

SP_HELPTEXT TR_INSTEDOFUPDATE_AUDIT;

--WITH ENCRYPTION COMMAND.

ALTER TRIGGER TR_INSTEDOFDELETE_AUDIT
ON EMPLOYEE2
WITH ENCRYPTION
INSTEAD OF DELETE
AS
BEGIN
   INSERT INTO EMPLOYEE_AUDIT VALUES('Someone tried to delete data from Employee2 table at:' + CAST(GETDATE() AS VARCHAR(100)));
END

SP_HELPTEXT TR_INSTEDOFDELETE_AUDIT; --It will show 'The text for object 'TR_INSTEDOFDELETE_AUDIT' is encrypted.'

--DECRYPT TR_INSTEDOFDELETE_AUDIT

ALTER TRIGGER TR_INSTEDOFDELETE_AUDIT
ON EMPLOYEE2
INSTEAD OF DELETE
AS
BEGIN
   INSERT INTO EMPLOYEE_AUDIT VALUES('Someone tried to delete data from Employee2 table at:' + CAST(GETDATE() AS VARCHAR(100)));
END

SP_HELPTEXT TR_INSTEDOFDELETE_AUDIT; --It will show the code.

--INSTEAD OF DELETE TRIGGER WITH VIEW.

SELECT * FROM EMPLOYEE;

CREATE TABLE EMPDETAILS(ID INT PRIMARY KEY,DESIGNATION VARCHAR(30),SALARY INT);

INSERT INTO EMPDETAILS VALUES(100,'ACCOUNTENT',20000),
(200,'IT',22000),
(300,'HR',25000),
(400,'ADMIN',35000),
(500,'MANAGEMENT',30000)

SELECT * FROM EMPLOYEE;
SELECT * FROM EMPDETAILS;

CREATE VIEW VW_EMPLOYEE
AS
SELECT T1.ID,T1.NAMES,T1.CITY,T2.DESIGNATION,T2.SALARY
FROM EMPLOYEE T1
INNER JOIN
EMPDETAILS T2
ON T1.ID=T2.ID;

SELECT * FROM VW_EMPLOYEE;

--Now we want to delete row where id = 400 from view.

DELETE FROM VW_EMPLOYEE WHERE ID=400; /*->It will show 'View or function 'VW_EMPLOYEE' is not updatable because the modification 
                                        affects multiple base tables.
										-> Here base tables are EMPLOYEE,EMPDETAILS.*/



--Now we will create trigger on 'VW_EMPLOYEE' view. 

CREATE TRIGGER TR_INSTEDOFDELETEVIEW
ON VW_EMPLOYEE
INSTEAD OF DELETE
AS
BEGIN
     DELETE FROM EMPLOYEE WHERE ID IN(SELECT ID FROM DELETED)
	 DELETE FROM EMPDETAILS WHERE ID IN(SELECT ID FROM DELETED)
END

--Now we will delete a row whose id=400 in view.

DELETE FROM VW_EMPLOYEE WHERE ID = 400;  /* -> It will show '(1 row affected)' 3 times.













'




