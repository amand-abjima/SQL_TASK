--Stored Procedure.

SELECT * FROM EMPLOYEE2;

--How to create stored procedure.

CREATE PROCEDURE SPEMP1
AS 
BEGIN
SELECT * FROM EMPLOYEE2 WHERE DEPARTMENT = 'IT';
END

-- How to ececute stored procedure.

SPEMP1;

EXECUTE SPEMP1;

EXEC SPEMP1;

-- How to modify stored procedure.

ALTER PROC SPEMP1
AS
BEGIN
SELECT * FROM EMPLOYEE2 WHERE DEPARTMENT = 'IT';
SELECT * FROM EMPLOYEE2 WHERE SALARY >60000; --We can pass multiple queries into stored procedure.
END

EXEC SPEMP1;

-- How to drop stored procedure.

DROP PROCEDURE procedure_name;

DROP PROCEDURE SPEMP1;

--Parameters in stored procedure.
--Parameters are of two types Input and Output.
--Parameters are used to make query dynamic.

ALTER PROC SPEMP1
@GENDER VARCHAR(20),
@EID INT,
@SAL INT
AS
BEGIN
SELECT * FROM EMPLOYEE2 WHERE GENDER = @GENDER;
SELECT * FROM EMPLOYEE2 WHERE EMPLOYEEID = @EID;
SELECT * FROM EMPLOYEE2 WHERE SALARY = @SAL;
END

EXEC SPEMP1 'FEMALE',7,50000; --We need to maintain sequance or order of parameters and order of values.

--Name parameters values.
--Here we no need to maintain order of parameters.

EXEC SPEMP1 @SAL =55000, @GENDER='MALE', @EID=9; -- We can also give parameters with value.

--Parameters with default value/ Default value parameters.

ALTER PROC SPEMP1
@EID INT = 8,
@NAME VARCHAR(20) = 'RAHUL PATEL'
AS
BEGIN
SELECT * FROM EMPLOYEE2 WHERE EMPLOYEEID = @EID;
SELECT * FROM EMPLOYEE2 WHERE NAME = @NAME;
END

EXEC SPEMP1; --Here we had given a initial value to parameters.

-- If we give values during execution of stored procedures than default values will be ignore.

EXEC SPEMP1 5,'NISHA GUPTA';

--Output Parameters.

-- When any calculation is performed inside stored procedure and want to access this calculation outside the procedure, in this case we can
--declare one parameter as output type and can store the result inside this output type parameter. After that when procedure will be call then by 
--accessing this output parameter we can see the result.

CREATE PROCEDURE SPAddDigit
@NUM1 INT,
@NUM2 INT,
@RESULT INT OUTPUT
AS 
BEGIN
    SET @RESULT = @NUM1 + @NUM2;
END

DECLARE @EID INT
EXEC SPAddDigit 4,8,@EID OUTPUT;
SELECT @EID;

--Stored Procedure security with encryption.

--How to check text of stored procedure?

SP_HELPTEXT SPAddDigit;

SP_HELPTEXT SPEMP1;

-- To apply security on stored procedure.

--We can use 'WITH ENCRYPTION' statement.It can restrict to see stored procedure text.

ALTER PROCEDURE SPAddDigit
@NUM1 INT,
@NUM2 INT,
@RESULT INT OUTPUT
WITH ENCRYPTION
AS 
BEGIN
    SET @RESULT = @NUM1 + @NUM2;
END

SP_HELPTEXT SPAddDigit;

--SQL VIEW.

-- A view can be created by using single table or multiple tables.

SELECT * FROM EMPLOYEE2;

--CREATE a VIEW.

CREATE VIEW CVIEW2
AS 
SELECT * FROM EMPLOYEE2;

SELECT * FROM CVIEW2;

-- Check the definition of VIEW.

SP_HELPTEXT CVIEW2;

--MODIFY a VIEW.

ALTER VIEW CVIEW2
AS 
SELECT EMPLOYEEID,NAME,SALARY FROM EMPLOYEE2;

SELECT * FROM CVIEW2;

--DROP a VIEW.

DROP VIEW view_name;

DROP VIEW CVIEW2;

SELECT * FROM STUDENT;

CREATE TABLE STUDENT_MARKS(RNO INT PRIMARY KEY, MATH INT,ENGLISH INT,COMPUTER INT);

INSERT INTO STUDENT_MARKS VALUES(1,34,78,54),
(2,78,43,87),
(3,88,63,57),
(4,61,49,55),
(5,98,73,78),
(6,71,40,60);

--VIEW from multiple tables.

SELECT * FROM STUDENT;
SELECT * FROM STUDENT_MARKS;

CREATE VIEW STDVIEW
AS
SELECT S1.RNO,S1.NAMES,S2.MATH,S2.ENGLISH,S2.COMPUTER
FROM STUDENT S1
INNER JOIN STUDENT_MARKS S2
ON S1.RNO = S2.RNO;

SELECT * FROM STDVIEW;

--How to UPDATE the metadata of SQL VIEW.

SELECT * FROM STUDENT;

CREATE VIEW CVIEW3
AS
SELECT * FROM STUDENT;

SELECT * FROM CVIEW3;

--Now add column in a student table.

ALTER TABLE STUDENT ADD CITY VARCHAR(20);

SELECT * FROM STUDENT; --CITY column will be added into STUDENT table.

SELECT * FROM CVIEW3; --But CITY column will not be added into STUDENT table.

--To add CITY column inside a view.

EXEC SP_REFRESHVIEW CVIEW3;

SELECT * FROM CVIEW3; --Now CITY column will be added into view.

--How to create Schema Binding SQL VIEW.

-- We created a view from STUDENT table, after that we delete a column from STUDENT table.

SELECT * FROM STUDENT;

SELECT * FROM CVIEW3;

--Now we will remove a column from STUDENT table.

ALTER TABLE STUDENT DROP COLUMN CITY;

SELECT * FROM CVIEW3; --Here we wil get 'View or function 'CVIEW3' has more column names specified than columns defined' error.Here view execution will fail.

-- We can bind columns with view by using schema binding.After that we can't change or drop that column from original table.

CREATE VIEW VIEWSCHEMABINDING
WITH SCHEMABINDING
AS 
SELECT RNO,NAMES,CLASS FROM DBO.STUDENT;

--Now we will try to drop one column from STUDENT table.

ALTER TABLE STUDENT DROP COLUMN RNO;

ALTER TABLE STUDENT ALTER COLUMN CLASS VARCHAR(30); --After column binding we can't change or drop a column from original table.

--By using Schema Binding we can secure our view.Noone can change the table from which view has been created and can't drop a table.

/*
  Why to use view?
  - To hide the complexity of query.
  - Row level security.
  - Column level security.
*/

--Row level security.

SELECT * FROM STUDENT;

CREATE VIEW VIEW4
AS
SELECT * FROM STUDENT WHERE RNO > 4;

SELECT * FROM VIEW4; --Here user can access those roll no.'s which are greater than 4.It will provide row level security.

--Column level security.

SELECT * FROM STUDENT;

CREATE VIEW VIEW5
AS 
SELECT RNO,NAMES FROM STUDENT;

SELECT * FROM VIEW5; --Here user can access records from only these 2 columns.It will provide column level security.

--How to apply DML operations on view.
/*
  UPADTING VIEWS.
     * We can use DML operations on a single table only.
     * VIEW should not contain GROUP BY, HAVING, DISTINCT clauses.
     * We can't use subquery inside VIEW in SQL Server.
     * We can't use SET operators in a SQL VIEW.
  DELETE from VIEW.
  INSERT into VIEW.
*/

SELECT * FROM STUDENT;

CREATE VIEW VWDEMO
AS 
SELECT * FROM STUDENT;

SELECT * FROM VWDEMO;

--INSERT data into a VIEW.

INSERT INTO VWDEMO(NAMES,CLASS) VALUES('GAURAV','DIE');

SELECT * FROM VWDEMO;

--DELETE data from a VIEW.

DELETE FROM VWDEMO WHERE RNO = 4;

SELECT * FROM VWDEMO;

--UPDATE data of a VIEW.

UPDATE VWDEMO SET NAMES = 'KRISHNA' WHERE RNO = 1;

SELECT * FROM VWDEMO;

--NOTE: DML operations reflacts on physical table data,because view doesn't have any data.

/*
WITH CHECK OPTION
    - It is applicable to a updated view.
	- If the view is not updateable, then there is no meaning of this.
	- The WITH CHECK OPTION clause is used to prevent the insertion of rows in the view where the condition in the WHERE clause in create view 
	  statement is not satisfied.
*/

SELECT * FROM STUDENT;

CREATE VIEW VWWITHCHECKOPTION
AS 
SELECT * FROM STUDENT WHERE CLASS = 'BCA'
WITH CHECK OPTION

SELECT * FROM VWWITHCHECKOPTION;

INSERT INTO VWWITHCHECKOPTION(NAMES,CLASS) VALUES('MAHI','BTECH'); /* It will show The attempted insert or update failed because the target view
                                                                      either specifies WITH CHECK OPTION or spans a view that specifies 
                                                                      WITH CHECK OPTION and one or more rows resulting 
                                                                      from the operation did not qualify under the CHECK OPTION constraint.
                                                                      The statement has been terminated.*/
    
INSERT INTO VWWITHCHECKOPTION(NAMES,CLASS) VALUES('MAHI','BCA'); --This record will be inserted.

SELECT * FROM VWWITHCHECKOPTION;

--SYSTEM DEFINED FUNCTIONS.

--GETDATE()

SELECT GETDATE(); --It will return current date and time of server.

--APP_NAME()

SELECT APP_NAME(); --It will return current using application.

--CURRENT_USER

SELECT CURRENT_USER; --It will return login user.

--COALESCE()

SELECT COALESCE(NULL,12,'AMAN') AS RESULT; --It will return first non null value.

DECLARE @FNAME VARCHAR(50)  --If first value is null then it will return second value.
SELECT COALESCE(@FNAME,'SMITH');

DECLARE @FNAME VARCHAR(50)
SET @FNAME='JHON'
SELECT COALESCE(@FNAME,'SMITH');

DECLARE @FNAME VARCHAR(50)
SELECT COALESCE('WILL','SMITH');

--USER DEFINED FUNCTIONS.

--How to create scalar function?
--Return Single Value.
/*
CREATE FUNCTION function_name (Parameters Optional)
RETURNS return-type
AS
BEGIN
Statement 1
Statement 2
Statement N
RETURN return-value
END
*/

CREATE FUNCTION AddDigit(@NUM1 INT,@NUM2 INT)
RETURNS INT
AS 
BEGIN
DECLARE @RESULT INT
SET @RESULT=@NUM1+@NUM2;
RETURN @RESULT;
END

SELECT AddDigit(); --It will return ''AddDigit' is not a recognized built-in function name'.

--When we are using a function than we need to define schema name before function name.

SELECT dbo.AddDigit(); --It will return 'An insufficient number of arguments were supplied for the procedure or function dbo.AddDigit'.

--We need to define argument when we call a function.

SELECT dbo.AddDigit(22,45);

SELECT dbo.AddDigit('abc',45); --It will show 'Conversion failed when converting the varchar value 'abc' to data type int'.

SELECT * FROM STUDENT_MARKS;

CREATE FUNCTION GETTOTAL(@RNO INT)
RETURNS INT
AS
BEGIN
DECLARE @RESULT INT
SELECT @RESULT=(MATH+ENGLISH+COMPUTER) FROM STUDENT_MARKS WHERE RNO= @RNO;
RETURN @RESULT
END

SELECT RNO,MATH,ENGLISH,COMPUTER,DBO.GETTOTAL(RNO) FROM STUDENT_MARKS; --This function will execute for every rows selected by SELECT statemnt.

SELECT DBO.GETTOTAL(6);


CREATE FUNCTION GETAVERAGE(@RNO INT)
RETURNS INT
AS
BEGIN
DECLARE @RESULT INT
SELECT @RESULT=(MATH+ENGLISH+COMPUTER)/3 FROM STUDENT_MARKS WHERE RNO= @RNO;
RETURN @RESULT
END

SELECT RNO,MATH,ENGLISH,COMPUTER,DBO.GETTOTAL(RNO) AS TOTAL,DBO.GETAVERAGE(RNO) AS AVERAGE FROM STUDENT_MARKS;

--How to create Table Valued function?
--It returns a table.

--Get student list with marks total greater than 150.

CREATE FUNCTION GETSTUDENTLIST(@TOTAL INT)
RETURNS TABLE
AS
RETURN SELECT * FROM STUDENT_MARKS WHERE (MATH+ENGLISH+COMPUTER) > @TOTAL;

SELECT * FROM DBO.GETSTUDENTLIST(150);

--COMMON TABLE EXPRESSION.

SELECT * FROM EMPLOYEE2;

WITH CTE1 AS(
SELECT EMPLOYEEID,SALARY FROM EMPLOYEE2)
SELECT * FROM CTE1;
 
WITH CTE2 AS(
SELECT AVG(SALARY) AS AVG_SALARY FROM EMPLOYEE2 GROUP BY DEPARTMENT)
SELECT MAX(AVG_SALARY) FROM CTE2;

--INSERT a row into a CTE.

WITH CTE1 AS(                                  /* When we use INSERT statement with CTE then we have no need to write INTO keyword with it.*/
SELECT * FROM EMPLOYEE2)
INSERT CTE1 VALUES(10,'Aman Dhakre','Male',10000,'Finance','1 year');

--UPDATE a row.

WITH CTE1 AS(                                 
SELECT * FROM EMPLOYEE2)
UPDATE CTE1 SET NAME = 'Aman Singh' WHERE EMPLOYEEID = 10;

--DELETE a row.

WITH CTE1 AS(                                 
SELECT * FROM EMPLOYEE2)
DELETE CTE1  WHERE EMPLOYEEID = 10; --We will not use FROM clause when we delete a row by using CTE.

WITH CTE1 AS(                                 
SELECT COUNT(*) AS [TOTAL_EMPLOYEE] FROM EMPLOYEE2 WHERE GENDER = 'MALE')
SELECT * FROM CTE1;

--Multiple CTEs with single WITH statement.

WITH CTE_1 AS
(
  SELECT * FROM EMPLOYEE2 WHERE DEPARTMENT = 'IT'
),
CTE_2 AS
(
  SELECT * FROM EMPLOYEE2 WHERE DEPARTMENT = 'FINANCE'
)
SELECT * FROM CTE_1 --These queries are our main/outer query. 
UNION 
SELECT * FROM CTE_2;

--SUBQUERIES IN SQL.

SELECT * FROM STUDENT;

SELECT * FROM STUDENT_MARKS;

--How to find the marks of student whose name is 'ADITYA' and class is '8TH'.

--=, >, <, >=, <=, != Operators are used to return single row from subquery. 

SELECT * FROM STUDENT_MARKS WHERE RNO IN(SELECT RNO FROM STUDENT WHERE NAMES = 'ADITYA' AND CLASS = '8TH');

SELECT * FROM STUDENT_MARKS WHERE RNO =(SELECT RNO FROM STUDENT WHERE NAMES = 'ADITYA' AND CLASS = '8TH');

--How to find the marks of students whose class is 'BCA'.

--IN, ANY, ALL are used to return multiple rows from subquery. 

SELECT * FROM STUDENT_MARKS WHERE RNO IN(SELECT RNO FROM STUDENT WHERE CLASS = 'BCA');

SELECT * FROM STUDENT_MARKS WHERE RNO NOT IN(SELECT RNO FROM STUDENT WHERE CLASS = 'BCA');

--ANY OPERATOR.

SELECT * FROM STUDENT_MARKS WHERE RNO >ANY(SELECT RNO FROM STUDENT WHERE CLASS='BCA');

--INSERT INTO Subquery.

--By using it we can insert/copy one table data into another table. 

SELECT * FROM STUDENT_MARKS;

CREATE TABLE STUDENT_BAK(RNO INT,MATH INT,ENGLISH INT,COMPUTER INT);

SELECT * FROM STUDENT_BAK;

INSERT INTO STUDENT_BAK SELECT * FROM STUDENT_MARKS;

--DELETE from subquery.

DELETE FROM STUDENT_BAK WHERE RNO IN (SELECT RNO FROM STUDENT_MARKS WHERE RNO >3);













