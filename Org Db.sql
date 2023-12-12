CREATE DATABASE ORG;
SHOW DATABASES;
USE ORG;

CREATE TABLE Workers (
    worker_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    fName VARCHAR(50),
    lName VARCHAR(50),
    salary INT(15),
    join_date DATETIME,
    dept VARCHAR(100)
);

INSERT INTO Workers 
    (fName, lName, salary, join_date, dept) VALUES
    ('Ray', 'Raison', 2300000, '2003-12-20 09:00:00', 'HR'),
    ('Kai', 'Kamado', 34000, '2013-12-20 07:00:00', 'Admin'),
    ('Tyson', 'Tyler', 1000, '2021-12-30 09:00:00', 'HR'),
    ('Peter', 'Parker', 50000, '2003-10-20 10:00:00', 'Admin'),
    ('Tony', 'Stark', 20000, '2017-02-20 09:00:00', 'Account'),
    ('Sanji', 'Winsmoke', 300000, '2008-08-20 09:12:00', 'Account'),
    ('Luffy', 'Monkey', 50000000, '2014-07-20 09:00:00', 'Admin'),
    ('Zoro', 'Roronoa', 800000, '2012-12-18 09:00:00', 'Aadmin');

SELECT * FROM Workers;

CREATE TABLE Bonus (
    worker_ref_id INT,
    bonus_amt INT(10),
    bonus_date DATETIME,
    FOREIGN KEY (worker_ref_id)
        REFERENCES Workers(worker_id)
        ON DELETE CASCADE
);

INSERT INTO Bonus
    (worker_ref_id, bonus_amt, bonus_date) VALUES
    (4, '10000', '2020-01-09'),
    (2, '1000', '2020-01-09'),
    (1, '2000', '2020-01-09'),
    (6, '80000', '2020-01-09'),
    (8, '90000', '2020-01-09');
        
SELECT * FROM Bonus;

CREATE TABLE Title (
    worker_ref_id INT, 
    title VARCHAR(255),
    affected_from DATETIME,
    FOREIGN KEY (worker_ref_id)
    REFERENCES Workers(worker_id)
    ON DELETE CASCADE
);

INSERT INTO Title
    (worker_ref_id, title, affected_from) VALUES
    (1, 'Manager', '2003-12-20 09:00:00'),
    (2, 'Lead', '2013-12-20 07:00:00'),
    (3, 'Associate', '2021-12-30 09:00:00'),
    (4, 'Manager', '2003-10-20 10:00:00'),
    (5, 'Lead', '2017-02-20 09:00:00'),
    (6, 'SDE', '2008-08-20 09:12:00'),
    (7, 'Lead', '2014-07-20 09:00:00'),
    (8, 'Associate', '2012-12-18 09:00:00');

SELECT * FROM Title;

-- Select without using from
SELECT now();
SELECT 11 + 10;

-- Wildcards
SELECT * FROM Workers WHERE fName LIKE '%o_';

-- Order by
SELECT * FROM Workers ORDER BY salary DESC;

-- Distinct
SELECT DISTINCT dept FROM Workers;

-- Group by
SELECT dept FROM Workers GROUP BY dept;
SELECT dept, COUNT(dept) FROM Workers GROUP BY dept;
SELECT dept, AVG(salary), MIN(salary), MAX(salary), COUNT(dept) FROM Workers GROUP BY dept;

-- Having
SELECT dept, COUNT(dept) FROM Workers GROUP BY dept HAVING COUNT(dept) > 2;

-- Inner join
SELECT W.*, T.* FROM Workers AS W INNER JOIN Bonus AS T ON W.worker_id = T.worker_ref_id;

-- Full join
SELECT W.*, T.* FROM Workers AS W RIGHT JOIN Bonus AS T ON W.worker_id = T.worker_ref_id
UNION
SELECT W.*, T.* FROM Workers AS W LEFT JOIN Bonus AS T ON W.worker_id = T.worker_ref_id;

-- Set operation -> union
SELECT * FROM Workers
UNION
SELECT * FROM Title;

-- Cross join
SELECT W.*, T.* FROM Workers AS W CROSS JOIN Title AS T;



