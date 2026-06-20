USE libraryDB;

SELECT *FROM Authors ,Books ;

CREATE TABLE Author
(
    AuthorId INT PRIMARY KEY IDENTITY(1,1),
    AuthorName VARCHAR(100) NOT NULL
);
GO


CREATE VIEW vw_BookAuthorDetails
AS
SELECT
    b.BookId,
    b.BookTitle,
    b.PublicationYear,
    a.AuthorName
FROM Books b
INNER JOIN Author a
    ON b.AuthorId = a.AuthorId;
GO

SELECT * FROM vw_BookAuthorDetails;