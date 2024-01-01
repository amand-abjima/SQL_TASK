--DDL TRIGGERS IN SQL SERVER.

--SYNTAX.

CREATE TRIGGER <trigger_name>
ON {ALL SERVER | DATABASE}
[WITH ENCRYPTION]
{FOR | AFTER} { <EVENT_TYPE>}
AS <SQL_STATEMENT>


--TRIGGER FOR CREATE A TABLE.

CREATE TRIGGER TR_CREATETABLE
ON DATABASE
FOR CREATE_TABLE
AS
BEGIN
   PRINT 'NEW TABLE CREATED !!';
END

--Now we will create a database table.

CREATE TABLE TEST_TBL(ID INT,TEST VARCHAR(50)); /* As well as we will create a table in the database it will show 'NEW TABLE CREATED !!' message.*/

--TRIGGER FOR ALTER A TABLE.

CREATE TRIGGER TR_ALTERTABLE
ON DATABASE
FOR ALTER_TABLE
AS
BEGIN
   PRINT 'YOU HAVE ALTERED A TABLE !!';
END

--Now we will alter a database table by adding a column.

ALTER TABLE TEST_TBL ADD DEPARTMENT VARCHAR(20); /* -> It will show "YOU HAVE ALTERED A TABLE !!" message.
                                                    -> When will someone ALTER a table in 'DATABASE1' database, then "TR_ALTERTABLE" 
													trigger will be run. */

SELECT * FROM TEST_TBL; /*-> Till now we allowing user to do modification in our database even creation or altering of table.
                          -> we have not applied any restriction.*/


--TRIGGER FOR DROP A TABLE.

CREATE TRIGGER TR_DROPTABLE
ON DATABASE
FOR DROP_TABLE
AS
BEGIN
   PRINT 'YOU HAVE DROPPED A TABLE !!';
END

--Now we will drop a table.

DROP TABLE TEST_TBL;

/*We were creating different triggers for different events till now.But we can use all those events in one trigger.*/

--Now we will create a trigger for all 3 events.

CREATE TRIGGER TR_ALLTRIGGERS  --This is just one trigger but will run for all 3 events.
ON DATABASE
FOR CREATE_TABLE, ALTER_TABLE, DROP_TABLE
AS
BEGIN
   PRINT 'WE HAVE CREATED, ALTERED, AND DROPPED A TABLE !!';
END

--Now we will again CREATE, ALTER and DROP a table.

CREATE TABLE TEST_TBL(ID INT,TEST VARCHAR(50)); --It will show "WE HAVE CREATED, ALTERED, AND DROPPED A TABLE !!" message.

ALTER TABLE TEST_TBL ADD DEPARTMENT VARCHAR(20); --It will show "WE HAVE CREATED, ALTERED, AND DROPPED A TABLE !!" message.

DROP TABLE TEST_TBL;  --It will show "WE HAVE CREATED, ALTERED, AND DROPPED A TABLE !!" message.

--For all above queries same trigger will run.

--List of all DDL events.

https://learn.microsoft.com/en-us/sql/relational-databases/triggers/ddl-events?view=sql-server-ver16

--We can apply one trigger upon another trigger.

--Now we will create/apply trigger on stored procedure.

/*->Now we will apply restriction that if someone wants to create Stored Procedure then,they will not able to create stored procedure.
-> Till now we were printing messages through triggers.*/

/*Now we will create a trigger for if someone wants to create stored procedure then this trigger will run,and it will display message a user can't 
create a stored procedure.*/

--In DDL triggers, there is no concept of INSTEAD OF TRIGGERS.

--Now we will create a trigger for stored procedure.

CREATE TRIGGER TR_SP     
ON DATABASE 
FOR CREATE_PROCEDURE
AS
BEGIN
    ROLLBACK
	PRINT 'YOU ARE NOT ALLOWED TO CREATE A STORED PROCEDURE!!'
END    /* In this trigger we are using ROLLBACK command.Whenever we want to create Stored Procedure then ROLLBACK command will not let it perform
         this event and rollback this event to perform and message will print.*/

--Now we will create Stored Procedure.

CREATE PROCEDURE SP_MYPROCEDURE
AS
BEGIN
    PRINT 'THIS IS MY STORED PROCEDURE!!';  /* It will show "The transaction ended in the trigger. The batch has been aborted." message.*/
END                                               

--We can also use ROLLBACK command with CREATE_TABLE,CREATE_VIEW,ALTER_TABLE,DROP_TABLE etc. events.

--We can also perform ALTER_PROCEDURE,DROP_PROCEDURE,CREATE_VIEW,ALTER AND DROP_VIEW events.

--WITH ENCRYPTION.

ALTER TRIGGER TR_SP     
ON DATABASE 
WITH ENCRYPTION
FOR CREATE_PROCEDURE
AS
BEGIN
    ROLLBACK
	PRINT 'YOU ARE NOT ALLOWED TO CREATE A STORED PROCEDURE!!'
END 

SP_HELPTEXT TR_SP; /* -> It will show "The object 'TR_SP' does not exist in database 'DATABASE1' or is invalid for this operation." message.
                      -> We can't use "SP_HELPTEXT" command to see database triggers code,use only for see table triggers code.
					  -> TR_SP trigger is applied on entire database not only on single table.*/
		
--We can also apply restriction on CREATE_TABLE event by using ROLLBACK command.

CREATE TRIGGER TR_CREATETABLE
ON DATABASE
FOR CREATE_TABLE
AS
BEGIN
   ROLLBACK
   PRINT 'You can not create a table in this database.';
END

DROP TABLE TEST_TBL;

CREATE TABLE TEST_TBL(ID INT); /* -> It will show "The transaction ended in the trigger. The batch has been aborted."message.
                                  -> Here two triggers will run.But 2nd trigger will work.*/

--We can Disable a trigger.

DISABLE TRIGGER TR_CREATETABLE ON DATABASE; /* ->Here we are DISABLE "TR_CREATETABLE" trigger.
                                               -> When we will disable "TR_CREATETABLE" trigger then any user can create a table on database.
											   -> Firstly "TR_CREATETABLE" trigger rollback the CREATE_TABLE event from creating a table.*/

--No we will again create a table.

CREATE TABLE TEST2(ID INT); --Here new table will be created,because we disabled a rollback trigger.

--We can create one or more than one DDL triggers on database or server.

--We can Enable a trigger.

ENABLE TRIGGER TR_CREATETABLE ON DATABASE; 

--Now we again try to create new table.

CREATE TABLE TEST3(ID INT); /* -> It will show "The transaction ended in the trigger. The batch has been aborted."message.
                           -> It is happening because now "TR_CREATETABLE" has been enable,which contain ROLLBACK command.So table will not be create.*/


--To RENAME a table name or column name of table.

CREATE TRIGGER TR_RENAMETABLE
ON DATABASE
FOR RENAME
AS
BEGIN
    PRINT 'You have just renamed a table or table column';
END

SELECT * FROM TEST2;

--Here we will RENAME a table name.

SP_RENAME 'TEST2','TEST3';

--Here we will RENAME a column name.

SP_RENAME 'TEST3.ID','STUDENT_ID';

SELECT * FROM TEST3; /* When we executed SP_RENAME stored procedure then "TR_RENAMETABLE" trigger will run.*/

--DROP A TRIGGER FROM A DATABASE.

DROP TRIGGER TR_RENAMETABLE ON DATABASE;

--DROP A TRIGGER FROM A DATABASE TABLE.

DROP TRIGGER TEST3;

--DATABASE SCOPED TRIGGERS:

CREATE TRIGGER TR_DATABASESCOPETRIGGER
ON DATABASE
FOR CREATE_TABLE
AS
BEGIN
    PRINT 'You have just CREATE a table.';
END

--SERVER SCOPED TRIGGERS:

CREATE TRIGGER TR_SERVERSCOPETRIGGER
ON ALL SERVER
FOR CREATE_TABLE
AS
BEGIN
    PRINT 'You have just CREATE a table.';
END

CREATE TABLE MY_TABLE(ID INT);

--Now we will ALTER server scoped trigger by using ROLLBACK command.

ALTER TRIGGER TR_SERVERSCOPETRIGGER
ON ALL SERVER
FOR CREATE_TABLE
AS
BEGIN
    ROLLBACK
    PRINT 'You are not able to CREATE a table.';
END

--Now we will try to create a table.

CREATE TABLE MY_TABLE2(ID INT); /* ->It will show "The transaction ended in the trigger. The batch has been aborted."message.
                               -> We have use ROLLBACK command in "TR_SERVERSCOPETRIGGER" trigger which will ROLLBACK the CREATE_TABLE event to perform.
							   -> We created this table in DATABASE1 database,if we try to create this table inside another database,
							   it can't create a table because the scope of trigger is server based.*/


--Now we will create server based trgigger for view.

CREATE TRIGGER TR_SERVERSCOPETRIGGER_VIEW
ON ALL SERVER
FOR CREATE_VIEW
AS
BEGIN
    ROLLBACK
    PRINT 'You are not able to CREATE a VIEW.';
END

--Now we will create a view on STUDENT1.

SELECT * FROM STUDENT1;

CREATE VIEW VW_STUDENT
AS 
SELECT SID,FULLNAME FROM STUDENT1; /* -> It will show "The transaction ended in the trigger. The batch has been aborted". message.
                                     -> As we try to create a view the "TR_SERVERSCOPETRIGGER_VIEW" trigger will execute and rollback the CREATE_VIEW
									 event to create a view.*/

--We can also use WITH ENCRYPTION command with Server Scoped DDL triggers.

ALTER TRIGGER TR_SERVERSCOPETRIGGER_VIEW
ON ALL SERVER
WITH ENCRYPTION
FOR CREATE_VIEW
AS
BEGIN
    ROLLBACK
    PRINT 'You are not able to CREATE a VIEW.';
END

--We can also ENABLE and DISABLE Server Scoped DDL Triggers.

DISABLE TRIGGER TR_SERVERSCOPETRIGGER_VIEW ON ALL SERVER;

ENABLE TRIGGER TR_SERVERSCOPETRIGGER_VIEW ON ALL SERVER;

--We can also use ALTER and DROP command with Server Scoped DDL Triggers.

--DELETE a trigger.

DROP TRIGGER TR_SERVERSCOPETRIGGER_VIEW ON ALL SERVER;

--Execution Order of DML Triggers.

--SYNTAX.

EXEC SP_SETTRIGGERORDER
@TRIGGERNAME = 'EMPLOYEE DELETION',
@ORDER = 'FIRST',
@STMTTYPE = 'DELETE';

SELECT * FROM STUDENT1;

--Now we will create first trigger on STUDENT1 table.

CREATE TRIGGER TR_STU3
ON STUDENT1
AFTER INSERT
AS
BEGIN
PRINT '3rd TRIGGER IS FIRED!!';
END

--Now we will create second trigger on STUDENT1 table.

CREATE TRIGGER TR_STU2
ON STUDENT1
AFTER INSERT
AS
BEGIN
PRINT '2rd TRIGGER IS FIRED!!';
END

--Now we will create third trigger on STUDENT1 table.

CREATE TRIGGER TR_STU1
ON STUDENT1
AFTER INSERT
AS
BEGIN
PRINT '1st TRIGGER IS FIRED!!';
END

--Now we will INSERT a row into STUDENT1 table.

SELECT * FROM STUDENT1;

INSERT INTO STUDENT1 VALUES('STU/008','ADITI',2,'1997-08-23'); 

/* Insert row will show 3rd TRIGGER IS FIRED!!
                        2rd TRIGGER IS FIRED!!
                        1st TRIGGER IS FIRED!!

                         (1 row affected) message.
-> The execution is happening in sam e queue as we create triggers.*/

--Now we want to set the order of execution of triggers.

--We want to execute bottom triggr first and top trigger at last.

EXEC SP_SETTRIGGERORDER
@TRIGGERNAME = 'TR_STU1',
@ORDER = 'FIRST',
@STMTTYPE = 'INSERT';

--Now we again insert one row in STUDENT1 table.

INSERT INTO STUDENT1 VALUES('STU/009','VIDISHA',2,'1992-02-09'); 

/* Insert row will show 1st TRIGGER IS FIRED!!
                        3rd TRIGGER IS FIRED!!
                        2rd TRIGGER IS FIRED!!

                         (1 row affected) message.
-> Here 1st trigger is coming on top but 3rd trigger is not coming at last position.*/

--Now we want that 3rd trigger will come at last position.

EXEC SP_SETTRIGGERORDER
@TRIGGERNAME = 'TR_STU3',
@ORDER = 'LAST',
@STMTTYPE = 'INSERT';

--Now we again INSERT one row into STUDENT1 table.

INSERT INTO STUDENT1 VALUES('STU/010','ROHIT',1,'1993-05-20'); 

/* This INSERT row will show 1st TRIGGER IS FIRED!!
                             2rd TRIGGER IS FIRED!!
                             3rd TRIGGER IS FIRED!!

                              (1 row affected) message.
-> Here we set the order of triggers.
-> SP_SETTRIGGERORDER stored procedure only set top and bottom position order,it will not focus on middle position triggers.*/

