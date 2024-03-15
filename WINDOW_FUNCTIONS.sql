CREATE TABLE EMPLOYEESALES(EMP_ID INT,DEPT INT,PRODUCT_ID INT,QTY INT,SALES INT,SALES_YEAR INT);

INSERT INTO EMPLOYEESALES VALUES(100,1,1,21,200,2000);
INSERT INTO EMPLOYEESALES VALUES(101,1,1,21,150,2001);
INSERT INTO EMPLOYEESALES VALUES(102,2,2,45,211,2002);
INSERT INTO EMPLOYEESALES VALUES(103,3,2,21,2345,2003);
INSERT INTO EMPLOYEESALES VALUES(100,1,3,45,322,2004);
INSERT INTO EMPLOYEESALES VALUES(104,3,2,45,4000,2005);
INSERT INTO EMPLOYEESALES VALUES(105,1,3,56,322,2006);
INSERT INTO EMPLOYEESALES VALUES(106,2,2,32,322,2007);
INSERT INTO EMPLOYEESALES VALUES(101,2,3,22,322,2008);
INSERT INTO EMPLOYEESALES VALUES(103,3,3,44,3211,2009);
INSERT INTO EMPLOYEESALES VALUES(104,3,2,66,4000,2010);

SELECT * FROM EMPLOYEESALES;

/*
      OVER() Window Function
	  * It is the replacement of GROUP BY.When we will use OVER(), we can't use GROUP BY clause.
	  * It creates a window with multiple rows. GROUP By return single row.
	  Query: Find sales department wise with EMP_ID,PRODUCT_ID details.
*/

SELECT DEPT,SUM(SALES) FROM EMPLOYEESALES GROUP BY DEPT;

SELECT SUM(SALES) FROM EMPLOYEESALES;

SELECT EMP_ID,PRODUCT_ID,SUM(SALES) OVER() AS 'TOTAL_SALES' FROM EMPLOYEESALES;

SELECT EMP_ID,PRODUCT_ID,SUM(SALES) OVER() AS 'TOTAL_SALES',AVG(SALES) OVER() AS 'AVG_SALES' FROM EMPLOYEESALES;

SELECT EMP_ID,PRODUCT_ID,SUM(SALES) FROM EMPLOYEESALES GROUP BY EMP_ID,PRODUCT_ID;

/*
    PARTITION BY
	* The PARTITION BY clause is used to divide the result set from the query into data subsets.
	 Query: Find sales department wise with EMP_ID,PRODUCT_ID details.
*/

SELECT EMP_ID,PRODUCT_ID,DEPT,SUM(SALES) OVER(PARTITION BY DEPT) AS 'TOTALSALES' FROM EMPLOYEESALES;
SELECT EMP_ID,PRODUCT_ID,DEPT,SUM(SALES) OVER(PARTITION BY DEPT ORDER BY EMP_ID) AS 'TOTALSALES' FROM EMPLOYEESALES;


SELECT EMP_ID,DEPT,SUM(SALES) OVER(PARTITION BY DEPT) AS 'TOTALSALES',AVG(SALES) 
OVER(PARTITION BY DEPT) AS 'AVGSALES' FROM EMPLOYEESALES;

--SELECT EMP_ID,PRODUCT_ID,DEPT,SUM(SALES) OVER(PARTITION BY PRODUCT_ID) AS 'TOTALSALES' FROM EMPLOYEESALES;

/*
    RANK() WINDOW FUNCTION
	* The RANK() ranking window function returns a unique rank number for each distinct row within the partition
	according to a specified column value.
	* RANK() function always work on OVER() function with ORDER BY clause.
	* RANK() function skip the numbers.
*/

SELECT EMP_ID,PRODUCT_ID,DEPT,SALES,
RANK() OVER(ORDER BY SALES DESC) AS 'SALES_RANK'
FROM EMPLOYEESALES;

SELECT EMP_ID,PRODUCT_ID,DEPT,SALES,
RANK() OVER(PARTITION BY DEPT ORDER BY SALES DESC) AS 'SALES_RANK'
FROM EMPLOYEESALES;

SELECT EMP_ID,PRODUCT_ID,DEPT,SALES,
RANK() OVER(PARTITION BY DEPT ORDER BY SALES ASC) AS 'SALES_RANK'
FROM EMPLOYEESALES;

/*
    DENSE_RANK() WINDOW FUNCTION
	* The DENSE_RANK() ranking window function is similar to the RANK() except for one difference ,
	it doesn't skip any rows when ranking rows.
*/

SELECT EMP_ID,PRODUCT_ID,DEPT,SALES,
RANK() OVER(ORDER BY SALES DESC) AS 'SALES_RANK',
DENSE_RANK() OVER(ORDER BY SALES DESC) AS 'DENSE_SALES_RANK'
FROM EMPLOYEESALES;

SELECT EMP_ID,PRODUCT_ID,DEPT,SALES,
RANK() OVER(PARTITION BY DEPT ORDER BY SALES DESC) AS 'SALES_RANK',
DENSE_RANK() OVER(PARTITION BY DEPT ORDER BY SALES DESC) AS 'DENSE_SALES_RANK'
FROM EMPLOYEESALES;

SELECT EMP_ID,PRODUCT_ID,DEPT,SALES,
RANK() OVER(PARTITION BY DEPT ORDER BY SALES ASC) AS 'SALES_RANK',
DENSE_RANK() OVER(PARTITION BY DEPT ORDER BY SALES ASC) AS 'DENSE_SALES_RANK'
FROM EMPLOYEESALES;

/*
    ROW_NUMBER() WINDOW FUNCTION.
	* We use ROW_NUMBER() Rank function to get a unique sequential number for each row 
	in the specified data.
*/

SELECT EMP_ID,PRODUCT_ID,DEPT,SALES,
ROW_NUMBER() OVER(ORDER BY SALES DESC) AS 'ROW_NUMBER'
FROM EMPLOYEESALES;

SELECT EMP_ID,PRODUCT_ID,DEPT,SALES,
ROW_NUMBER() OVER(PARTITION BY DEPT ORDER BY SALES DESC) AS 'ROW_NUMBER'
FROM EMPLOYEESALES;

SELECT EMP_ID,PRODUCT_ID,DEPT,SALES,
ROW_NUMBER() OVER(PARTITION BY DEPT ORDER BY SALES ASC) AS 'ROW_NUMBER'
FROM EMPLOYEESALES;

SELECT EMP_ID,PRODUCT_ID,DEPT,SALES,
ROW_NUMBER() OVER(PARTITION BY PRODUCT_ID ORDER BY SALES ASC) AS 'ROW_NUMBER'
FROM EMPLOYEESALES;

/* 
   NTILE(N) WINDOW FUNCTION
   * We use the NTILE(N) function to distribute the number of rows in the specified (N) number of groups.
   * It divide the total number of rows by giving number and returns group according to that.
*/

SELECT EMP_ID,PRODUCT_ID,DEPT,SALES,
NTILE(1) OVER(ORDER BY SALES DESC) AS 'ROW_NUMBER'
FROM EMPLOYEESALES;

SELECT EMP_ID,PRODUCT_ID,DEPT,SALES,
NTILE(2) OVER(ORDER BY SALES DESC) AS 'ROW_NUMBER'
FROM EMPLOYEESALES;

SELECT EMP_ID,PRODUCT_ID,DEPT,SALES,
NTILE(3) OVER(ORDER BY SALES DESC) AS 'ROW_NUMBER'
FROM EMPLOYEESALES;

/* 
   LAG() and LEAD() Window Function.
   * The lAG() function has the ability to fetch data from a previous row.
   * The LEAD() function fetches data from a subsequent row.
*/

SELECT EMP_ID,PRODUCT_ID,DEPT,SALES,
LAG(SALES) OVER(ORDER BY SALES ASC) AS 'PREVIOUS_YEAR',
LEAD(SALES) OVER(ORDER BY SALES ASC) AS 'NEXT_YEAR'
FROM EMPLOYEESALES;

/* 
   FIRST_VALUE() and LAST_VALUE() Window Function.
   * The FIRST_VALUE() function returns the first value.
   * The LAST_VALUE() function returns the last value.
*/

SELECT EMP_ID,PRODUCT_ID,DEPT,SALES,
FIRST_VALUE(SALES) OVER(ORDER BY SALES ASC) AS 'FIRST_VALUE',
LAST_VALUE(SALES) OVER(ORDER BY SALES ASC) AS 'LAST_VALUE'
FROM EMPLOYEESALES;

SELECT EMP_ID,PRODUCT_ID,DEPT,SALES,
FIRST_VALUE(SALES) OVER(ORDER BY SALES ASC) AS 'FIRST_VALUE'
FROM EMPLOYEESALES;

SELECT EMP_ID,PRODUCT_ID,DEPT,SALES,
LAST_VALUE(SALES) OVER(ORDER BY SALES DESC) AS 'LAST_VALUE'
FROM EMPLOYEESALES;

CREATE TABLE TESTDATA(ID INT,PRODUCT VARCHAR(50));

INSERT INTO TESTDATA VALUES(100,'LAPTOP');
INSERT INTO TESTDATA VALUES(200,'LAPTOP');
INSERT INTO TESTDATA VALUES(500,'SMARTPHONE');
INSERT INTO TESTDATA VALUES(700,'SMARTPHONE');
INSERT INTO TESTDATA VALUES(200,'PRINTER');
INSERT INTO TESTDATA VALUES(300,'PRINTER');
INSERT INTO TESTDATA VALUES(500,'PRINTER');

SELECT * FROM TESTDATA;

--AGGREGATE FUNCTIONS WITH WINDOW FUNCTIONS.

SELECT ID,PRODUCT,
SUM(ID) OVER() AS 'TOTAL',
AVG(ID) OVER() AS 'AVERAGE',
COUNT(ID) OVER() AS 'TOTAL_COUNT',
MAX(ID) OVER() AS 'MAXIMUM',
MIN(ID) OVER() AS 'MINIMUM'
FROM TESTDATA;

SELECT ID,PRODUCT,
SUM(ID) OVER(PARTITION BY PRODUCT) AS 'TOTAL',
AVG(ID) OVER(PARTITION BY PRODUCT) AS 'AVERAGE',
COUNT(ID) OVER(PARTITION BY PRODUCT) AS 'TOTAL_COUNT',
MAX(ID) OVER(PARTITION BY PRODUCT) AS 'MAXIMUM',
MIN(ID) OVER(PARTITION BY PRODUCT) AS 'MINIMUM' 
FROM TESTDATA;

SELECT ID,PRODUCT,
SUM(ID) OVER(PARTITION BY PRODUCT ORDER BY ID) AS 'TOTAL',
AVG(ID) OVER(PARTITION BY PRODUCT ORDER BY ID) AS 'AVERAGE',
COUNT(ID) OVER(PARTITION BY PRODUCT ORDER BY ID) AS 'TOTAL_COUNT',
MAX(ID) OVER(PARTITION BY PRODUCT ORDER BY ID) AS 'MAXIMUM',
MIN(ID) OVER(PARTITION BY PRODUCT ORDER BY ID) AS 'MINIMUM' 
FROM TESTDATA;

/* 
   * "ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING" WILL GIVE A SINGLE OUTPUT 
      BASED ON ALL INPUT VALUES/PARTITION(IF USED).
*/

SELECT ID,PRODUCT,
SUM(ID) OVER(ORDER BY ID ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS 'TOTAL',
AVG(ID) OVER(ORDER BY ID ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS 'AVERAGE',
COUNT(ID) OVER(ORDER BY ID ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS 'TOTAL_COUNT',
MAX(ID) OVER(ORDER BY ID ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS 'MAXIMUM',
MIN(ID) OVER(ORDER BY ID ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS 'MINIMUM' 
FROM TESTDATA;

SELECT ID,PRODUCT,
SUM(ID) OVER(PARTITION BY PRODUCT ORDER BY ID ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS 'TOTAL',
AVG(ID) OVER(PARTITION BY PRODUCT ORDER BY ID ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS 'AVERAGE',
COUNT(ID) OVER(PARTITION BY PRODUCT ORDER BY ID ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS 'TOTAL_COUNT',
MAX(ID) OVER(PARTITION BY PRODUCT ORDER BY ID ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS 'MAXIMUM',
MIN(ID) OVER(PARTITION BY PRODUCT ORDER BY ID ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS 'MINIMUM' 
FROM TESTDATA;

--RANKING FUNCTION.

SELECT ID,
RANK() OVER(ORDER BY ID) AS 'RANK',
DENSE_RANK() OVER(ORDER BY ID) AS 'DENSE_RANK',
ROW_NUMBER() OVER(ORDER BY ID) AS 'ROW_NUMBER'
FROM TESTDATA;

SELECT ID,PRODUCT,
RANK() OVER(PARTITION BY PRODUCT ORDER BY ID) AS 'RANK',
DENSE_RANK() OVER(PARTITION BY PRODUCT ORDER BY ID) AS 'DENSE_RANK',
ROW_NUMBER() OVER( PARTITION BY PRODUCT ORDER BY ID) AS 'ROW_NUMBER'
FROM TESTDATA;

--ANALYTIC/VALUE FUNCTION.

SELECT ID,
FIRST_VALUE(ID) OVER(ORDER BY ID) AS 'FIRST_VALUE',
LAST_VALUE(ID) OVER(ORDER BY ID) AS 'LAST_VALUE',
LEAD(ID) OVER(ORDER BY ID) AS 'LEAD',
LAG(ID) OVER(ORDER BY ID) AS 'LAG'
FROM TESTDATA;

/* 
    * IF WE WANT THE SINGLE LAST VALUE FROM WHOLE COLUMN,WE NEED TO USE
	  "ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING".
*/

SELECT ID,PRODUCT,
FIRST_VALUE(ID) OVER(PARTITION BY PRODUCT ORDER BY ID) AS 'FIRST_VALUE',
LAST_VALUE(ID) OVER(PARTITION BY PRODUCT ORDER BY ID) AS 'LAST_VALUE',
LEAD(ID) OVER(PARTITION BY PRODUCT ORDER BY ID) AS 'LEAD',
LAG(ID) OVER(PARTITION BY PRODUCT ORDER BY ID) AS 'LAG'
FROM TESTDATA;

--QUESTION: Offset the LEAD and LAG values by 2 in output columns.

SELECT ID,
LEAD(ID,2) OVER(ORDER BY ID) AS 'LEAD',
LAG(ID,2) OVER(ORDER BY ID) AS 'LAG'
FROM TESTDATA;

--QUESTION: Offset the LEAD and LAG values by 3 in output columns.

SELECT ID,
LEAD(ID,3) OVER(ORDER BY ID) AS 'LEAD',
LAG(ID,3) OVER(ORDER BY ID) AS 'LAG'
FROM TESTDATA;

SELECT * FROM EMPLOYEESALES;

CREATE TABLE Sales (
    Product_id INT,
    Category VARCHAR(50),
    Sales_amount DECIMAL(10, 2)
);

INSERT INTO Sales (Product_id, Category, Sales_amount) VALUES (1, 'Electronics' , 500);
INSERT INTO Sales (Product_id, Category, Sales_amount) VALUES (2, 'Clothing' , 300);
INSERT INTO Sales (Product_id, Category, Sales_amount) VALUES (3, 'Electronics' , 700);
INSERT INTO Sales (Product_id, Category, Sales_amount) VALUES (4, 'Clothing' , 400);
INSERT INTO Sales (Product_id, Category, Sales_amount) VALUES (5, 'Electronics' , 600);

SELECT * FROM SALES;

SELECT product_id, category, sales_amount,
       SUM(sales_amount) OVER (PARTITION BY category ) AS cumulative_sales,
       SUM(sales_amount) OVER (PARTITION BY category ORDER BY product_id) AS cumulative_sales,
       ROW_NUMBER() OVER (PARTITION BY category ORDER BY product_id) AS cumulative_sales
FROM sales
WHERE category = 'Clothing'

SELECT product_id, category, sales_amount,
       SUM(sales_amount) OVER (PARTITION BY category ORDER BY product_id) AS cumulative_sales
FROM sales;
