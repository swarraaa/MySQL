-- Questions:
-- Q.1 Write an SQL query to fetch fname from workers table using the alias name as worker_name
SELECT fName AS worker_name FROM Workers;

-- Q.2 write an SQL query to fetch the fname from the Workers table in uppercase;
SELECT UCASE(fName) FROM Workers;
SELECT UPPER(fName) FROM Workers;

-- Q.3 write an SQL query fetch unique values of department from Workers table
SELECT DISTINCT dept FROM Workers;
SELECT dept FROM Workers GROUP BY dept;

-- Q.4 write an SQL query to print the first 3 characters of fname from Workers table
SELECT SUBSTRING(fName, 1, 3) FROM Workers;

-- Q.5 write an SQL query to find the position of the alphabet 'u' in the fName column 'Luffy' from Workers table
SELECT INSTR(fName, 'U') FROM Workers WHERE fName = 'Luffy';

-- Q.6 write an SQL query to print the fName from Workers table after removing the white spaces from the right side
SELECT RTRIM(fName) FROM Workers;

-- Q.7 write an SQL query to print the fName from Workers table after removing the white spaces from the left side
SELECT LTRIM(fName) FROM Workers;

-- Q.8 write an SQL query that fetches the unique values of dept from the Workers table and print its length
SELECT dept, LENGTH(dept) FROM Workers GROUP BY dept;
SELECT DISTINCT dept, LENGTH(dept) FROM Workers;

-- Q.9 write an SQL query to print the fname from workers table after replacing 'a' with 'A'
SELECT REPLACE(fName, 'a', 'A') FROM Workers;
	
-- Q.10 write an SQL query to print the fname and lname from workers table into a single column complete_name
-- a space char should separate them
SELECT CONCAT(fName, ' ', lName) AS complete_name FROM Workers;

-- Q.11 write an SQL query to print all worker details from workers table order by fname ascending
SELECT * FROM Workers ORDER BY fName;

-- Q.12 write an SQL query to print all worker details from workers table order by fname ascending and dept descending
SELECT * FROM Workers ORDER BY fName, dept DESC;

-- Q.13 write an SQL query to print details for workers table with the fname as 'Luffy' and 'Zoro'
SELECT * FROM Workers WHERE fName IN ('Luffy', 'Zoro');

-- Q.14 write an SQL query to print details of workers excluding first names 'Kai' and 'Tyson'
SELECT * FROM Workers WHERE fName NOT IN ('Kai', 'Tyson');

-- Q.15 write an SQL query to print details of workers with dept name as 'Admin'
SELECT * FROM Workers WHERE dept = 'Admin';

-- Q.16 write an SQL query to print details of workers whose fName contains 'a'
SELECT * FROM Workers WHERE fName LIKE '%a%';

-- Q.17 write an SQL query to print details of workers whose fName ends with 'y'
SELECT * FROM Workers WHERE fName LIKE '%y';

-- Q.18 write an SQL query to print details of workers whose fName ends with 'y' and contains 5 alphabets
SELECT * FROM Workers WHERE fName LIKE '%y' HAVING LENGTH(fName) = 5;
SELECT * FROM Workers WHERE fName LIKE '____y';

-- Q.19 write an SQL query to print details of workers whose salary lies between 1000 and 50000
SELECT * FROM Workers WHERE salary BETWEEN 1000 AND 50000;
SELECT * FROM Workers WHERE salary >= 1000 AND salary <= 50000;

-- Q.20 write an SQL query to print details of workers who have joined in Dec 2013
SELECT * FROM Workers WHERE YEAR(join_date) = 2003 AND MONTH(join_date) = 12;

-- Q.21 write an SQL query to fetch the count of employees working in the department 'Admin'
SELECT COUNT(dept) FROM Workers WHERE dept = 'Admin';
SELECT COUNT(*) FROM Workers WHERE dept = 'Admin';

-- Q.22 write an SQL query to fetch worker full names with salaries >= 2000 and <= 1000000
SELECT CONCAT(fName, ' ', lName) AS full_name, salary FROM Workers WHERE salary BETWEEN 2000 AND 1000000;

-- Q.23 write an SQL query to fetch the number of workers in each dept in descending order
SELECT dept, COUNT(dept) FROM Workers GROUP BY dept ORDER BY COUNT(dept) DESC;

-- Q.24 Write an SQL query to print details of the Workers who are also Managers.
SELECT * FROM Workers;
SELECT * FROM Title;
SELECT w.* FROM Workers AS w INNER JOIN Title AS t ON w.worker_id = t.worker_ref_id WHERE t.title = 'Manager';

-- Q.25 Write an SQL query to fetch the number (more than 1) of different titles in the ORG.
SELECT title, COUNT(title) FROM Title GROUP BY title HAVING COUNT(title) > 1;

-- Q.26 Write an SQL query to show only odd rows from a table.
SELECT * FROM Title WHERE MOD(worker_ref_id, 2) != 0;

-- Q.27 Write an SQL query to show only even rows from a table.
SELECT * FROM Workers WHERE MOD(worker_id, 2) = 0;

-- Q.28 Write an SQL query to clone a new table from another table.
CREATE TABLE worker_clone_table LIKE Workers;
SELECT * FROM worker_clone_table; -- data is not copied, schema is copied
INSERT INTO worker_clone_table SELECT * FROM Workers;
INSERT INTO worker_clone_table 
    (fName, lName, salary, join_date, dept) VALUES
    ('Hinata', 'Shoyo', 45000, '2003-11-20 09:00:00', 'HR'),
    ('Kageyama', 'Tobiyo', 230000, '2013-12-20 07:00:00', 'Admin'),
    ('Nezuko', 'Kamado', 12333333, '2021-12-30 09:00:00', 'HR');

-- Q.29 Write an SQL query to fetch intersecting records of two tables.
-- Intersection is nothing but an inner join, but cols number and data types should be the same
SELECT Workers.* FROM Workers INNER JOIN worker_clone_table USING(worker_id);

-- Q.30 Write an SQL query to show records from one table that another table does not have.
SELECT worker_clone_table.* FROM worker_clone_table 
LEFT JOIN Workers USING(worker_id) 
WHERE Workers.worker_id IS NULL;

-- Q.31 Write an SQL query to show the current date and time.
SELECT NOW();

-- Q.32 Write an SQL query to show the top n (say 5) records of a table order by descending salary.
SELECT * FROM Workers LIMIT 5;

-- Q.33 Write an SQL query to determine the nth (say n=5) highest salary from a table.
-- 4 is offset here, and 1 is the number of entries
SELECT * FROM Workers ORDER BY salary DESC LIMIT 4,1;
SELECT * FROM Workers ORDER BY salary;

-- Q.34 Write an SQL query to determine the 5th highest salary without using the LIMIT keyword.
SELECT w1.salary FROM Workers AS w1 -- for every salary check
WHERE 5 = (                            -- if 5 == number of salaries greater than or equal to the current salary
    SELECT COUNT(DISTINCT(w2.salary)) 
    FROM Workers AS w2
    WHERE w2.salary >= w1.salary
);

-- Q.35 Write an SQL query to fetch the list of employees with the same salary.
SELECT w1.* FROM Workers w1, Workers w2 WHERE w1.salary = w2.salary AND w1.worker_id != w2.worker_id; 

-- Q.36 Write an SQL query to show the second highest salary from a table.
SELECT * FROM Workers ORDER BY salary DESC LIMIT 2, 1;
SELECT * FROM Workers AS w1
WHERE 2 = (
    SELECT COUNT(w2.salary)
    FROM Workers AS w2
    WHERE w2.salary >= w1.salary
);
SELECT MAX(salary) FROM Workers 
WHERE salary NOT IN (SELECT MAX(salary) FROM Workers);

-- Following query doesn't give the 3rd highest salary
SELECT MAX(salary) FROM Workers         -- 1st highest    
WHERE salary NOT IN (
    SELECT MAX(salary) FROM Workers     -- 2nd highest
    WHERE salary NOT IN (
        SELECT MAX(salary) FROM Workers -- 1st highest 
    )
);

-- Following query gives the 3rd highest
SELECT MAX(salary) FROM  Workers        -- 3rd highest
WHERE salary NOT IN (
    SELECT MAX(salary) FROM Workers     -- 1st highest
    UNION                               -- +
    SELECT MAX(salary) FROM Workers 
    WHERE salary NOT IN (
        SELECT MAX(salary) FROM Workers -- 2nd highest
    )
);

-- Q.37 Write an SQL query to show one row twice in results from a table
SELECT * FROM Workers
UNION ALL
SELECT * FROM Workers ORDER BY worker_id;

-- Q.38 Write an SQL query to list worker_id who does not get a bonus.
SELECT w.worker_id FROM Workers AS w 
LEFT JOIN Bonus AS b 
ON worker_id = worker_ref_id 
WHERE b.bonus_amt IS NULL;

-- Q.39 Write an SQL query to fetch the first 50% records from a table.
SELECT * FROM Workers WHERE worker_id <= (SELECT COUNT(worker_id)/2 FROM Workers);
-- 50% from bottom
SELECT * FROM Workers WHERE worker_id > (SELECT COUNT(worker_id)/2 FROM Workers);

-- Q.40 Write an SQL query to fetch the departments that have less than 3 people in it.
SELECT dept, COUNT(dept) FROM Workers GROUP BY dept HAVING COUNT(dept) < 3;

-- Q.41 Write an SQL query to show all departments along with the total salaries paid for each of them.
SELECT dept, SUM(salary) FROM Workers GROUP BY dept;

-- Q.42. Write an SQL query to show the last record from a table.
SELECT * FROM Workers WHERE worker_id = (SELECT MAX(worker_id) FROM Workers);

-- Q.43. Write an SQL query to fetch the first row of a table.
SELECT * FROM Workers WHERE worker_id = (SELECT MIN(worker_id) FROM Workers);

-- Q.44. Write an SQL query to fetch the last five records from a table.
SELECT * FROM Workers WHERE worker_id > (SELECT COUNT(worker_id)-5 FROM Workers);
(SELECT * FROM Workers ORDER BY worker_id DESC LIMIT 5) ORDER BY worker_id;

-- Q.45. Write an SQL query to print the name of employees having the highest salary in each department.
SELECT w.fName, w.dept, w.salary FROM
(SELECT MAX(salary) as maxsal, dept FROM Workers GROUP BY dept) temp -- A tb containing max sal of every dept
INNER JOIN
Workers w
ON temp.dept = w.dept AND temp.maxsal = w.salary;

-- Q.46. Write an SQL query to fetch three max salaries from a table using co-related subquery
SELECT salary FROM Workers ORDER BY salary DESC LIMIT 3; -- using limit
SELECT * FROM Workers w1
WHERE 3 >= (
    SELECT COUNT(DISTINCT(w2.salary)) FROM Workers w2 WHERE w1.salary <= w2.salary
) ORDER BY w1.salary DESC;

-- Q.47. Write an SQL query to fetch three min salaries from a table using co-related subquery
SELECT * FROM Workers w1
WHERE 3 >= (
    SELECT COUNT(DISTINCT(w2.salary)) FROM Workers w2 WHERE w1.salary >= w2.salary
) ORDER BY w1.salary ASC;

-- Q-48. Write an SQL query to fetch nth say 6th max salaries from a table.
SELECT * FROM Workers w1
WHERE 6 = (
    SELECT COUNT(DISTINCT(w2.salary)) FROM Workers w2 WHERE w1.salary <= w2.salary
) ORDER BY w1.salary DESC;

-- Q.49. Write an SQL query to fetch departments along with the total salaries paid for each of them.
SELECT dept, SUM(salary) FROM Workers GROUP BY dept;

-- Q.50. Write an SOL query to fetch the names of workers who earn the highest salary
SELECT CONCAT(fName, ' ', lName) AS name FROM Workers WHERE Workers.salary = (SELECT MAX(salary) FROM Workers);
