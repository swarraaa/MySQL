CREATE DATABASE BOOKS;
USE BOOKS;

CREATE TABLE Book(
	bookid INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255),
    price INT(5),
    pages INT
);

CREATE TABLE Author(
	aid INT AUTO_INCREMENT PRIMARY KEY,
    au_name VARCHAR(255),
    address VARCHAR(1000),
    city VARCHAR(255),
    no_pub INT
);

CREATE TABLE Writtenby(
	bookid INT,
    aid INT,
    FOREIGN KEY (bookid)
		REFERENCES Book(bookid)
        ON DELETE CASCADE,
	FOREIGN KEY (aid)
		REFERENCES Author(aid)
        ON DELETE CASCADE
);

CREATE TABLE Publisher(
	pid INT AUTO_INCREMENT PRIMARY KEY,
    pb_name VARCHAR(255),
    address VARCHAR(1000),
    phone INT(10)
);

CREATE TABLE Publishedby(
	bookid INT,
    pid INT,
    no_of_copies INT,
    year_of_pub DATE,
    FOREIGN KEY (bookid)
		REFERENCES Book(bookid)
        ON DELETE CASCADE,
	FOREIGN KEY (pid)
		REFERENCES Publisher(pid)
        ON DELETE CASCADE
);

CREATE TABLE Supplier(
	sup_id INT AUTO_INCREMENT PRIMARY KEY,
    sup_name VARCHAR(255),
    address VARCHAR(1000),
    city VARCHAR(255)
);

CREATE TABLE Supplies(
	bookid INT,
    sup_id INT,
    sup_price INT,
    FOREIGN KEY (bookid)
		REFERENCES Book(bookid)
        ON DELETE CASCADE,
	FOREIGN KEY (sup_id)
		REFERENCES Supplier(sup_id)
        ON DELETE CASCADE
);

-- Dummy data for Book table
INSERT INTO Book (title, price, pages) VALUES
('The Catcher in the Rye', 15, 224),
('To Kill a Mockingbird', 20, 336),
('1984', 18, 328),
('The Great Gatsby', 22, 180);

-- Dummy data for Author table
INSERT INTO Author (au_name, address, city, no_pub) VALUES
('J.D. Salinger', '123 Main St', 'New York', 3),
('Harper Lee', '456 Oak St', 'Maycomb', 2),
('George Orwell', '789 Pine St', 'London', 1),
('F. Scott Fitzgerald', '101 Elm St', 'West Egg', 2);

-- Dummy data for Writtenby table
INSERT INTO Writtenby (bookid, aid) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4);

-- Dummy data for Publisher table
INSERT INTO Publisher (pb_name, address, phone) VALUES
('Penguin Books', '111 Broadway', 1234567890),
('HarperCollins', '222 Market St', 1976543210),
('Random House', '333 Oak St', 1551234567);

SELECT * FROM Publisher;
SELECT * FROM Book;

ALTER TABLE Publisher MODIFY phone INT(11);

SET SQL_SAFE_UPDATES = 0;
DELETE FROM Publisher;

-- Dummy data for Publishedby table
INSERT INTO Publishedby (bookid, pid, no_of_copies, year_of_pub) VALUES
(1, 37, 1000, '2020-01-01'), -- Assuming 'year' is a DATE or DATETIME column
(2, 39, 800, '2019-01-01'),
(3, 38, 1200, '2021-01-01'),
(4, 37, 600, '2018-01-01');

SELECT * FROM Publishedby;

-- Dummy data for Supplier table
INSERT INTO Supplier (sup_name, address, city) VALUES
('Book Distributors Inc.', '444 Maple St', 'Cityville'),
('Global Publishers Supply', '555 Pine St', 'Metro City'),
('Books R Us', '666 Oak St', 'Townsville');

-- Dummy data for Supplies table
INSERT INTO Supplies (bookid, sup_id, sup_price) VALUES
(1, 1, 10),
(2, 2, 15),
(3, 3, 12),
(4, 1, 18);

-- 1. Display author names whose books are published in year 2008.
SELECT DISTINCT A.au_name
FROM Author A
JOIN Writtenby W ON A.aid = W.aid
JOIN Publishedby P ON W.bookid = P.bookid
WHERE YEAR(P.year_of_pub) = 2020;

-- 2. Display names of supplier to which book of To Kill a Mockingbird is available.
SELECT S.sup_name
FROM Supplier S
JOIN Supplies Su ON S.sup_id = Su.sup_id
JOIN Book B ON Su.bookid = B.bookid
WHERE B.title = 'To Kill a Mockingbird';

-- 3. Display in ascending order the names of books published by "........"
SELECT B.title
FROM Book B
JOIN Publishedby P ON B.bookid = P.bookid
JOIN Publisher PB ON P.pid = PB.pid
WHERE PB.pb_name = '...'
ORDER BY B.title ASC;

-- 4. Display the names of publishers who publish books whose supplier price is less than 500
SELECT DISTINCT P.pb_name  
FROM Publisher P
JOIN Publishedby PB ON P.pid = PB.pid
JOIN Supplies S ON S.bookid = PB.bookid
WHERE S.sup_price < 500;

-- 5. Display name of books whose supply city not is sangli.
SELECT B.title
FROM Book B
JOIN Supplies Su ON B.bookid = Su.bookid
JOIN Supplier S ON Su.sup_id = S.sup_id
WHERE S.city != 'Sangli';

-- 6. Display all book names order by there supply price.
SELECT B.title
FROM Book B
JOIN Supplies Su ON B.bookid = Su.bookid
ORDER BY Su.sup_price;

-- 7. Display name of supplier having book name Networking.
SELECT S.sup_name
FROM Supplier S
JOIN Supplies Su ON S.sup_id = Su.sup_id
JOIN Book B ON Su.bookid = B.bookid
WHERE B.title = 'Networking';

-- 8. Display authors name in each city.
SELECT A.au_name, A.city
FROM Author A;

-- 9. Create trigger for Before Insert on any table given above.
DELIMITER //
CREATE TRIGGER before_insert_book
BEFORE INSERT ON Book
FOR EACH ROW
BEGIN
    SET NEW.title = UPPER(NEW.title);
END;
//
DELIMITER ;





