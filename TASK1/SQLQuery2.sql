create database chacha

use chacha

CREATE TABLE Books(

BookId INT PRIMARY KEY IDENTITY(1,1),
Title VARCHAR(100) NOT NULL ,
Author VARCHAR(100) NOT NULL,
PublicationYear INT ,
Price DECIMAL(10,2)
);

SELECT *FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME = 'Books';

INSERT INTO Books(Title , Author , PublicationYear,Price)
VALUES
('The AIchemist','Paulo coelho',1998,499.99),
('Rich Dad Poor Dad','Robert Kiyosaki',1997,399.99),
('Atomic Habits' , 'James Clear', 2018 , 599.99);

select *from Books