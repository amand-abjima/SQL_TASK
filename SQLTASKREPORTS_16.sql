CREATE TABLE WORKER(WID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
FIRST_NAME VARCHAR(20),
LAST_NAME VARCHAR(20),
SALARY INT,
DOJ DATETIME,
DEPARTMENT VARCHAR(20)
);

SELECT * FROM Worker;

INSERT INTO WORKER VALUES('Geetika','Chauhan',90000,'2021-04-11','Admin');

--CREATE AN INDEX ON SALARY COLUMN.

--Single Column Index.

CREATE INDEX IX_SALARY ON WORKER(SALARY ASC); 

SELECT * FROM WORKER WHERE SALARY > 80000 AND SALARY < 400000;

--DROP AN INDEX.

DROP INDEX WORKER.IX_SALARY;

--SP_HELPINDEX system store procedure used to find indexes on a table. 

SP_HELPINDEX WORKER;

SELECT * FROM CUSTOMER;

--CLUSTERED INDEX.

CREATE CLUSTERED INDEX IX_CUSTID ON CUSTOMER (CUSTOMERID DESC);

--NOW WE AGAIN APPLY ANOTHER CLUSTERED INDEX ON CUSTOMER TABLE.

CREATE CLUSTERED INDEX IX_CUSTID1 ON CUSTOMER (FIRSTNAME ASC,LASTNAME ASC); /* -> It will show "Cannot create more than one clustered index
                                                                               on table 'CUSTOMER'. Drop the existing clustered index 
																			   'IX_CUSTID' before creating another." message.
																			   -> It is showing error because we have already applied one 
																			   clustered index on customer table's CUSTOMERID column.
																			   -> One table can have only one clustered index. */

--NON CLUSTERED INDEX.

SELECT * FROM HUMANRESOURCES.DEPARTMENT;

CREATE NONCLUSTERED INDEX IX_DEPARTMENT ON HUMANRESOURCES.DEPARTMENT(NAME DESC);

CREATE NONCLUSTERED INDEX IX_DEPARTMENT1 ON HUMANRESOURCES.DEPARTMENT(GROUPNAME DESC);/*A table can have more than one non clustered index*/

--We can apply non clustered index on multiple columns.

SELECT * FROM PERSON.PERSON;

CREATE NONCLUSTERED INDEX IX_DEPARTMENT2 ON PERSON.PERSON(FIRSTNAME DESC,LASTNAME DESC);

SELECT * FROM PERSON.PERSON WHERE FIRSTNAME='TERRI' AND LASTNAME='DUFFY';

--UNIQUE OR NON-UNIQUE INDEXES.

CREATE TABLE BOOKS(
BOOKID INT NOT NULL,
BOOKNAME VARCHAR(50) NULL,
CATEGORY VARCHAR(50) NULL,
PRICE INT NULL,
PUBLISHER VARCHAR(50)
);

INSERT INTO BOOKS VALUES(1,'C++','PROGRAMMING',200,'OXFORD'),
(2,'MATH','MATHEMATICS',168,'PEARSON'),
(3,'FUNDAMENTALS OF COMPUTER','COMPUTER',190,'BLOOMSBURY'),
(4,'JAVA','PROGRAMMING',350,'OXFORD'),
(5,'PRINCIPAL OF MANAGEMENT','MANAGEMENT',240,'PEARSON');

SELECT * FROM BOOKS;

--CREATE CLUSTERED INDEX WITHOUT UNIQUE ON BOOKS TABLE.

CREATE CLUSTERED INDEX CIX_BOOKS_BOOKID
ON BOOKS(BOOKID ASC);   /* It will create Non unique index and we can insert duplicate values inside BOOKS table*/


--CREATE CLUSTERED INDEX WITH UNIQUE ON BOOKS TABLE.

CREATE UNIQUE CLUSTERED INDEX CIX_BOOKS_BOOKID
ON BOOKS(BOOKID ASC); /* It will create unique CLUSTERED index and we can't insert duplicate values inside BOOKS table*/

--Now we try to insert duplicate value inside Books table.

INSERT INTO BOOKS VALUES(5,'PRINCIPAL OF MANAGEMENT','MANAGEMENT',240,'PEARSON'); /* It will show "Cannot insert duplicate key row in
                                                                                     object 'dbo.BOOKS' with unique index 'CIX_BOOKS_BOOKID'. 
                                                                                     The duplicate key value is (5)." message */


--CREATE NON-CLUSTERED INDEX WITHOUT UNIQUE ON BOOKS TABLE.

CREATE NONCLUSTERED INDEX CIX_BOOKS_BOOKNAME
ON BOOKS(BOOKNAME ASC); --WE CAN INSERT DUPLICATE VALUE HERE.

--Now we try to insert duplicate value inside Books table.

INSERT INTO BOOKS VALUES(6,'PRINCIPAL OF MANAGEMENT','MANAGEMENT',240,'PEARSON'); --THE ROW WILL BE INSERTED.

--CREATE NON-CLUSTERED INDEX WITH UNIQUE ON BOOKS TABLE.

CREATE UNIQUE NONCLUSTERED INDEX CIX_BOOKS_BOOKNAME
ON BOOKS(BOOKNAME ASC); /* It will show "The CREATE UNIQUE INDEX statement terminated because a duplicate key was found for 
                           the object name 'dbo.BOOKS' and the index name 'CIX_BOOKS_BOOKNAME'. 
                           The duplicate key value is (PRINCIPAL OF MANAGEMENT)."message*/

--NOW WE DELETE A DUPLICATE ROW FROM BOOKS TABLE.

DELETE FROM BOOKS WHERE BOOKID = 6;

--NOW AGAIN CREATE NON-CLUSTERED INDEX WITH UNIQUE ON BOOKS TABLE.

CREATE UNIQUE NONCLUSTERED INDEX CIX_BOOKS_BOOKNAME
ON BOOKS(BOOKNAME ASC); --NOW NON CLUSTERED INDEX WILL BE APPLU ON BOOKS TABLE.