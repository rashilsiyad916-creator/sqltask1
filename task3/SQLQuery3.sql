


CREATE DATABASE LibraryDB;

USE LibraryDB;

CREATE TABLE Sales(

SaleId INT PRIMARY KEY IDENTITY (1,1),
BookId INT NOT NULL,
SaleDate DATE NOT NULL,
SaleAmount DECIMAL (10,2)NOT NULL,

FOREIGN KEY (BookId)
REFERENCEs Books(BookId)

);

INSERT INTO Sales(BookId , SaleDate , SaleAmount)
VALUES
(1 , '2025-01-10',500),
(1, '2025-02-15', 700),
(1, '2026-03-20', 600),

(2, '2025-01-12', 800),
(2, '2025-04-18', 900),

(3, '2026-02-05', 1000),
(3, '2026-05-10', 1200);

SELECT 
b.BookTitle,
SUM(s.SaleAmount) AS TotalSales

FROM Books b
INNER JOIN Sales S
ON b.BookId = s.BookId
GROUP BY b.BookTitle ;


SELECT 
b.BookTitle ,
YEAR(s.SaleDate) AS SaleYear ,
SUM(s.SaleAmount) AS TotalSale

FROM Books b
INNER JOIN Sales s
ON b.BookId = s.BookId
GROUP BY
b.BookTitle,
YEAR(s.SaleDate);

SELECT 
b.BookTitle,
SUM(s.SaleAmount) AS TotalSales

FROM Books b
INNER JOIN Sales s
ON b.BookId = s.BookId
GROUP BY b.BookTitle
HAVING SUM(s.SaleAmount) >1500 ;

GO

CREATE PROCEDURE GetBookTotalSales
    @BookTitle VARCHAR(100)
AS
BEGIN
    SELECT
        b.BookTitle,
        SUM(s.SaleAmount) AS TotalSales
    FROM Books b
    INNER JOIN Sales s
        ON b.BookId = s.BookId
    WHERE b.BookTitle = @BookTitle
    GROUP BY b.BookTitle;
END;

GO

EXEC GetBookTotalSales 'Harry Potter';


GO
CREATE FUNCTION fn_AverageSaleamount()
RETURNS DECIMAL(10,2)
AS
BEGIN
DECLARE @Average DECIMAL(10,2);

SELECT @Average = AVG(SaleAmount)
FROM Sales;

RETURN @Average;

END ;
GO

SELECT dbo.fn_AverageSaleamount() AS AverageSale;
