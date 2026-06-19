
CREATE DATABASE LibraryDB;

USE LibraryDB;

CREATE TABLE Authors(
AuthorId INT PRIMARY KEY IDENTITY(1,1),
AuthorName VARCHAR(100)NOT NULL UNIQUE
);

CREATE TABLE Publishers(

PublisherId INT PRIMARY KEY IDENTITY(1,1),
PublisherName VARCHAR(100) NOT NULL UNIQUE

);

CREATE TABLE Books(

BookId INT PRIMARY KEY IDENTITY(1,1),
BookTitle VARCHAR(100)NOT NULL ,
PublicationYear INT CHECK(PublicationYear > 1900),

AuthorId INT NOT NULL,
PublisherId INT NOT NULL,


FOREIGN KEY (AuthorId)
REFERENCES Authors(AuthorId)
ON UPDATE CASCADE
ON DELETE CASCADE,

FOREIGN KEY (PublisherId)
REFERENCES Publishers(PublisherId)
ON UPDATE CASCADE
ON DELETE CASCADE

);

INSERT INTO Authors(AuthorName)
VALUES
('Paulo Coelho'),
('J.K Rowling'),
('George Orwell');

INSERT INTO Publishers(PublisherName)
VALUES
('Penguin'),
('Bloomsbury'),
('HarperCollins');

INSERT INTO Books
(BookTitle , PublicationYear , AuthorId ,PublisherId)
VALUES
('The Alchemist', 1988, 1, 1),
('Harry Potter', 1997, 2, 2),
('Animal Farm', 1945, 3, 3);

SELECT
    b.BookTitle,
    a.AuthorName,
    p.PublisherName,
    b.PublicationYear
FROM Books b
INNER JOIN Authors a
ON b.AuthorId = a.AuthorId
INNER JOIN Publishers p
ON b.PublisherId = p.PublisherId;

SELECT 
   a.AuthorName,
   b.BookTitle

FROM Authors a
LEFT JOIN Books b
ON a.AuthorId = b.AuthorId ;


SELECT 
  b.BookTitle,
  p.PublisherName

FROM Books b
RIGHT JOIN Publishers p
ON b.PublisherId = p.PublisherId ;

SELECT 
 b.BookTitle,
 a.AuthorName

FROM Books b 
FULL OUTER JOIN Authors a
ON b.AuthorId = a.AuthorId ;

DELETE FROM Authors
WHERE AuthorId = 1 ;

UPDATE Authors
SET AuthorId = 10
WHERE AuthorId = 2 ;

SELECT AuthorName AS Name
FROM Authors

UNION

SELECT PublisherName
FROM Publishers ;

SELECT AuthorName AS Name
FROM Authors

UNION ALL

SELECT PublisherName 
FROM Publishers;
