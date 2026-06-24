-- =============================================
-- DATABASE SCHEMA FOR LIBRARY MANAGEMENT SYSTEM
-- =============================================

CREATE DATABASE LimboLibrary;
USE LimboLibrary;

-- Drop existing tables to start fresh (optional, use with caution)
DROP TABLE IF EXISTS BorrowingLogs;
DROP TABLE IF EXISTS Current_Orders;
DROP TABLE IF EXISTS Ebooks;
DROP TABLE IF EXISTS Books;
DROP TABLE IF EXISTS Members;


-- =============================================
-- TABLE CREATION
-- =============================================

-- Table: Members
-- Stores information about library members.
CREATE TABLE Members (
    MemberID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    JoinDate DATE NOT NULL,
    HasEbookAccess TINYINT(1) NOT NULL DEFAULT 0 -- 1 for TRUE, 0 for FALSE
);

-- Table: Books
-- Stores details of physical books in the library.
CREATE TABLE Books (
    BookID INT PRIMARY KEY AUTO_INCREMENT,
    Title VARCHAR(255) NOT NULL,
    Author VARCHAR(100) NOT NULL,
    Genre VARCHAR(50),
    ISBN VARCHAR(20) UNIQUE,
    PublishedYear INT,
    CopiesAvailable INT NOT NULL DEFAULT 1
);

-- Table: BorrowingLogs
-- Tracks all book borrowing activities and fines.
CREATE TABLE BorrowingLogs (
    LogID INT PRIMARY KEY AUTO_INCREMENT,
    BookID INT NOT NULL,
    MemberID INT NOT NULL,
    BorrowDate DATE NOT NULL,
    DueDate DATE NOT NULL,
    ReturnDate DATE, -- Can be NULL if not yet returned
    FineAmount DECIMAL(10, 2) -- Can be NULL if not yet calculated/returned
);

-- Table: Ebooks
-- Stores information about the digital e-book collection.
CREATE TABLE Ebooks (
    EbookID INT PRIMARY KEY AUTO_INCREMENT,
    Title VARCHAR(255) NOT NULL,
    Author VARCHAR(100) NOT NULL,
    Genre VARCHAR(50),
    PublishedYear INT,
    FileFormat VARCHAR(10),
    FileSizeMB DECIMAL(5, 2)
);

-- Table: Current_Orders
-- Tracks new books ordered by the library.
CREATE TABLE Current_Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    BookTitle VARCHAR(255) NOT NULL,
    Author VARCHAR(100),
    ISBN VARCHAR(20),
    OrderDate DATE NOT NULL,
    ExpectedArrival DATE,
    CostPerCopy DECIMAL(10, 2) NOT NULL,
    Quantity INT NOT NULL,
    Arrived TINYINT(1) NOT NULL DEFAULT 0 -- 1 for TRUE, 0 for FALSE
);


-- =============================================
-- DATA INSERTION
-- =============================================

-- Set initial AUTO_INCREMENT values for clarity in sample data
ALTER TABLE Members AUTO_INCREMENT = 1;
ALTER TABLE Books AUTO_INCREMENT = 101;
ALTER TABLE BorrowingLogs AUTO_INCREMENT = 201;
ALTER TABLE Ebooks AUTO_INCREMENT = 301;
ALTER TABLE Current_Orders AUTO_INCREMENT = 401;


-- Insert data into Members table
INSERT INTO Members (MemberID, FirstName, LastName, Email, JoinDate, HasEbookAccess) VALUES
(1, 'Ali', 'Khan', 'ali.khan@email.com', '2024-01-15', 1),
(2, 'Fatima', 'Ahmed', 'fatima.a@email.com', '2024-02-20', 0),
(3, 'Omar', 'Sharif', 'omar.s@email.com', '2024-03-10', 1),
(4, 'Ayesha', 'Malik', 'ayesha.m@email.com', '2024-04-05', 1),
(5, 'Bilal', 'Hassan', 'bilal.h@email.com', '2024-05-21', 0),
(6, 'Zainab', 'Iqbal', 'zainab.i@email.com', '2024-06-11', 1),
(7, 'Saad', 'Mahmood', 'saad.m@email.com', '2024-07-19', 0),
(8, 'Hira', 'Tariq', 'hira.t@email.com', '2024-08-30', 1),
(9, 'Usman', 'Butt', 'usman.b@email.com', '2024-09-02', 1),
(10, 'Samina', 'Pervez', 'samina.p@email.com', '2024-10-18', 0);

-- Insert data into Books table
INSERT INTO Books (BookID, Title, Author, Genre, ISBN, PublishedYear, CopiesAvailable) VALUES
(101, 'The Silent Patient', 'Alex Michaelides', 'Thriller', '978-1250301697', 2019, 3),
(102, 'Educated', 'Tara Westover', 'Memoir', '978-0399590504', 2018, 2),
(103, 'Where the Crawdads Sing', 'Delia Owens', 'Fiction', '978-0735219090', 2018, 5),
(104, 'Atomic Habits', 'James Clear', 'Self-Help', '978-0735211292', 2018, 4),
(105, 'To Kill a Mockingbird', 'Harper Lee', 'Classic', '978-0061120084', 1960, 7),
(106, '1984', 'George Orwell', 'Dystopian', '978-0451524935', 1949, 6),
(107, 'The Great Gatsby', 'F. Scott Fitzgerald', 'Classic', '978-0743273565', 1925, 4),
(108, 'The Hobbit', 'J.R.R. Tolkien', 'Fantasy', '978-0547928227', 1937, 8),
(109, 'Sapiens: A Brief History of Humankind', 'Yuval Noah Harari', 'History', '978-0062316097', 2015, 3),
(110, 'The Alchemist', 'Paulo Coelho', 'Fantasy', '978-0062315007', 1988, 5);

-- Insert data into BorrowingLogs table
INSERT INTO BorrowingLogs (LogID, BookID, MemberID, BorrowDate, DueDate, ReturnDate, FineAmount) VALUES
(201, 103, 2, '2025-05-01', '2025-05-15', '2025-05-14', 0.00),
(202, 104, 1, '2025-05-03', '2025-05-17', '2025-05-20', 30.00),
(203, 101, 4, '2025-05-05', '2025-05-19', NULL, NULL),
(204, 108, 3, '2025-05-10', '2025-05-24', NULL, NULL),
(205, 105, 5, '2025-05-12', '2025-05-26', '2025-05-28', 20.00),
(206, 110, 6, '2025-05-15', '2025-05-29', NULL, NULL),
(207, 102, 8, '2025-05-18', '2025-06-01', '2025-06-01', 0.00),
(208, 106, 7, '2025-05-20', '2025-06-03', NULL, NULL),
(209, 107, 9, '2025-05-22', '2025-06-05', NULL, NULL),
(210, 109, 1, '2025-05-25', '2025-06-08', '2025-06-10', 20.00);

-- Insert data into Ebooks table
INSERT INTO Ebooks (EbookID, Title, Author, Genre, PublishedYear, FileFormat, FileSizeMB) VALUES
(301, 'Project Hail Mary', 'Andy Weir', 'Sci-Fi', 2021, 'EPUB', 5.2),
(302, 'The Four Winds', 'Kristin Hannah', 'Historical Fiction', 2021, 'PDF', 8.1),
(303, 'Klara and the Sun', 'Kazuo Ishiguro', 'Sci-Fi', 2021, 'EPUB', 4.5),
(304, 'Crying in H Mart', 'Michelle Zauner', 'Memoir', 2021, 'PDF', 6.3),
(305, 'Dune', 'Frank Herbert', 'Sci-Fi', 1965, 'EPUB', 12.4),
(306, 'Foundation', 'Isaac Asimov', 'Sci-Fi', 1951, 'MOBI', 7.8),
(307, 'A Promised Land', 'Barack Obama', 'Memoir', 2020, 'EPUB', 15.1),
(308, 'The Vanishing Half', 'Brit Bennett', 'Fiction', 2020, 'PDF', 9.2),
(309, 'Breath: The New Science of a Lost Art', 'James Nestor', 'Science', 2020, 'EPUB', 6.7),
(310, 'Caste: The Origins of Our Discontents', 'Isabel Wilkerson', 'Non-Fiction', 2020, 'PDF', 11.5);

-- Insert data into Current_Orders table
INSERT INTO Current_Orders (OrderID, BookTitle, Author, ISBN, OrderDate, ExpectedArrival, CostPerCopy, Quantity, Arrived) VALUES
(401, 'Iron Flame', 'Rebecca Yarros', '978-1649374172', '2025-04-15', '2025-05-10', 1500.00, 5, 1),
(402, 'The Heaven & Earth Grocery Store', 'James McBride', '978-0593422050', '2025-04-20', '2025-05-15', 1250.00, 3, 1),
(403, 'Fourth Wing', 'Rebecca Yarros', '978-1649374042', '2025-04-25', '2025-05-20', 1450.00, 10, 0),
(404, 'Holly', 'Stephen King', '978-1668016138', '2025-05-01', '2025-05-25', 1800.00, 4, 0),
(405, 'The Wager', 'David Grann', '978-0385534260', '2025-05-05', '2025-05-30', 1300.00, 6, 0),
(406, 'Lessons in Chemistry', 'Bonnie Garmus', '978-0385547345', '2025-05-10', '2025-06-01', 1100.00, 8, 1),
(407, 'Spare', 'Prince Harry', '978-0593593806', '2025-05-12', '2025-06-03', 2200.00, 2, 0),
(408, 'Remarkably Bright Creatures', 'Shelby Van Pelt', '978-0063204157', '2025-05-18', '2025-06-10', 950.00, 5, 0),
(409, 'I''m Glad My Mom Died', 'Jennette McCurdy', '978-1982185824', '2025-05-20', '2025-06-12', 1650.00, 3, 0),
(410, 'Demon Copperhead', 'Barbara Kingsolver', '978-0063251922', '2025-05-25', '2025-06-18', 1400.00, 4, 0);


-- =============================================
-- ADDING FOREIGN KEY CONSTRAINTS
-- =============================================

-- This ensures that a borrowing log cannot exist without a valid book and member.
ALTER TABLE BorrowingLogs
ADD CONSTRAINT fk_book
FOREIGN KEY (BookID) REFERENCES Books(BookID),
ADD CONSTRAINT fk_member
FOREIGN KEY (MemberID) REFERENCES Members(MemberID);

-- =============================================
-- END OF SCRIPT
-- =============================================  

-- Stored Procedure 1: Add a new member
DELIMITER //
CREATE PROCEDURE AddMember(
    IN p_FirstName VARCHAR(50),
    IN p_LastName VARCHAR(50),
    IN p_Email VARCHAR(100),
    IN p_JoinDate DATE,
    IN p_HasEbookAccess TINYINT(1)
)
BEGIN
    INSERT INTO Members (FirstName, LastName, Email, JoinDate, HasEbookAccess)
    VALUES (p_FirstName, p_LastName, p_Email, p_JoinDate, p_HasEbookAccess);
END //
DELIMITER ;

-- Stored Procedure 2: Borrow a Book
DELIMITER //
CREATE PROCEDURE BorrowBook(
    IN p_BookID INT,
    IN p_MemberID INT,
    IN p_BorrowDate DATE,
    IN p_DueDate DATE
)
BEGIN
    -- Check if copies are available
    IF (SELECT CopiesAvailable FROM Books WHERE BookID = p_BookID) > 0 THEN
        INSERT INTO BorrowingLogs (BookID, MemberID, BorrowDate, DueDate)
        VALUES (p_BookID, p_MemberID, p_BorrowDate, p_DueDate);

        UPDATE Books
        SET CopiesAvailable = CopiesAvailable - 1
        WHERE BookID = p_BookID;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No copies of this book are available.';
    END IF;
END //
DELIMITER ;

-- Stored Procedure 3: Return a Book
DELIMITER //
CREATE PROCEDURE ReturnBook(
    IN p_LogID INT,
    IN p_ReturnDate DATE,
    IN p_FinePerDay DECIMAL(10, 2)
)
BEGIN
    DECLARE v_DueDate DATE;
    DECLARE v_BookID INT;
    DECLARE v_Fine DECIMAL(10, 2);

    SELECT DueDate, BookID INTO v_DueDate, v_BookID
    FROM BorrowingLogs
    WHERE LogID = p_LogID;

    IF p_ReturnDate > v_DueDate THEN
        SET v_Fine = DATEDIFF(p_ReturnDate, v_DueDate) * p_FinePerDay;
    ELSE
        SET v_Fine = 0.00;
    END IF;

    UPDATE BorrowingLogs
    SET ReturnDate = p_ReturnDate,
        FineAmount = v_Fine
    WHERE LogID = p_LogID;

    UPDATE Books
    SET CopiesAvailable = CopiesAvailable + 1
    WHERE BookID = v_BookID;
END //
DELIMITER ;

-- Stored Procedure 4: Get Member Borrowing History
DELIMITER //
CREATE PROCEDURE GetMemberBorrowingHistory(
    IN p_MemberID INT
)
BEGIN
    SELECT
        b.Title,
        b.Author,
        bl.BorrowDate,
        bl.DueDate,
        bl.ReturnDate,
        bl.FineAmount
    FROM BorrowingLogs bl
    JOIN Books b ON bl.BookID = b.BookID
    WHERE bl.MemberID = p_MemberID
    ORDER BY bl.BorrowDate DESC;
END //
DELIMITER ;

-- Stored Procedure 5: Update Book Copies
DELIMITER //
CREATE PROCEDURE UpdateBookCopies(
    IN p_BookID INT,
    IN p_NewCopiesAvailable INT
)
BEGIN
    UPDATE Books
    SET CopiesAvailable = p_NewCopiesAvailable
    WHERE BookID = p_BookID;
END //
DELIMITER ;

-- Stored Procedure 6: Get Overdue Books
DELIMITER //
CREATE PROCEDURE GetOverdueBooks(
    IN p_CurrentDate DATE
)
BEGIN
    SELECT
        m.FirstName,
        m.LastName,
        b.Title,
        bl.BorrowDate,
        bl.DueDate,
        DATEDIFF(p_CurrentDate, bl.DueDate) AS DaysOverdue
    FROM BorrowingLogs bl
    JOIN Members m ON bl.MemberID = m.MemberID
    JOIN Books b ON bl.BookID = b.BookID
    WHERE bl.ReturnDate IS NULL AND bl.DueDate < p_CurrentDate;
END //
DELIMITER ;

-- Join Query 1: Get all borrowed physical books with member details (INNER JOIN)
SELECT
    bl.LogID,
    m.FirstName,
    m.LastName,
    b.Title AS BookTitle,
    bl.BorrowDate,
    bl.DueDate,
    bl.ReturnDate,
    bl.FineAmount
FROM BorrowingLogs bl
INNER JOIN Members m ON bl.MemberID = m.MemberID
INNER JOIN Books b ON bl.BookID = b.BookID
ORDER BY bl.BorrowDate DESC;

-- Join Query 2: List all members and any books they currently have borrowed (LEFT JOIN)
SELECT
    m.FirstName,
    m.LastName,
    m.Email,
    b.Title AS CurrentlyBorrowedBookTitle,
    bl.BorrowDate
FROM Members m
LEFT JOIN BorrowingLogs bl ON m.MemberID = bl.MemberID AND bl.ReturnDate IS NULL
LEFT JOIN Books b ON bl.BookID = b.BookID
ORDER BY m.LastName, m.FirstName;

-- Join Query 3: List all books and details of members who have borrowed them (RIGHT JOIN - less common, often convertible to LEFT JOIN)
-- This query shows all books, and if they are currently borrowed, it shows the member.
SELECT
    b.Title AS BookTitle,
    b.Author,
    m.FirstName,
    m.LastName,
    bl.BorrowDate,
    bl.DueDate
FROM BorrowingLogs bl
RIGHT JOIN Books b ON bl.BookID = b.BookID AND bl.ReturnDate IS NULL
LEFT JOIN Members m ON bl.MemberID = m.MemberID -- Using LEFT JOIN here as BorrowingLogs is on the "right" of Books now
ORDER BY b.Title;

-- Join Query 4: Retrieve details of books currently on order that have already arrived (INNER JOIN on Current_Orders)
SELECT
    co.BookTitle,
    co.Author,
    co.ISBN,
    co.OrderDate,
    co.ExpectedArrival,
    co.CostPerCopy,
    co.Quantity
FROM Current_Orders co
WHERE co.Arrived = 1
ORDER BY co.OrderDate DESC;

-- Join Query 5: Find members who have not borrowed any physical books yet (LEFT JOIN with WHERE IS NULL)
SELECT
    m.MemberID,
    m.FirstName,
    m.LastName,
    m.Email
FROM Members m
LEFT JOIN BorrowingLogs bl ON m.MemberID = bl.MemberID
WHERE bl.LogID IS NULL;

-- Join Query 6: Find pairs of members who joined on the same date (Self-Join Concept)
SELECT
    m1.FirstName AS Member1_FirstName,
    m1.LastName AS Member1_LastName,
    m2.FirstName AS Member2_FirstName,
    m2.LastName AS Member2_LastName,
    m1.JoinDate
FROM Members m1
JOIN Members m2 ON m1.JoinDate = m2.JoinDate AND m1.MemberID < m2.MemberID
ORDER BY m1.JoinDate, m1.LastName;

-- Subquery 1: Get the total number of physical books available (Scalar Subquery)
SELECT SUM(CopiesAvailable) AS TotalPhysicalBooksAvailable
FROM Books;

-- Subquery 2: Find members who have borrowed "The Silent Patient" (IN Subquery)
SELECT
    MemberID,
    FirstName,
    LastName
FROM Members
WHERE MemberID IN (
    SELECT MemberID
    FROM BorrowingLogs
    WHERE BookID = (SELECT BookID FROM Books WHERE Title = 'The Silent Patient')
);

-- Subquery 3: List members who have ebook access and have also borrowed at least one physical book (EXISTS Subquery)
SELECT
    m.FirstName,
    m.LastName,
    m.Email
FROM Members m
WHERE m.HasEbookAccess = 1
AND EXISTS (
    SELECT 1
    FROM BorrowingLogs bl
    WHERE bl.MemberID = m.MemberID
);

-- Subquery 4: Find the average file size of Sci-Fi ebooks (Subquery in FROM clause - Derived Table)
SELECT
    Genre,
    AVG(FileSizeMB) AS AverageFileSizeMB
FROM (
    SELECT
        Genre,
        FileSizeMB
    FROM Ebooks
    WHERE Genre = 'Sci-Fi'
) AS SciFiEbooks
GROUP BY Genre;

-- Subquery 5: Find books that have more copies available than the average copies available for their genre (Correlated Subquery)
-- Note: This requires genre to be somewhat consistent or grouped for a meaningful average per genre.
-- For simplicity, let's calculate average copies across all books first then compare.
SELECT
    Title,
    Author,
    CopiesAvailable
FROM Books b
WHERE CopiesAvailable > (SELECT AVG(CopiesAvailable) FROM Books);

-- Subquery 6: Find books that have never been borrowed (NOT IN Subquery)
SELECT
    BookID,
    Title,
    Author
FROM Books
WHERE BookID NOT IN (
    SELECT DISTINCT BookID
    FROM BorrowingLogs
);

-- Query 1: Count of Books per Genre
SELECT
    Genre,
    COUNT(BookID) AS NumberOfBooks
FROM Books
GROUP BY Genre
ORDER BY NumberOfBooks DESC;

-- Query 2: Members with Ebook Access
SELECT
    FirstName,
    LastName,
    Email
FROM Members
WHERE HasEbookAccess = 1;

-- Query 3: Total Fines Collected
SELECT
    SUM(FineAmount) AS TotalFinesCollected
FROM BorrowingLogs
WHERE FineAmount IS NOT NULL;

-- Query 4: Top 3 Most Borrowed Books
SELECT
    b.Title,
    b.Author,
    COUNT(bl.BookID) AS TimesBorrowed
FROM BorrowingLogs bl
JOIN Books b ON bl.BookID = b.BookID
GROUP BY b.BookID, b.Title, b.Author
ORDER BY TimesBorrowed DESC
LIMIT 3;

-- Query 5: Average Fine Amount for Returned Books
SELECT
    AVG(FineAmount) AS AverageFineAmount
FROM BorrowingLogs
WHERE ReturnDate IS NOT NULL AND FineAmount > 0;

-- Query 6: Total Cost of Arrived Orders
SELECT
    SUM(CostPerCopy * Quantity) AS TotalCostOfArrivedOrders
FROM Current_Orders
WHERE Arrived = 1;

-- Query 7: Find all books by a specific author (e.g., 'Alex Michaelides')
SELECT
    BookID,
    Title,
    Genre,
    PublishedYear
FROM Books
WHERE Author = 'Alex Michaelides';

-- Query 8: List members who joined in a specific month and year (e.g., January 2024)
SELECT
    MemberID,
    FirstName,
    LastName,
    Email,
    JoinDate
FROM Members
WHERE MONTH(JoinDate) = 1 AND YEAR(JoinDate) = 2024;

-- Query 9: Get all Ebooks available in 'PDF' format
SELECT
    EbookID,
    Title,
    Author,
    FileSizeMB
FROM Ebooks
WHERE FileFormat = 'PDF';

-- Query 10: Find current orders expected to arrive in May 2025
SELECT
    OrderID,
    BookTitle,
    Author,
    ExpectedArrival,
    Quantity
FROM Current_Orders
WHERE MONTH(ExpectedArrival) = 5 AND YEAR(ExpectedArrival) = 2025;

-- Query 11: Calculate the average number of days a book is borrowed (for returned books only)
SELECT
    AVG(DATEDIFF(ReturnDate, BorrowDate)) AS AverageBorrowDurationDays
FROM BorrowingLogs
WHERE ReturnDate IS NOT NULL;

-- Query 12: Find members who do NOT have ebook access AND currently have no books borrowed
SELECT
    m.MemberID,
    m.FirstName,
    m.LastName,
    m.Email
FROM Members m
LEFT JOIN BorrowingLogs bl ON m.MemberID = bl.MemberID AND bl.ReturnDate IS NULL
WHERE m.HasEbookAccess = 0
AND bl.LogID IS NULL; -- Ensures they have no active borrowings

-- Query 13: Get the total number of ebooks per genre
SELECT
    Genre,
    COUNT(EbookID) AS NumberOfEbooks
FROM Ebooks
GROUP BY Genre
ORDER BY NumberOfEbooks DESC;

-- Query 14: Find the highest fine amount ever recorded
SELECT
    MAX(FineAmount) AS HighestFineEver
FROM BorrowingLogs
WHERE FineAmount IS NOT NULL;

-- Query 15: List all distinct genres across both physical books and ebooks
SELECT DISTINCT Genre FROM Books
UNION
SELECT DISTINCT Genre FROM Ebooks
ORDER BY Genre;

-- Query 16: Identify members who have borrowed books but have not returned them yet (i.e., active borrowings)
SELECT
    m.MemberID,
    m.FirstName,
    m.LastName,
    b.Title AS BorrowedBookTitle,
    bl.BorrowDate,
    bl.DueDate
FROM Members m
JOIN BorrowingLogs bl ON m.MemberID = bl.MemberID
JOIN Books b ON bl.BookID = b.BookID
WHERE bl.ReturnDate IS NULL;

-- Query 17: Get the total quantity of books currently on order, grouped by arrived status
SELECT
    CASE
        WHEN Arrived = 1 THEN 'Arrived'
        ELSE 'Not Arrived'
    END AS Status,
    SUM(Quantity) AS TotalQuantity
FROM Current_Orders
GROUP BY Arrived;

-- Query 18: Find books that were published before 2000 and have more than 5 copies available
SELECT
    BookID,
    Title,
    Author,
    PublishedYear,
    CopiesAvailable
FROM Books
WHERE PublishedYear < 2000 AND CopiesAvailable > 5;