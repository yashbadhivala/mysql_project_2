CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    RegistrationDate DATE
);

INSERT INTO Customer (CustomerID, FirstName, LastName, Email, RegistrationDate) VALUES
(1, 'Rahul', 'Sharma', 'rahul.sharma@example.com', '2023-01-15'),
(2, 'Priya', 'Patel', 'priya.patel@example.com', '2023-02-10'),
(3, 'Amit', 'Kumar', 'amit.kumar@example.com', '2023-03-05'),
(4, 'Sneha', 'Joshi', 'sneha.joshi@example.com', '2023-04-20'),
(5, 'Vikram', 'Singh', 'vikram.singh@example.com', '2023-05-18');


CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10,2),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount) VALUES
(101, 1, '2023-02-01', 1500.50),
(102, 2, '2023-02-15', 2450.00),
(103, 3, '2023-03-12', 875.75),
(104, 1, '2023-04-05', 3200.00),
(105, 4, '2023-05-10', 1250.25);

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    HireDate DATE,
    Salary DECIMAL(10,2)
);

INSERT INTO Employees (EmployeeID, FirstName, LastName, Department, HireDate, Salary) VALUES
(1, 'Anil', 'Mehta', 'HR', '2021-01-10', 45000.00),
(2, 'Sunita', 'Rao', 'Finance', '2020-07-15', 60000.00),
(3, 'Rajesh', 'Verma', 'IT', '2022-03-20', 75000.00),
(4, 'Neha', 'Kapoor', 'Marketing', '2019-11-05', 55000.00),
(5, 'Karan', 'Desai', 'Sales', '2023-04-01', 50000.00);

--INNER JOIN: Retrieve all orders and customer details where orders exist.
SELECT C.FirstName,C.LastName,O.OrderID
from Customer as C
INNER JOIN Orders as O on C.CustomerID=O.CustomerID;

--LEFT JOIN: Retrieve all customers and their corresponding orders (if any).
SELECT C.FirstName,C.LastName,O.OrderID
from Customer as C
left JOIN Orders as O on C.CustomerID=O.CustomerID;

--RIGHT JOIN: Retrieve all orders and their corresponding customers (if any).
SELECT C.FirstName,C.LastName,O.OrderID
from Customer as C
RIGHT JOIN Orders as O on C.CustomerID=O.CustomerID;

--FULL OUTER JOIN: Retrieve all customers and all orders, regardless of matching.
SELECT C.FirstName,C.LastName,O.OrderID
from Customer as C
left JOIN Orders as O on C.CustomerID=O.CustomerID
UNION
SELECT C.FirstName,C.LastName,O.OrderID
from Customer as C
RIGHT JOIN Orders as O on C.CustomerID=O.CustomerID;





------------Subquery to find customers who have placed orders worth more than the average amount.
SELECT CustomerID from orders WHERE TotalAmount > (SELECT avg(TotalAmount) from Orders);





--Subquery to find employees with salaries above the average salary.
SELECT 
    EmployeeID,
    FirstName,
    LastName,
    Department,
    Salary
FROM Employees
WHERE Salary > (
    SELECT AVG(Salary)
    FROM Employees
);

--Extract the year and month from the OrderDate.
SELECT 
    YEAR(OrderDate) AS OrderYear,
    MONTH(OrderDate) AS OrderMonth
FROM Orders;

--Calculate the difference in days between two dates (OrderDate and current date).
SELECT 
    OrderID,
    CustomerID,
    OrderDate,
    CURDATE() AS CurrentDate,DATEDIFF(CURDATE(), OrderDate) AS DaysDifference
FROM Orders;

--Format the OrderDate to a more readable format (e.g., DD-MMM-YYYY).
SELECT 
    OrderID,
    CustomerID,
    OrderDate,
    DATE_FORMAT(OrderDate, '%d-%b-%Y') AS FormattedDate
FROM Orders;

--Concatenate FirstName and LastName to form a full name.
SELECT 
    EmployeeID,
    CONCAT(FirstName, ' ', LastName) AS FullName,
    Department,
    Salary
FROM Employees;


update employees set FirstName='Dhirubhai' WHERE EmployeeID=1;

---Convert FirstName to uppercase and LastName to lowercase.
SELECT upper(FirstName) AS uppercase_name FROM employees;
SELECT LOWER(LastName) AS lowercase_name FROM employees;


--- Trim extra spaces from the Email field.
select TRIM(Email) from Customer;

--Calculate the running total of TotalAmount for each order.
SELECT 
    OrderID,
    CustomerID,
    OrderDate,
    TotalAmount,
    SUM(TotalAmount) OVER (ORDER BY OrderDate) AS RunningTotal
FROM Orders;

--Rank orders based on TotalAmount using the RANK() function.
SELECT 
    OrderID,
    CustomerID,
    OrderDate,
    TotalAmount,
    RANK() OVER (ORDER BY TotalAmount DESC) AS AmountRank
FROM Orders;



---Assign a discount based on TotalAmount in orders (e.g., >1000: 10% off, >500: 5% off).
SELECT OrderID, CustomerID, TotalAmount,
CASE 
    WHEN TotalAmount > 1000 THEN TotalAmount *0.10
    WHEN TotalAmount > 500 THEN TotalAmount *0.05
    ELSE  0

END AS DiscountAmount,

CASE 
    WHEN TotalAmount > 1000 THEN TotalAmount *0.90
    WHEN TotalAmount > 500 THEN TotalAmount *0.95
    ELSE TotalAmount
END AS FinalAmount

from Orders;

    



--Categorize employees' salaries as high, medium, or low.
SELECT max(salary) from employees;


SELECT min(salary) from employees;


SELECT AVG(salary) from employees;



