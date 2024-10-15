-- 1. Create a database called 'lab5'
CREATE DATABASE lab5;

-- 2. Create tables
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    cust_name VARCHAR(100),
    city VARCHAR(100),
    grade INT,
    salesman_id INT
);

CREATE TABLE salesmen (
    salesman_id INT PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(100),
    commission DECIMAL(4, 2)
);

CREATE TABLE orders (
    ord_no INT PRIMARY KEY,
    purch_amt DECIMAL(10, 2),
    ord_date DATE,
    customer_id INT,
    salesman_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (salesman_id) REFERENCES salesmen(salesman_id)
);

INSERT INTO customers (customer_id, cust_name, city, grade, salesman_id) VALUES
(3002, 'Nick Rimando', 'New York', 100, 5001),
(3005, 'Graham Zusi', 'California', 200, 5002),
(3001, 'Brad Guzan', 'London',NULL, 5005),
(3004, 'Fabian Johns', 'Paris', 300, 5006),
(3007, 'Brad Davis', 'New York', 200, 5001),
(3009, 'Geoff Camero', 'Berlin', 100, 5003),
(3008, 'Julian Green', 'London', 300, 5002);

INSERT INTO salesmen (salesman_id, name, city, commission) VALUES
(5001, 'James Hoog', 'New York', 0.15),
(5002, 'Nail Knite', 'Paris', 0.13),
(5005, 'Pit Alex', 'London', 0.11),
(5006, 'Mc Lyon', 'Paris', 0.14),
(5003, 'Lauson Hen', NULL, 0.12),
(5007, 'Paul Adam', 'Rome', 0.13);

INSERT INTO orders (ord_no, purch_amt, ord_date, customer_id, salesman_id) VALUES
(70001, 150.5, '2012-10-05', 3005, 5002),
(70009, 270.65, '2012-09-10', 3001, 5005),
(70002, 65.26, '2012-10-05', 3002, 5001),
(70004, 110.5, '2012-08-17', 3009, 5003),
(70007, 948.5, '2012-09-10', 3005, 5002),
(70005, 2400.6, '2012-07-27', 3007, 5001),
(70008, 5760, '2012-09-10', 3002, 5001);

-- 3. Select the total purchase amount of all orders
SELECT SUM(purch_amt) AS total_purchase_amount
FROM orders;

-- 4. Select the average purchase amount of all orders
SELECT AVG(purch_amt) AS average_purchase_amount
FROM orders;

-- 5. Select how many customers have listed their names
SELECT COUNT(cust_name) AS customer_count
FROM customers;

-- 6. Select the minimum purchase amount of all orders
SELECT MIN(purch_amt) AS minimum_purchase_amount
FROM orders;

-- 7. Select customer with all information whose name ends with the letter 'b'
SELECT *
FROM customers
WHERE cust_name LIKE '%b';

-- 8. Select orders made by customers from 'New York'
SELECT orders.*
FROM orders
JOIN customers ON orders.customer_id = customers.customer_id
WHERE customers.city = 'New York';

-- 9. Select customers with all information who have an order with a purchase amount more than 10
SELECT DISTINCT customers.*
FROM customers
JOIN orders ON customers.customer_id = orders.customer_id
WHERE orders.purch_amt > 10;

-- 10. Select the total grade of all customers
SELECT SUM(grade) AS total_grade
FROM customers;

-- 11. Select all customers who have listed their names
SELECT *
FROM customers
WHERE cust_name IS NOT NULL;

-- 12. Select the maximum grade of all customers
SELECT MAX(grade) AS maximum_grade
FROM customers;