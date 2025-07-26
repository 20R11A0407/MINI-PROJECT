CREATE TABLE Books (
    BookID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(255),
    Genre VARCHAR(100),
    YearPublished INT
);


CREATE TABLE Authors (
    AuthorID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(255),
    Bio TEXT
);


CREATE TABLE BookAuthors (
    BookID INT,
    AuthorID INT,
    PRIMARY KEY (BookID, AuthorID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID)
);

CREATE TABLE Members (
    MemberID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(255),
    Email VARCHAR(255),
    JoinDate DATE
);

CREATE TABLE Loans (
    LoanID INT AUTO_INCREMENT PRIMARY KEY,
    BookID INT,
    MemberID INT,
    LoanDate DATE,
    DueDate DATE,
    ReturnDate DATE,
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
);

INSERT INTO Books (Title, Genre, YearPublished) VALUES
('The Hobbit', 'Fantasy', 1937),
('1984', 'Dystopian', 1949),
('To Kill a Mockingbird', 'Fiction', 1960),
('The Great Gatsby', 'Classic', 1925),
('Harry Potter', 'Fantasy', 1997),
('The Catcher in the Rye', 'Fiction', 1951),
('Pride and Prejudice', 'Romance', 1813),
('The Alchemist', 'Adventure', 1988),
('Moby Dick', 'Adventure', 1851),
('War and Peace', 'Historical', 1869);

INSERT INTO Authors (Name, Bio) VALUES
('J.R.R. Tolkien', 'Fantasy writer.'),
('George Orwell', 'Dystopian novelist.'),
('Harper Lee', 'American author.'),
('F. Scott Fitzgerald', 'American classic novelist.'),
('J.K. Rowling', 'British fantasy writer.'),
('J.D. Salinger', 'American novelist.'),
('Jane Austen', 'British romantic novelist.'),
('Paulo Coelho', 'Brazilian author.'),
('Herman Melville', 'American novelist.'),
('Leo Tolstoy', 'Russian writer.');

INSERT INTO BookAuthors (BookID, AuthorID) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

INSERT INTO Members (Name, Email, JoinDate) VALUES
('Alice Smith', 'alice@example.com', '2023-01-01'),
('Bob Johnson', 'bob@example.com', '2023-01-10'),
('Charlie Davis', 'charlie@example.com', '2023-02-01'),
('Dana White', 'dana@example.com', '2023-02-20'),
('Evan Green', 'evan@example.com', '2023-03-15'),
('Faith Brown', 'faith@example.com', '2023-04-01'),
('George King', 'george@example.com', '2023-04-18'),
('Hannah Lee', 'hannah@example.com', '2023-05-05'),
('Ian Moore', 'ian@example.com', '2023-06-10'),
('Julia Knight', 'julia@example.com', '2023-06-25');


INSERT INTO Loans (BookID, MemberID, LoanDate, DueDate, ReturnDate) VALUES
(1, 1, '2025-07-01', '2025-07-10', NULL),
(2, 2, '2025-06-15', '2025-06-25', '2025-06-24'),
(3, 3, '2025-06-10', '2025-06-20', NULL),
(4, 4, '2025-07-05', '2025-07-15', NULL),
(5, 5, '2025-06-20', '2025-07-01', '2025-06-30'),
(6, 6, '2025-06-01', '2025-06-10', NULL),
(7, 7, '2025-07-01', '2025-07-10', NULL),
(8, 8, '2025-06-05', '2025-06-15', NULL),
(9, 9, '2025-07-10', '2025-07-20', NULL),
(10, 10, '2025-07-15', '2025-07-25', NULL);

CREATE VIEW BorrowedBooks AS
SELECT
    Loans.LoanID, Books.Title, Members.Name AS Borrower, Loans.LoanDate, Loans.DueDate
FROM
    Loans
JOIN Books ON Loans.BookID = Books.BookID
JOIN Members ON Loans.MemberID = Members.MemberID
WHERE
    Loans.ReturnDate IS NULL;

CREATE VIEW OverdueBooks AS
SELECT
    Loans.LoanID, Books.Title, Members.Name AS Borrower, Loans.DueDate
FROM
    Loans
JOIN Books ON Loans.BookID = Books.BookID
JOIN Members ON Loans.MemberID = Members.MemberID
WHERE
    Loans.ReturnDate IS NULL
    AND Loans.DueDate < CURDATE();

CREATE TABLE Notifications (
    NotificationID INT AUTO_INCREMENT PRIMARY KEY,
    MemberID INT,
    Message TEXT,
    NotifiedOn DATETIME DEFAULT CURRENT_TIMESTAMP
);

DELIMITER //

CREATE TRIGGER OverdueNotify
AFTER INSERT ON Loans
FOR EACH ROW
BEGIN
    IF NEW.DueDate < CURDATE() THEN
        INSERT INTO Notifications (MemberID, Message)
        VALUES (
            NEW.MemberID,
            CONCAT('Your loan for book ID ', NEW.BookID, ' is already overdue.')
        );
    END IF;
END;
//

DELIMITER ;

SELECT Members.Name, COUNT(Loans.LoanID) AS TotalLoans
FROM Members
LEFT JOIN Loans ON Members.MemberID = Loans.MemberID
GROUP BY Members.MemberID;

SELECT Books.Title, COUNT(Loans.LoanID) AS TimesBorrowed
FROM Books
JOIN Loans ON Books.BookID = Loans.BookID
GROUP BY Books.BookID
ORDER BY TimesBorrowed DESC;
