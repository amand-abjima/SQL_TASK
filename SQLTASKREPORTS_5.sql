--GROUP BY Clause.

--How many people are in each unique state in the customers table? 
--Select the state and display the number of people in each. Hint: count is used to count rows in a column, sum works on numeric data only.

SELECT STATE,COUNT(*) AS NOOFPEOPLE FROM CUSTOMERS GROUP BY STATE;

--From the items_ordered table, select the item, maximum price, and minimum price for each specific item in the table.
--Hint: The items will need to be broken up into separate groups.

SELECT ITEM,MAX(PRICE),MIN(PRICE) FROM ITEMS_ORDERED GROUP BY ITEM;

--How many orders did each customer make? Use the items_ordered table. 
--Select the customerid, number of orders they made, and the sum of their orders.

SELECT CUSTOMERID,COUNT(*),SUM(PRICE) FROM ITEMS_ORDERED GROUP BY CUSTOMERID;

-- Find the total number of streams by date.

SELECT DATE,SUM(NUMBER_OF_STREAMS) FROM MOVIE_STREAMING GROUP BY DATE;

--Find the total number of streams by date and director.

SELECT DATE,DIRECTOR,SUM(NUMBER_OF_STREAMS) FROM MOVIE_STREAMING GROUP BY DATE,DIRECTOR;

--Find the total number of streams by date and director. Show only dates with a total number of streams above 740.

SELECT DATE, DIRECTOR, SUM(NUMBER_OF_STREAMS) FROM MOVIE_STREAMING GROUP BY DATE,DIRECTOR HAVING SUM(NUMBER_OF_STREAMS)>740;

--HAVING Clause.

--How many people are in each unique state in the customers table that have more than one person in the state? 
--Select the state and display the number of how many people are in each if it’s greater than 1.

SELECT STATE,COUNT(*) 
FROM CUSTOMERS 
GROUP BY STATE 
HAVING COUNT(*)>1;

--From the items_ordered table, select the item, maximum price, and minimum price for each specific item in the table. 
--Only display the results if the maximum price for one of the items is greater than 190.00.

SELECT ITEM,MAX(PRICE) 
FROM ITEMS_ORDERED 
GROUP BY ITEM
HAVING MAX(PRICE)>190.00;

--How many orders did each customer make? Use the items_ordered table. 
--Select the customerid, number of orders they made, and the sum of their orders if they purchased more than 1 item.

SELECT customerid, count(customerid), sum(price)
FROM items_ordered
GROUP BY customerid
HAVING count(customerid) > 1;

CREATE TABLE ORDERS1(ORD_NO INT PRIMARY KEY,PURCH_AMT FLOAT,ORD_DATE DATE,CUSTOMER_ID INT,SALESMAN_ID INT);

INSERT INTO ORDERS1 VALUES(70013,3045.6,'2012-04-25',3002,5001);

SELECT * FROM ORDERS1;

--From the following table, write a SQL query to calculate total purchase amount of all orders. Return total purchase amount.

SELECT SUM(PURCH_AMT) FROM ORDERS1;

--From the following table, write a SQL query to calculate the average purchase amount of all orders. Return average purchase amount. 

--ord_no      purch_amt   ord_date    customer_id  salesman_id

SELECT AVG(PURCH_AMT) FROM ORDERS1;

-- From the following table, write a SQL query that counts the number of unique salespeople. Return number of salespeople. 

SELECT COUNT(DISTINCT SALESMAN_ID) FROM ORDERS1;

--  From the following table, write a SQL query to count the number of customers. Return number of customers.  

SELECT COUNT(CUSTOMER_ID) FROM CUSTOMERS;

-- From the following table, write a SQL query to determine the number of customers who received at least one grade for their activity.  

SELECT COUNT(ALL GRADE) FROM CUSTOMERS;

--From the following table, write a SQL query to find the maximum purchase amount.  

SELECT MAX(PURCH_AMT) FROM ORDERS1;

-- From the following table, write a SQL query to find the minimum purchase amount. 

SELECT MIN(PURCH_AMT) FROM ORDERS1;

--From the following table, write a SQL query to find the highest purchase amount ordered by each customer. Return customer ID, maximum purchase amount. 

SELECT CUSTOMERID,MAX(PURCH_AMT) FROM ORDERS1 ORDER BY CUSTOMER_ID;

--From the following table, write a SQL query to find the highest purchase amount ordered by each customer on a particular date.
--Return, order date and highest purchase amount.

SELECT CUSTOMER_ID,ORD_DATE,MAX(PURCH_AMT) FROM ORDERS1 GROUP BY CUSTOMER_ID,ORD_DATE;

--From the following table, write a SQL query to determine the highest purchase amount made by each salesperson on '2012-08-17'.
--Return salesperson ID, purchase amount.

SELECT SALESMAN_ID, MAX(PURCH_AMT) FROM ORDERS1 WHERE ORD_DATE = '2012-08-17' GROUP BY SALESMAN_ID;

--From the following table, write a SQL query to find the highest order (purchase) amount by each customer on a particular order date.
--Filter the result by highest order (purchase) amount above 2000.00. Return customer id, order date and maximum purchase amount.

SELECT CUSTOMER_ID,ORD_DATE,MAX(PURCH_AMT) FROM ORDERS1 GROUP BY CUSTOMER_ID,ORD_DATE HAVING MAX(PURCH_AMT)>2000.0;

--From the following table, write a SQL query to find the maximum order (purchase) amount in the range 2000 - 6000 (Begin and end values are included.)
--by combination of each customer and order date. Return customer id, order date and maximum purchase amount.

SELECT CUSTOMER_ID,ORD_DATE,MAX(PURCH_AMT) FROM ORDERS1 GROUP BY CUSTOMER_ID,ORD_DATE HAVING MAX(PURCH_AMT) BETWEEN 2000 AND 6000;

--From the following table, write a SQL query to find the maximum order (purchase) amount based on the combination of each customer and order date. 
--Filter the rows for maximum order (purchase) amount is either 2000, 3000, 5760, 6000. Return customer id, order date and maximum purchase amount.

SELECT CUSTOMER_ID,ORD_DATE,MAX(PURCH_AMT) FROM ORDERS1 GROUP BY CUSTOMER_ID,ORD_DATE HAVING MAX(PURCH_AMT) IN (2000,3000,5760,6000);

--From the following table, write a SQL query to determine the maximum order amount for each customer. 
--The customer ID should be in the range 3002 and 3007(Begin and end values are included.). 
--Return customer id and maximum purchase amount.

SELECT CUSTOMER_ID,MAX(PURCH_AMT) FROM ORDERS1 WHERE CUSTOMER_ID BETWEEN 3002 AND 3007 GROUP BY CUSTOMER_ID;

--From the following table, write a SQL query to find the maximum order (purchase) amount for each customer. 
--The customer ID should be in the range 3002 and 3007(Begin and end values are included.).
--Filter the rows for maximum order (purchase) amount is higher than 1000. Return customer id and maximum purchase amount.

SELECT CUSTOMER_ID,MAX(PURCH_AMT) FROM ORDERS1 WHERE CUSTOMER_ID BETWEEN 3002 AND 3007 GROUP BY CUSTOMER_ID HAVING MAX(PURCH_AMT)>1000;

--From the following table, write a SQL query to determine the maximum order (purchase) amount generated by each salesperson. 
--Filter the rows for the salesperson ID is in the range 5003 and 5008 (Begin and end values are included.).
--Return salesperson id and maximum purchase amount.

SELECT SALESMAN_ID,MAX(PURCH_AMT) FROM ORDERS1 WHERE SALESMAN_ID BETWEEN 5003 AND 5008 GROUP BY SALESMAN_ID;

SELECT SALESMAN_ID,MAX(PURCH_AMT) FROM ORDERS1 GROUP BY SALESMAN_ID HAVING SALESMAN_ID BETWEEN 5003 AND 5008;

-- From the following table, write a SQL query to count all the orders generated on '2012-08-17'. Return number of orders.

SELECT COUNT(*) FROM ORDERS1 WHERE ORD_DATE ='2012-08-17';

--From the following table, write a SQL query to count the number of salespeople in a city. Return number of salespeople.

SELECT COUNT(*) FROM SALESMAN;

SELECT COUNT(*) FROM SALESMAN IS NULL;

--From the following table, write a SQL query to count the number of orders based on the combination of each order date and salesperson.
--Return order date, salesperson id.

SELECT ORD_DATE,SALESMAN_ID,COUNT(*) FROM ORDERS1 GROUP BY ORD_DATE,SALESMAN_ID,SALESMAN_ID;

--From the following table, write a SQL query to calculate the average product price. Return average product price.

SELECT AVG(PRO_PRICE) AS AVERAGEPRICE FROM ITEM_MAST;

--From the following table, write a SQL query to count the number of products whose price are higher than or equal to 350. 
--Return number of products.

SELECT COUNT(PRO_ID) FROM ITEM_MAST WHERE PRO_PRICE>=350;

--From the following table, write a SQL query to compute the average price for unique companies. Return average price and company id.

SELECT AVG(DISTINCT PRO_PRICE) AS AVERAGE_PRICE,PRO_COM AS COMPANY_ID FROM ITEM_MAST GROUP BY PRO_COM; 

--From the following table, write a SQL query to compute the sum of the allotment amount of all departments. Return sum of the allotment amount.

SELECT SUM(DPT_ALLOTMENT) FROM EMP_DEPARTMENT;

--From the following table, write a SQL query to count the number of employees in each department. Return department code and number of employees.

SELECT EMP_DEPT,COUNT(*) FROM EMP_DETAILS GROUP BY EMP_DEPT;

CREATE TABLE Employee2 (
  EmployeeId int,
  Name varchar(20),
  Gender varchar(20),
  Salary int,
  Department varchar(20),
  Experience varchar(20)
);

INSERT INTO Employee2 (EmployeeId, Name, Gender, Salary, Department, Experience)VALUES (9, 'Aarti Desai', 'Female', 50000, 'IT', '3 years');

SELECT * FROM EMPLOYEE2;

--Write a query to find sum of salary of each department.

SELECT DEPARTMENT,SUM(SALARY) FROM EMPLOYEE2 GROUP BY DEPARTMENT;

--display the departments where the sum of salaries is 50,000 or more.

SELECT DEPARTMENT,SUM(SALARY) FROM EMPLOYEE2 GROUP BY DEPARTMENT HAVING SUM(SALARY)>50000;

CREATE TABLE Student1(
   student Varchar(20),
   percentage int
);

INSERT INTO STUDENT1 VALUES ('Rahat Ali', 98); 

SELECT * FROM STUDENT1;

SELECT STUDENT,PERCENTAGE FROM STUDENT1 GROUP BY STUDENT,PERCENTAGE HAVING PERCENTAGE>95;

--The HAVING clause also permits filtering rows using more than one aggregate condition.

SELECT STUDENT FROM STUDENT1 WHERE PERCENTAGE > 90 GROUP BY STUDENT HAVING SUM(PERCENTAGE)<100 AND AVG(PERCENTAGE)>95;

--Write the query to get the department and department wise total(sum) salary from "EmployeeDetail" table.

SELECT DEPARTMENT,SUM(SALARY) FROM EMPLOYEEDETAIL GROUP BY DEPARTMENT;

-- Write the query to get the department and department wise total(sum) salary, display it in ascending order according to salary.

SELECT DEPARTMENT,SUM(SALARY) FROM EMPLOYEEDETAIL GROUP BY DEPARTMENT ORDER BY SUM(SALARY);

--Write the query to get the department and department wise total(sum) salary, display it in descending order according to salary.

SELECT DEPARTMENT,SUM(SALARY) FROM EMPLOYEEDETAIL GROUP BY DEPARTMENT ORDER BY SUM(SALARY) DESC;

--Write the query to get the department, total no. of departments, total(sum) salary with respect to department from "EmployeeDetail" table.

SELECT DEPARTMENT,COUNT(DEPARTMENT),SUM(SALARY) FROM EMPLOYEEDETAIL GROUP BY DEPARTMENT;

SELECT DEPARTMENT,COUNT(DEPARTMENT) AS NOOFDEPARTMENTS,SUM(SALARY) AS TOTALSALARY FROM EMPLOYEEDETAIL GROUP BY DEPARTMENT;

--Get department wise average salary from "EmployeeDetail" table order by salary ascending.

SELECT DEPARTMENT,AVG(SALARY) FROM EMPLOYEEDETAIL GROUP BY DEPARTMENT ORDER BY AVG(SALARY);

--department wise maximum salary from "EmployeeDetail" table order by salary ascending.

SELECT DEPARTMENT,MAX(SALARY) FROM EMPLOYEEDETAIL GROUP BY DEPARTMENT ORDER BY MAX(SALARY) ASC;--ASC IS OPTIONAL.

--Get department wise minimum salary from "EmployeeDetail" table order by salary ascending.

SELECT DEPARTMENT,MIN(SALARY) FROM EMPLOYEEDETAIL GROUP BY DEPARTMENT ORDER BY MIN(SALARY) ASC;

-- Write down the query to fetch Project name assign to more than one Employee

SELECT PROJECTNAME,COUNT(EMPLOYEEDETAILID) FROM PROJECTDETAIL GROUP BY PROJECTNAME HAVING COUNT(EMPLOYEEDETAILID)>1;

--SUBQUERY.

--Write a SQL query to display department with maximum salary from employees table.

SELECT * FROM EMPLOYEE2;

SELECT DEPARTMENT FROM EMPLOYEE2 WHERE SALARY = (SELECT MAX(SALARY) FROM EMPLOYEE2);

--Write a SQL query to display Employee name with maximum salary from employees table.

SELECT NAME FROM EMPLOYEE2 WHERE SALARY = (SELECT MAX(SALARY) FROM EMPLOYEE2);

SELECT NAME,DEPARTMENT,SALARY FROM EMPLOYEE2 
WHERE SALARY < (SELECT AVG(SALARY) FROM EMPLOYEE2);

--Write a query to display employeeid,name,gender of all employees whose salary is more than NISHA GUPTA's salary from the table EMPLOYEE2.

SELECT EMPLOYEEID,NAME,GENDER FROM EMPLOYEE2 WHERE SALARY >(SELECT SALARY FROM EMPLOYEE2 WHERE NAME ='NISHA GUPTA');

--Write a query to display employeeid, name of all employees whose EXPERIENCE is less than VIKRAM's EXPERIENCE from the table EMPLOYEE2.

SELECT EMPLOYEEID,NAME FROM EMPLOYEE2 WHERE EXPERIENCE < (SELECT EXPERIENCE FROM EMPLOYEE2 WHERE NAME='VIKRAM SINGH');

--Write a query to display name,gender of all employees whose salary is more than NISHA GUPTA's salary and experienec is less than
-- vikram's experience from the table EMPLOYEE2.

SELECT NAME,GENDER FROM EMPLOYEE2 WHERE SALARY >(SELECT SALARY FROM EMPLOYEE2 WHERE NAME='NISHA GUPTA') 
AND EXPERIENCE <(SELECT EXPERIENCE FROM EMPLOYEE2 WHERE NAME = 'VIKRAM SINGH');














