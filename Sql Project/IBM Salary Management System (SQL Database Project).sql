create database IBMSalaryDB;
show databases;
USE IBMSalaryDB;
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(255) NOT NULL,
    Department VARCHAR(100),
    Position VARCHAR(100),
    DateOfJoining DATE,
    Email VARCHAR(255) UNIQUE
);
INSERT INTO Employees (Name, Department, Position, DateOfJoining, Email) 
VALUES
('Allen Darson', 'IT', 'IT Support & Helpdesk', '2022-06-15', 'allen@ibm.com'),
('Vijay Kumar', 'IT', 'Network & Infrastructure', '2019-08-10', 'vijay@ibm.com'),
('Arun Raj', 'IT', 'Cybersecurity', '2018-07-10', 'arun@ibm.com'),
('Mohan', 'IT', 'Cloud & DevOps', '2016-09-11', 'mohan@ibm.com'),
('Akash', 'IT', 'Software Development', '2012-04-01', 'akash@ibm.com'),
('Arjun', 'IT', 'Software Development', '2020-05-05', 'arjun@ibm.com'),
('Pavitra', 'IT', 'Cybersecurity', '2023-06-10', 'pavitra@ibm.com'),
('Priya Yadav', 'IT', 'Cybersecurity', '2023-02-07', 'priya@ibm.com'),
('Manoj', 'IT', 'Cloud & DevOps', '2018-01-10', 'manoj@ibm.com'),
('Ruturaj', 'IT', 'Database Management', '2013-12-10', 'ruturaj@ibm.com'),
('Abishek', 'IT', 'Database Management', '2012-08-15', 'abishek@ibm.com'),
('Isabella Mary', 'HR', 'HR Manager', '2016-02-08', 'isabella@ibm.com'),
('Kiran', 'HR', 'Recruitment & Talent Acquisition', '2011-06-18', 'kiran@ibm.com'),
('Jothi', 'HR', 'Training & Development', '2024-05-01', 'jothi@ibm.com'),
('Subiksha', 'HR', 'Payroll & Compensation', '2023-03-23', 'subiksha@ibm.com'),
('Rajesh', 'HR', 'HR Information Systems (HRIS)', '2021-03-18', 'rajesh@ibm.com'),
('Sofia Livingston', 'Finance', 'Accountant', '2020-03-20', 'sofia@ibm.com'),
('Aarthi', 'Finance', 'Audit & Compliance', '2021-04-04', 'aarthi@ibm.com'),
('Monica', 'Finance', 'Procurement & Expense Management', '2022-03-19', 'monica@ibm.com'),
('Sanjay', 'Finance', 'Financial Planning & Analysis (FP&A)', '2014-01-20', 'sanjay@ibm.com'),
('Rickelton', 'Finance', 'Risk Management', '2016-09-22', 'rickelton@ibm.com');

CREATE TABLE Salary (
    SalaryID INT PRIMARY KEY AUTO_INCREMENT,
    EmployeeID INT,
    BasicSalary DECIMAL(10,2) NOT NULL,
    Allowances DECIMAL(10,2) DEFAULT 0.00,
    Deductions DECIMAL(10,2) DEFAULT 0.00,
    NetSalary DECIMAL(10,2) GENERATED ALWAYS AS (BasicSalary + Allowances - Deductions) STORED,
    PaymentDate DATE NOT NULL,
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID) ON DELETE CASCADE
);
INSERT INTO Salary (EmployeeID, BasicSalary, Allowances, Deductions, PaymentDate) 
VALUES
(1, 70000.00, 5000.00, 2000.00, '2025-03-01'),
(2, 75000.00, 7000.00, 2500.00, '2025-03-01'),
(3, 80000.00, 6000.00, 3000.00, '2025-03-01'),
(4, 85000.00, 8000.00, 3500.00, '2025-03-01'),
(5, 90000.00, 10000.00, 4000.00, '2025-03-01'),
(6, 68000.00, 4500.00, 2200.00, '2025-03-01'),
(7, 72000.00, 5200.00, 2100.00, '2025-03-01'),
(8, 78000.00, 5800.00, 2700.00, '2025-03-01'),
(9, 82000.00, 7500.00, 3200.00, '2025-03-01'),
(10, 87000.00, 9000.00, 3700.00, '2025-03-01'),
(11, 62000.00, 3000.00, 1800.00, '2025-03-01'),
(12, 65000.00, 4000.00, 2000.00, '2025-03-01'),
(13, 70000.00, 4500.00, 2500.00, '2025-03-01'),
(14, 72000.00, 5000.00, 2600.00, '2025-03-01'),
(15, 76000.00, 5500.00, 2800.00, '2025-03-01'),
(16, 80000.00, 6200.00, 3000.00, '2025-03-01'),
(17, 84000.00, 7000.00, 3400.00, '2025-03-01'),
(18, 88000.00, 7500.00, 3800.00, '2025-03-01'),
(19, 92000.00, 8500.00, 4000.00, '2025-03-01'),
(20, 96000.00, 9000.00, 4500.00, '2025-03-01'),
(21, 100000.00, 10000.00, 5000.00, '2025-03-01');
SELECT * FROM Salary;

-- Retrieve All Employees with Their Salaries
SELECT e.EmployeeID, e.Name, e.Department, e.Position, s.BasicSalary, s.Allowances, s.Deductions, s.NetSalary
FROM Employees e JOIN Salary s ON e.EmployeeID = s.EmployeeID;

-- Retrieve Employees with Salary Greater Than ₹75,000
SELECT e.EmployeeID, e.Name, e.Department, s.NetSalary
FROM Employees e
JOIN Salary s ON e.EmployeeID = s.EmployeeID
WHERE s.NetSalary > 75000;

-- Retrieve Employees Sorted by Highest Salary
SELECT e.EmployeeID, e.Name, e.Department, s.NetSalary
FROM Employees e
JOIN Salary s ON e.EmployeeID = s.EmployeeID
ORDER BY s.NetSalary DESC;

-- Count the Number of Employees in Each Department
SELECT e.Department, COUNT(e.EmployeeID) AS TotalEmployees
FROM Employees e
GROUP BY e.Department;

-- Retrieve Total Salary Expense for IBM
SELECT SUM(s.NetSalary) AS TotalSalaryExpense
FROM Salary s;

-- Retrieve Employees Who Joined Before a Certain Date
SELECT EmployeeID, Name, Department, Position, DateOfJoining
FROM Employees
WHERE DateOfJoining < '2020-01-01';

-- Retrieve Employees Who Have the Highest Salary in Their Department
SELECT e.EmployeeID, e.Name, e.Department, s.NetSalary
FROM Employees e
JOIN Salary s ON e.EmployeeID = s.EmployeeID
WHERE s.NetSalary = (
    SELECT MAX(s2.NetSalary)
    FROM Salary s2
    JOIN Employees e2 ON s2.EmployeeID = e2.EmployeeID
    WHERE e2.Department = e.Department
);

-- Retrieve Employees Who Have Deductions Greater Than ₹2,000
SELECT e.EmployeeID, e.Name, s.Deductions
FROM Employees e
JOIN Salary s ON e.EmployeeID = s.EmployeeID
WHERE s.Deductions > 2000;

-- Retrieve Salary Payments Made in the Last 3 Months
SELECT e.EmployeeID, e.Name, s.PaymentDate, s.NetSalary
FROM Employees e
JOIN Salary s ON e.EmployeeID = s.EmployeeID
WHERE s.PaymentDate >= DATE_SUB(CURDATE(), INTERVAL 3 MONTH);

-- Retrieve the Average Salary in Each Department
SELECT e.Department, AVG(s.NetSalary) AS AverageSalary
FROM Employees e
JOIN Salary s ON e.EmployeeID = s.EmployeeID
GROUP BY e.Department;

-- Update Salary Details for an Employee
UPDATE Salary
SET BasicSalary = BasicSalary + 5000,  -- Increase salary by ₹5,000
    Allowances = Allowances + 1000,    -- Increase allowances by ₹1,000
    Deductions = Deductions + 500      -- Increase deductions by ₹500
WHERE EmployeeID = 1;

-- Delete an Employee's Salary Record
DELETE FROM Salary
WHERE EmployeeID = 5;



















