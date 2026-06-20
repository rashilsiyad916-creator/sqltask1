
CREATE DATABASE libraryDB;

USE libraryDB;


CREATE TABLE Author
(
    AuthorId INT PRIMARY KEY IDENTITY(1,1),
    AuthorName VARCHAR(100) NOT NULL
);
CREATE TABLE Bookss(

BookId INT PRIMARY KEY IDENTITY(1,1),
BookTitle VARCHAR(100)NOT NULL,
AuthorId INT NOT NULL,

FOREIGN KEY (AuthorId)
REFERENCES Author(AuthorId)

);

CREATE TABLE BookCopies(

CopyId INT PRIMARY KEY IDENTITY(1,1),
BookId INT NOT NULL,
AvailableStatus BIT DEFAULT 1,

FOREIGN KEY (BookId)
REFERENCES Bookss(BookId)
);

CREATE TABLE Users(
 UserId INT PRIMARY KEY IDENTITY (1,1),
 UserName VARCHAR(100) NOT NULL
);

CREATE TABLE Borrowing(

BorrowId INT PRIMARY KEY IDENTITY(1,1),

UserId INT NOT NULL,
CopyId INT NOT NULL,

BorrowDate DATE NOT NULL,
ReturnDate DATE NOT NULL,

FOREIGN KEY (UserId)
REFERENCES Users(UserId),

FOREIGN KEY (CopyId)
REFERENCES BookCopies(CopyId)

)
INSERT INTO Authors (AuthorName)
VALUES
('J.K. Rowling'),
('Paulo Coelho');

INSERT INTO Books (BookTitle, AuthorId)
VALUES
('Harry Potter', 1),
('The Alchemist', 2);

INSERT INTO BookCopies (BookId)
VALUES
(1),
(2);

INSERT INTO Users (UserName)
VALUES
('Rashil'),
('Arun');

GO
CREATE OR ALTER PROCEDURE CheckoutBook
(
    @UserId INT,
    @CopyId INT
)
AS
BEGIN
    UPDATE BookCopies
    SET AvailableStatus = 0
    WHERE CopyId = @CopyId;

    INSERT INTO Borrowing
    (
        UserId,
        CopyId,
        BorrowDate,
        ReturnDate
    )
    VALUES
    (
        @UserId,
        @CopyId,
        GETDATE(),
        NULL
    );
END;
EXEC CheckoutBook 1,1;
GO
CREATE OR ALTER PROCEDURE ReturnBook
(
    @UserId INT,
    @CopyId INT
)
AS
BEGIN
    UPDATE Borrowing
    SET ReturnDate = GETDATE()
    WHERE UserId = @UserId
      AND CopyId = @CopyId
      AND ReturnDate IS NULL;

    UPDATE BookCopies
    SET AvailableStatus = 1
    WHERE CopyId = @CopyId;
END;
EXEC ReturnBook 1,1;
GO
CREATE OR ALTER FUNCTION fn_GetBookCountByAuthor
(
    @AuthorId INT
)
RETURNS INT
AS
BEGIN
    DECLARE @BookCount INT;

    SELECT @BookCount = COUNT(*)
    FROM Books
    WHERE AuthorId = @AuthorId;

    RETURN @BookCount;

END;

GO
CREATE OR ALTER FUNCTION fn_GetOverdueBorrowings()
RETURNS TABLE

AS
RETURN
(
    SELECT
        BorrowId,
        UserId,
        CopyId,
        BorrowDate
    FROM Borrowing
    WHERE ReturnDate IS NULL
      AND DATEDIFF(DAY, BorrowDate, GETDATE()) > 7
);
GO
SELECT *
FROM dbo.fn_GetOverdueBorrowings();