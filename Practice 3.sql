CREATE DATABASE BOOKS_ORDERS;
USE BOOKS_ORDERS;

CREATE TABLE Book (
    accnum INT PRIMARY KEY,
    author VARCHAR(255),
    title VARCHAR(255),
    price DECIMAL(10, 2),
    pages INT
);

CREATE TABLE Vendor (
    vendorno INT PRIMARY KEY,
    vendorname VARCHAR(255)
);

CREATE TABLE Bookorder (
    vendorno INT,
    accnum INT,
    orderno INT PRIMARY KEY,
    copies INT,
    orderdate DATE,
    FOREIGN KEY (vendorno) REFERENCES Vendor(vendorno),
    FOREIGN KEY (accnum) REFERENCES Book(accnum)
);

CREATE TABLE Member (
    borrowno INT PRIMARY KEY,
    name VARCHAR(255),
    address VARCHAR(255)
);

CREATE TABLE Bookissue (
    accnum INT,
    borrowno INT,
    issuedate DATE,
    FOREIGN KEY (accnum) REFERENCES Book(accnum),
    FOREIGN KEY (borrowno) REFERENCES Member(borrowno),
    PRIMARY KEY (accnum, borrowno)
);

CREATE TABLE Bookreturn (
    accnum INT,
    borrowno INT,
    returndate DATE,
    FOREIGN KEY (accnum) REFERENCES Book(accnum),
    FOREIGN KEY (borrowno) REFERENCES Member(borrowno),
    PRIMARY KEY (accnum, borrowno)
);

CREATE TABLE BookIssueSummary (
    accnum INT,
    issuedate DATE
);


INSERT INTO Book (accnum, author, title, price, pages)
VALUES
(1, 'Author1', 'Book1', 25.99, 300),
(2, 'Author2', 'Book2', 19.99, 250),
(3, 'Author3', 'Book3', 34.50, 400),
(4, 'Author4', 'Book4', 15.75, 200);

INSERT INTO Bookorder (vendorno, accnum, orderno, copies, orderdate)
VALUES
(1, 1, 101, 50, '2023-01-15'),
(2, 2, 102, 30, '2023-02-20'),
(3, 3, 103, 40, '2023-03-10'),
(1, 4, 104, 20, '2023-04-05');

INSERT INTO Vendor (vendorno, vendorname)
VALUES
(1, 'Vendor1'),
(2, 'Vendor2'),
(3, 'Vendor3');

INSERT INTO Member (borrowno, name, address)
VALUES
(101, 'Member1', 'Address1'),
(102, 'Member2', 'Address2'),
(103, 'Member3', 'Address3'),
(104, 'Member4', 'Address4');

INSERT INTO Bookissue (accnum, borrowno, issuedate)
VALUES
(1, 101, '2023-01-20'),
(2, 102, '2023-02-25'),
(3, 103, '2023-03-15'),
(4, 104, '2023-04-10');

INSERT INTO Bookreturn (accnum, borrowno, returndate)
VALUES
(1, 101, '2023-02-10'),
(2, 102, '2023-03-05'),
(3, 103, '2023-04-01'),
(4, 104, '2023-05-01');

SELECT * FROM Vendor;
SELECT * FROM Bookorder;

-- 1. Display all vendor names in descending order of number of copies.
SELECT v.vendorname, SUM(bo.copies) as total_copies
FROM Bookorder bo
JOIN Vendor v ON bo.vendorno = v.vendorno
GROUP BY v.vendorname
ORDER BY total_copies DESC;

-- 2. Display book names ordered by there price.
SELECT title
FROM Book
ORDER BY price;

-- 3. Display member names of member having both member and issued a book.
SELECT DISTINCT m.name
FROM Member m
JOIN Bookissue bi ON m.borrowno = bi.borrowno
JOIN Bookreturn br ON m.borrowno = br.borrowno;

-- 4. Display book names ordered by issue date.
SELECT b.title
FROM Bookissue bi
JOIN Book b ON bi.accnum = b.accnum
ORDER BY issuedate;

-- 5. Display names of book whose price is greater then 200.
SELECT title
FROM Book
WHERE price > 200;

-- 6. Display book name having substring is '.....' and has at least 4 character.
SELECT title
FROM Book
WHERE LENGTH(title) >= 4 AND title LIKE '%...%';

-- 7. Set price 300 when pages are more then 300.
UPDATE Book
SET price = 300
WHERE pages > 300;

-- 8. Find number of books.
SELECT COUNT(*) as book_count
FROM Book;

-- 9. Create view of book name by there issue date.
CREATE VIEW BookIssueView AS
SELECT b.title, bi.issuedate
FROM Bookissue bi
JOIN Book b ON bi.accnum = b.accnum;

SELECT * FROM BookIssueView;

-- 10. Find all account number have book issued but not book return.
SELECT bi.accnum
FROM Bookissue bi
LEFT JOIN Bookreturn br ON bi.accnum = br.accnum
WHERE br.accnum IS NULL;
	
-- 11. Create trigger to keep records in new summary table while book is issued from bookissue.
DELIMITER // 
CREATE TRIGGER BookIssueTrigger
AFTER INSERT ON Bookissue
FOR EACH ROW
BEGIN
    INSERT INTO BookIssueSummary (accnum, issuedate)
    VALUES (NEW.accnum, NEW.issuedate);
END;
// 
