--VIEWS in SQL Server.

SELECT * FROM STUDENT;

SELECT * FROM STUDENT_MARKS;

CREATE VIEW VW_STUDENT
AS
SELECT * FROM STUDENT AS S1
INNER JOIN STUDENT_MARKS AS S2
ON S1.RNO = S2.ROLLNO;

--RENAME  a column name in sql server.

EXEC sp_rename 'dbo.STUDENT_MARKS.RNO', 'ROLLNO', 'COLUMN';

--DROP A TRIGGER.

DROP TRIGGER TR_SERVERSCOPETRIGGER_VIEW ON ALL SERVER;

--Fetch a data from a view.

SELECT * FROM VW_STUDENT;

--Now we want only one appearance of common column occurs:

CREATE VIEW VW_STUDENT1
AS
SELECT s1.*,s2.MATH,S2.ENGLISH,S2.COMPUTER FROM STUDENT AS S1
INNER JOIN STUDENT_MARKS AS S2
ON S1.RNO = S2.ROLLNO;


SELECT * FROM VW_STUDENT1;

--Column Level security in view.

SELECT * FROM EMPLOYEE;

SELECT * FROM EMPDETAILS;

CREATE VIEW VW_STUDENT2
AS
SELECT E1.*,E2.DESIGNATION FROM EMPLOYEE AS E1
INNER JOIN EMPDETAILS AS E2
ON E1.ID = E2.ID;

SELECT * FROM VW_STUDENT2;  --Here we hide SALARY column of EMPDETAILS table.

--Row Level security in view.

CREATE VIEW VW_STUDENT3
AS
SELECT E1.*,E2.DESIGNATION FROM EMPLOYEE AS E1
INNER JOIN EMPDETAILS AS E2
ON E1.ID = E2.ID
WHERE E2.DESIGNATION = 'IT';

SELECT * FROM VW_STUDENT3;

--To get the code of view.

SP_HELPTEXT VW_STUDENT3;

SP_HELPTEXT VW_STUDENT2;

SP_HELPTEXT VW_STUDENT1;

--ALTER the existing view.

ALTER VIEW VW_STUDENT3
AS
SELECT E1.*,E2.DESIGNATION FROM EMPLOYEE AS E1
INNER JOIN EMPDETAILS AS E2
ON E1.ID = E2.ID
WHERE E2.DESIGNATION = 'IT' OR E2.DESIGNATION='ACCOUNTENT';

SELECT * FROM VW_STUDENT3;

--DROP a view.

DROP VIEW VE_STUDENT1;

--INSERT WITH VIEWS.

--View on a single table.

CREATE VIEW VW_EMP1
AS
SELECT * FROM EMPLOYEE;

SELECT * FROM VW_EMP1;

--Now view have 6 rows and we want to insert 7th row inside a view.

INSERT INTO VW_EMP1 VALUES(700,'SHIVANI','NOIDA'); --The row has been inserted inside a view as well as in original table.

SELECT * FROM VW_EMP1; 

--UPDATE WITH VIEWS.

UPDATE VW_EMP1 SET NAMES = 'TANUJ' WHERE ID =500; 

SELECT * FROM VW_EMP1; --The row has been updated inside a view as well as in original table.

SELECT * FROM EMPLOYEE;

--DELETE WITH VIEWS.

DELETE FROM VW_EMP1 WHERE ID = 600;

SELECT * FROM VW_EMP1; --The row has been deleted from a view as well as in original table.

SELECT * FROM EMPLOYEE;

--Types of Stored Procedure.

--Stored Procedure with INPUT parameters. 
--Stored Procedure with OUTPUT parameters. 

SELECT * FROM EMPLOYEE2;

CREATE PROCEDURE SP_GETEMP2
@GENDER VARCHAR(50),    --INPUT PARAMETER   /* wHEN WE CALL "SP_GETEMP2" PROCEDURE,THEN GENDER VARIABLE WILL TAKE INPUT AND EMPLOYEECOUNT
@EMPLOYEECOUNT INT OUTPUT   --OUTPUT PARAMETER.  VARIABLE WILL RETURN OUTPUT*/
AS
BEGIN
SELECT @EMPLOYEECOUNT = COUNT(EMPLOYEEID) FROM EMPLOYEE2 WHERE GENDER = @GENDER;
END

--Now we will create a variable to store the value of output variable @EMPLOYEECOUNT.

DECLARE @TOTALEMPLOYEE INT
EXECUTE SP_GETEMP2 'FEMALE',@TOTALEMPLOYEE OUTPUT
SELECT @TOTALEMPLOYEE;

DECLARE @TOTALEMPLOYEE INT
EXECUTE SP_GETEMP2 'MALE',@TOTALEMPLOYEE OUTPUT
SELECT @TOTALEMPLOYEE AS MALE_EMPLOYEES;  -- MOSTLY WE USED Stored Procedure with INPUT parameters.

--LIST ALL TRIGGERS.

SELECT * FROM SYS.TRIGGERS;

--COMMON TABLE EXPRESSION(CTE):

SELECT * FROM EMPLOYEE2;

WITH NEW_CTE
AS
(
SELECT * FROM EMPLOYEE2 WHERE GENDER = 'Male'
)
SELECT * FROM NEW_CTE;

WITH NEW_CTE
AS
(
SELECT * FROM EMPLOYEE2 WHERE GENDER = 'Male'
)
SELECT COUNT(*) FROM NEW_CTE;

WITH NEW_CTE
AS
(
SELECT * FROM EMPLOYEE2 WHERE GENDER = 'Male'
)
SELECT * FROM NEW_CTE WHERE SALARY >=50000;  --THIS IS OUTER QUERY OF CTE.

--WE NEED TO USE CTE QUERY IMMEDIATELY WITH SELECT,INSERT,UPDATE ETC. COMMAND AFTER CREATING CTE.


WITH NEW_CTE         /* This query will show "Common table expression defined but not used."message.*/
AS
(
SELECT * FROM EMPLOYEE2 WHERE GENDER = 'Male'
)
SELECT 'HELLO WORLD'
SELECT * FROM NEW_CTE WHERE SALARY >=50000; 

--CTE WITH COLUMN NAME.

WITH NEW_CTE(E_ID,E_NAME,E_DEPT)   /*->NUMBER OF OPTIONAL COLUMNS MUST BE SAME AS COLUMNS INSIDE CTE SELECT QUERY.*/
AS
(
SELECT EMPLOYEEID,NAME,DEPARTMENT FROM EMPLOYEE2 WHERE GENDER = 'Male'
)
SELECT E_ID,E_NAME,E_DEPT FROM NEW_CTE; /* CTE COLUMNS ARE COLUMNS WHICH WERE WRITEEN IN OPTIONAL COLUMNS PLACE.*/

--INSERT COMMAND WITH CTE.

WITH NEW_CTE
AS
(
SELECT * FROM EMPLOYEE2 
)
INSERT NEW_CTE VALUES(13,'Abhishek Sharma','Male',79000,'IT','2 years'); -- WHEN WE INSERT IN CTE THEN INTO KEYWORD IS NOT USED.

----UPDATE COMMAND WITH CTE.

WITH NEW_CTE
AS
(
SELECT * FROM EMPLOYEE2 
)
UPDATE NEW_CTE SET NAME = 'Abhishek Kumar' WHERE EMPLOYEEID = 13;


--DELETE COMMAND WITH CTE.

WITH NEW_CTE
AS
(
SELECT * FROM EMPLOYEE2 
)
DELETE NEW_CTE WHERE EMPLOYEEID = 13;

--VIEWS WITH CTE.

CREATE VIEW VW_MYVIEW
AS
WITH NEW_CTE
AS
(
SELECT * FROM EMPLOYEE2 WHERE DEPARTMENT = 'IT'
)
SELECT * FROM NEW_CTE;

SELECT * FROM VW_MYVIEW;

--We can create multiples CTEs by using single WITH clause. 

WITH NEW_CTE1
AS
(
SELECT * FROM EMPLOYEE2 WHERE DEPARTMENT = 'IT'
),
NEW_CTE2
AS
(
SELECT * FROM EMPLOYEE2 WHERE DEPARTMENT = 'SALES'
)
SELECT * FROM NEW_CTE1
UNION ALL
SELECT * FROM NEW_CTE2;

--It is possible to use inline or external aliases for columns in CTEs. 

WITH NEW_CTE  --NEW_CTE is an alias name of "SELECT * FROM EMPLOYEE2 " query.
AS
(
SELECT * FROM EMPLOYEE2 
)
UPDATE NEW_CTE SET NAME = 'Abhishek Kumar' WHERE EMPLOYEEID = 13;

--We can give alias name to a column.

WITH NEW_CTE       -- -> THIS QUERY WILL SHOW "No column name was specified for column 1 of 'NEW_CTE'."MESSAGE.
AS                 -- -> IT IS SHOWING BECAUSE AGGREGATE FUNCTIONS DOESN'T HAVE ANY COLUMN NAME 
(
SELECT COUNT(*) FROM EMPLOYEE2 
)
SELECT * FROM NEW_CTE;

WITH NEW_CTE
AS
(
SELECT COUNT(*) AS TOTALEMPLOYEE FROM EMPLOYEE2 
)
SELECT * FROM NEW_CTE;