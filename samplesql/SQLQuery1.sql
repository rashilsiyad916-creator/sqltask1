CREATE DATABASE SampleDB;


GO
USE SampleDB;


GO
CREATE TABLE Department (
    DepartmentId   INT           IDENTITY (1, 1) PRIMARY KEY,
    DepartmentName VARCHAR (100) NOT NULL
);

CREATE TABLE Employees (
    EmployeeId   INT             IDENTITY (1, 1) PRIMARY KEY,
    EmployeeName VARCHAR (100)   NOT NULL,
    Salary       DECIMAL (10, 2),
    DepartmentId INT            ,
    FOREIGN KEY (DepartmentId) REFERENCES Department (DepartmentId)
);

ALTER TABLE Employees
    ADD CONSTRAINT FK_Employees_Department FOREIGN KEY (DepartmentId) REFERENCES Department (DepartmentId) ON DELETE CASCADE;

INSERT  INTO Department (DepartmentName)
VALUES                 ('IT'),
('HR'),
('FINANCE');

INSERT  INTO Employees (EmployeeName, Salary, DepartmentId)
VALUES                ('RASHIL', 50000, 1),
('HISHAM', 60000, 2),
('HAIFA', 30000, 2),
('KENZA', 35000, 1),
('AJNAS', 60000, 1),
('SHAFI', 45000, 3),
('ANSHIF', 50000, 3);

SELECT *
FROM   Employees;

SELECT *
FROM   Employees
WHERE  Salary > 50000;

SELECT *
FROM   Employees
WHERE  DepartmentId = 1;

SELECT COUNT(*) AS TotalEmployees
FROM   Employees;

SELECT MAX(Salary) AS Highestsalary
FROM   Employees;

SELECT e.EmployeeName,
       e.Salary,
       d.DepartmentName
FROM   Employees AS e
       INNER JOIN
       Department AS d
       ON e.DepartmentId = d.DepartmentId;

SELECT   d.DepartmentName,
         COUNT(*) AS EmployeeCount
FROM     Employees AS e
         INNER JOIN
         Department AS d
         ON e.DepartmentId = d.DepartmentId
GROUP BY d.DepartmentName;

SELECT   d.DepartmentName,
         COUNT(*) AS EmployeeCount
FROM     Employees AS e
         INNER JOIN
         Department AS d
         ON e.DepartmentId = d.DepartmentId
GROUP BY d.DepartmentName
HAVING   COUNT(*) > 2;


GO
CREATE PROCEDURE GetEmployeeById
@EmployeeId INT
AS
BEGIN
    SELECT *
    FROM   Employees
    WHERE  EmployeeId = @EmployeeId;
END


GO
EXECUTE GetEmployeeById 2;


GO
CREATE FUNCTION fn_GetEmployeeCount
(@DepartmentId INT)
RETURNS INT
AS
BEGIN
    DECLARE @Count AS INT;
    SELECT @Count = COUNT(*)
    FROM   Employees
    WHERE  DepartmentId = @DepartmentId;
    RETURN @Count;
END


GO
SELECT dbo.fn_GetEmployeeCount(2) AS TotalEmployees;  

GO 
CREATE VIEW vm_EmployeeDepartment
AS
SELECT
e.EmployeeName ,
e.Salary,
d.DepartmentName
FROM Employees  e
INNER JOIN Department d
ON e.DepartmentId = d.DepartmentId ;

GO

SELECT * FROM vm_EmployeeDepartment ;

CREATE TABLE EmployeeLog(

LogId INT PRIMARY KEY IDENTITY (1,1),
EmployeeName VARCHAR (100),
LogDate DATETIME
);

GO
CREATE TRIGGER trg_AfterInsertEmployee
ON Employees
AFTER INSERT
AS 
BEGIN
INSERT INTO EmployeeLog(
EmployeeName,
LogDate
)
SELECT 
EmployeeName , GETDATE ()

FROM inserted;
END ;
GO
 
INSERT INTO Employees
(EmployeeName , Salary , DepartmentId)
VALUES
('NAHEEL', 75000 , 3) ;

SELECT * FROM EmployeeLog ;