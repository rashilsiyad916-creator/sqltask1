USE libraryDB;

CREATE TABLE Author
(
    AuthorId INT PRIMARY KEY IDENTITY(1,1),
    AuthorName VARCHAR(100) NOT NULL
);
Go
CREATE OR ALTER PROCEDURE GetAllBookTitles
AS
BEGIN

    SELECT BookTitle 
    FROM Books;
END;
GO
GO

GO
CREATE OR ALTER PROCEDURE GetBooksByAuthor
    @AuthorName VARCHAR(100)
AS
BEGIN
    SELECT b.BookTitle, a.AuthorName
    FROM Books b
    INNER JOIN Author a
        ON b.AuthorId = a.AuthorId
    WHERE a.AuthorName = @AuthorName;
END;
GO

EXEC GetBooksByAuthor 'J.K. Rowling';
GO
CREATE OR ALTER FUNCTION fn_GetBookCountByAuthor
(
    @AuthorName VARCHAR(100)
)
RETURNS INT
AS
BEGIN
    DECLARE @BookCount INT;

    SELECT @BookCount = COUNT(*)
    FROM Books b
    INNER JOIN Author a
        ON b.AuthorId = a.AuthorId
    WHERE a.AuthorName = @AuthorName;

    RETURN @BookCount;
END;
GO
SELECT dbo.fn_GetBookCountByAuthor('J.K. Rowling') AS TotalBooks;

GO
INSERT INTO Author (AuthorName)
VALUES
('J.K. Rowling'),
('Paulo Coelho'),
('George Orwell');

INSERT INTO Books (BookTitle, PublicationYear, AuthorId, PublisherId)
VALUES
('Harry Potter', 1997, 1, 1),
('The Alchemist', 1988, 2, 2),
('Animal Farm', 1945, 3, 3);

EXEC GetAllBookTitles;