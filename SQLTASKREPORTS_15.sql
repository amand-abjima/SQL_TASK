-- Write an SQL query to fetch “FIRST_NAME” from the Worker table using the alias name <WORKER_NAME>.

SELECT FIRST_NAME AS WORKER_NAME FROM WORKER;

--Write an SQL query to fetch “FIRST_NAME” from the Worker table in upper case.

SELECT UPPER(FIRST_NAME) FROM WORKER;

--Write an SQL query to fetch unique values of DEPARTMENT from the Worker table.

SELECT DISTINCT DEPARTMENT FROM WORKER;

--Write an SQL query to print the first three characters of  FIRST_NAME from the Worker table.

SELECT SUBSTRING(FIRST_NAME,1,3) FROM WORKER;

--Write an SQL query to find the position of the alphabet (‘a’) in the first name column ‘Amitabh’ from the Worker table.

SELECT INSTR(FIRST_NAME,'A' ) FROM WORKER WHERE FIRST_NAME='AMITABH';

-- Write an SQL query to print the FIRST_NAME from the Worker table after removing white spaces from the right side.

SELECT RTRIM(FIRST_NAME) FROM FIRST_NAME;

--Write an SQL query to print the DEPARTMENT from the Worker table after removing white spaces from the left side.

SELECT LTRIM(DEPARTMENT) FROM WORKER;

--Write an SQL query that fetches the unique values of DEPARTMENT from the Worker table and prints its length.

SELECT DISTINCT LENGTH(DEPARTEMENT) FROM WORKER;

--Write an SQL query to print the FIRST_NAME from the Worker table after replacing ‘a’ with ‘A’.

SELECT REPLACE(FIRST_NAME,'a','A') FROM WORKER;

-- Write an SQL query to print the FIRST_NAME and LAST_NAME from the Worker table into a single column COMPLETE_NAME. 
--A space char should separate them.

SELECT FIRST_NAME || ' ' || LAST_NAME AS "COMPLETE_NAME" FROM WORKER;

--Write an SQL query to print all Worker details from the Worker table order by FIRST_NAME Ascending.

SELECT * FROM  WORKER ORDER BY FIRST_NAME ASC;

--Write an SQL query to print all Worker details from the Worker table order by FIRST_NAME Ascending and DEPARTMENT Descending.

SELECT * FROM WORKER ORDER BY FIRST_NAME ASC,DEPARTMENT DESC;

--Write an SQL query to print details for Workers with the first names “Vipul” and “Satish” from the Worker table.

SELECT * FROM WORKER WHERE FIRST_NAME IN( 'VIPUL','SATISH');

--Write an SQL query to print details of workers excluding first names, “Vipul” and “Satish” from the Worker table.

SELECT * FROM WORKER WHERE FIRST_NAME NOT IN( 'VIPUL','SATISH');

--Write an SQL query to print details of Workers with DEPARTMENT name as “Admin”.

SELECT * FROM WORKER DEPARTMENT LIKE 'ADMIN%';

--Write an SQL query to print details of the Workers whose FIRST_NAME contains ‘a’.

SELECT * FROM WORKERS WHERE FIRST_NAME LIKE '%a%';

--Write an SQL query to print details of the Workers whose FIRST_NAME ends with ‘a’.

SELECT * FROM WORKERS WHERE FIRST_NAME LIKE '%a';

-- Write an SQL query to print details of the Workers whose FIRST_NAME ends with ‘h’ and contains six alphabets.

SELECT * FROM WORKERS WHERE FIRST_NAME LIKE '_____h';

--Write an SQL query to print details of the Workers whose SALARY lies between 100000 and 500000.

SELECT * FROM WORKERS WHERE SALARY BETWEEN 100000 AND 500000;

--Write an SQL query to print details of the Workers who joined in Feb 2021.

SELECT * FROM WORKERS WHERE YEAR(JOINING_DATE) = 2021 AND MONTH(JOINING_DATE)=2;

--Write an SQL query to fetch the count of employees working in the department ‘Admin’.

SELECT COUNT(*) FROM WORKER WHERE DEPARTMENT = 'ADMIN';

--Write an SQL query to fetch worker names with salaries >= 50000 and <= 100000.

SELECT CONCAT(FIRST_NAME, ' ', LAST_NAME) As Worker_Name, Salary
FROM worker 
WHERE WORKER_ID IN 
(SELECT WORKER_ID FROM worker 
WHERE Salary BETWEEN 50000 AND 100000);

-- Write an SQL query to fetch the number of workers for each department in descending order.

SELECT DEPARTMENT, count(WORKER_ID) No_Of_Workers 
FROM worker 
GROUP BY DEPARTMENT 
ORDER BY No_Of_Workers DESC;

--Write an SQL query to print details of the Workers who are also Managers.

SELECT DISTINCT W.FIRST_NAME, T.WORKER_TITLE
FROM Worker W
INNER JOIN Title T
ON W.WORKER_ID = T.WORKER_REF_ID
AND T.WORKER_TITLE in ('Manager');

--Write an SQL query to fetch duplicate records having matching data in some fields of a table.

SELECT WORKER_TITLE, AFFECTED_FROM, COUNT(*)
FROM Title
GROUP BY WORKER_TITLE, AFFECTED_FROM
HAVING COUNT(*) > 1;

-- Write an SQL query to show only odd rows from a table.

SELECT * FROM Worker WHERE MOD (WORKER_ID, 2) <> 0;

--Write an SQL query to show only even rows from a table.

SELECT * FROM Worker WHERE MOD (WORKER_ID, 2) = 0;

--Write an SQL query to fetch intersecting records of two tables.

(SELECT * FROM Worker)
INTERSECT
(SELECT * FROM WorkerClone);

-- Write an SQL query to show records from one table that another table does not have.

SELECT * FROM Worker
MINUS
SELECT * FROM Title;

-- Write an SQL query to show the current date and time.

SELECT GETDATE();

--Write an SQL query to show the top n (say 10) records of a table.

SELECT TOP(10) * FROM WORKERS ORDER BY SALARY DESC;

--Write an SQL query to fetch the list of employees with the same salary.

Select distinct W.WORKER_ID, W.FIRST_NAME, W.Salary 
from Worker W, Worker W1 
where W.Salary = W1.Salary 
and W.WORKER_ID != W1.WORKER_ID;

--Write an SQL query to show the second-highest salary from a table.

Select max(Salary) from Worker 
where Salary not in (Select max(Salary) from Worker);

-- Write an SQL query to show one row twice in the results from a table.

select FIRST_NAME, DEPARTMENT from worker W where W.DEPARTMENT='HR' 
union all 
select FIRST_NAME, DEPARTMENT from Worker W1 where W1.DEPARTMENT='HR';

-- Write an SQL query to fetch intersecting records of two tables.

(SELECT * FROM Worker)
INTERSECT
(SELECT * FROM WorkerClone);

--Write an SQL query to fetch the first 50% of records from a table.

SELECT *
FROM WORKER
WHERE WORKER_ID <= (SELECT count(WORKER_ID)/2 from Worker);

--Write an SQL query to fetch the departments that have less than five people in them.

SELECT DEPARTMENT, COUNT(WORKER_ID) as 'Number of Workers' FROM Worker GROUP BY DEPARTMENT HAVING COUNT(WORKER_ID) < 5;

--Write an SQL query to show all departments along with the number of people in there.

SELECT DEPARTMENT, COUNT(DEPARTMENT) as 'Number of Workers' FROM Worker GROUP BY DEPARTMENT;

--Write an SQL query to show the last record from a table.

Select * from Worker where WORKER_ID = (SELECT max(WORKER_ID) from Worker);

--Write an SQL query to fetch the first row of a table.

Select * from Worker where WORKER_ID = (SELECT min(WORKER_ID) from Worker);

--Write an SQL query to print the names of employees having the highest salary in each department.

SELECT t.DEPARTMENT,t.FIRST_NAME,t.Salary from(SELECT max(Salary) as TotalSalary,DEPARTMENT from Worker group by DEPARTMENT) as TempNew 
Inner Join Worker t on TempNew.DEPARTMENT=t.DEPARTMENT 
 and TempNew.TotalSalary=t.Salary;

--Write an SQL query to fetch departments along with the total salaries paid for each of them.

 SELECT DEPARTMENT, sum(Salary) from worker group by DEPARTMENT;

 --Write an SQL query to fetch the names of workers who earn the highest salary.

 SELECT FIRST_NAME, SALARY from Worker WHERE SALARY=(SELECT max(SALARY) from Worker);











