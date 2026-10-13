

CREATE DATABASE CompanyHRSystem;

USE CompanyHRSystem;

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY IDENTITY(1,1),
    DepartmentName NVARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL,
    Title NVARCHAR(100) NOT NULL,
    DepartmentID INT NOT NULL,
    Age INT NOT NULL CHECK (Age > 0),
    Address NVARCHAR(250),
    Phone VARCHAR(20),
    Photo VARBINARY(MAX),
    Salary DECIMAL(10,2) NOT NULL CHECK (Salary >= 0),
    NationalID VARCHAR(20) NOT NULL UNIQUE,
    Fingerprint VARBINARY(MAX),
    Email VARCHAR(200) NOT NULL UNIQUE,

    FOREIGN KEY (DepartmentID)
        REFERENCES Departments(DepartmentID)
);



CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY IDENTITY(1,1),
    ProjectName NVARCHAR(150) NOT NULL,
    DepartmentID INT NOT NULL,

    FOREIGN KEY (DepartmentID)
        REFERENCES Departments(DepartmentID)
);


CREATE TABLE EmployeeProjects (
    EmployeeID INT NOT NULL,
    ProjectID INT NOT NULL,

    PRIMARY KEY (EmployeeID, ProjectID),

    FOREIGN KEY (EmployeeID)
        REFERENCES Employees(EmployeeID),

    FOREIGN KEY (ProjectID)
        REFERENCES Projects(ProjectID)
);


CREATE TABLE Tasks (
    TaskID INT PRIMARY KEY IDENTITY(1,1),
    TaskName NVARCHAR(200) NOT NULL,
    ProjectID INT NOT NULL,
    EmployeeID INT NOT NULL,

    FOREIGN KEY (ProjectID)
        REFERENCES Projects(ProjectID),

    FOREIGN KEY (EmployeeID)
        REFERENCES Employees(EmployeeID)
);


INSERT INTO Departments (DepartmentName)
VALUES
('IT'),
('HR'),
('Marketing'),
('Finance');



INSERT INTO Employees
(Name, Title, DepartmentID, Age, Address,
 Phone, Photo, Salary, NationalID, Fingerprint, Email)
VALUES
('Ahmed Ali', 'Software Developer', 1, 25,
 'Cairo', '01011111111', NULL, 15000,
 'NID1001', NULL, 'ahmed@gmail.com'),

('Sara Mohamed', 'HR Specialist', 2, 32,
 'Giza', '01022222222', NULL, 12000,
 'NID1002', NULL, 'sara@yahoo.com'),

('Ali Hassan', 'Project Manager', 1, 42,
 'Cairo', NULL, NULL, 25000,
 'NID1003', NULL, 'ali@gmail.com'),

('Mona Adel', 'Marketing Specialist', 3, 29,
 'Nasr City', '01033333333', NULL, 10000,
 'NID1004', NULL, 'mona@gmail.com'),

('Omar Samir', 'Accountant', 4, 35,
 'New Cairo', '01044444444', NULL, 14000,
 'NID1005', NULL, 'omar@yahoo.com'),

('Nour Ahmed', 'Junior Developer', 1, 22,
 'Cairo', NULL, NULL, 9000,
 'NID1006', NULL, 'nour@gmail.com'),

('Youssef Tarek', 'HR Manager', 2, 40,
 'Giza', '01055555555', NULL, 20000,
 'NID1007', NULL, 'youssef@gmail.com');



INSERT INTO Projects (ProjectName, DepartmentID)
VALUES
('Website Development', 1),
('Employee Management System', 2),
('Marketing Campaign', 3),
('Financial Reporting System', 4);


INSERT INTO EmployeeProjects (EmployeeID, ProjectID)
VALUES
(1, 1),
(1, 2),
(2, 2),
(3, 1),
(4, 3),
(5, 4),
(6, 1),
(7, 2);

INSERT INTO Tasks (TaskName, ProjectID, EmployeeID)
VALUES
('Develop Login Page', 1, 1),
('Design Database', 1, 3),
('Test Website', 1, 6),
('Create Employee Records', 2, 2),
('Prepare Marketing Plan', 3, 4),
('Prepare Financial Report', 4, 5),
('Review HR Policies', 2, 7);


SELECT Name, Title
FROM Employees
WHERE Age > 30;

SELECT *
FROM Employees
WHERE DepartmentID = (
    SELECT DepartmentID
    FROM Departments
    WHERE DepartmentName = 'IT'
);


SELECT MIN(Salary) AS MinimumSalary
FROM Employees;


SELECT *
FROM Employees
WHERE Name LIKE 'A%';



SELECT *
FROM Employees
WHERE Email LIKE '%gmail%';



SELECT *
FROM Employees
WHERE Phone IS NULL
   OR Phone = '';


SELECT *
FROM Employees
ORDER BY Age ASC;


SELECT
    Name,
    Age,
    CASE
        WHEN Age < 30 THEN 'Junior'
        WHEN Age BETWEEN 30 AND 40 THEN 'Mid Level'
        ELSE 'Senior'
    END AS AgeGroup
FROM Employees;