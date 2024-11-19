CREATE DATABASE lab8;

CREATE TABLE salesman (
    salesman_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(100),
    commission DECIMAL(10, 2)
);

CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(100),
    grade INT,
    salesman_id INT REFERENCES salesman(salesman_id)
);

CREATE TABLE orders (
    order_number SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    salesman_id INT REFERENCES salesman(salesman_id),
    order_date DATE,
    amount DECIMAL(10, 2)
);

INSERT INTO salesman (salesman_id, name, city, commission) VALUES
(5001, 'James Hoog', 'New York', 0.15),
(5002, 'Nail Knite', 'Paris', 0.13),
(5005, 'Pit Alex', 'London', 0.11),
(5006, 'Mc Lyon', 'Paris', 0.14),
(5003, 'Lauson Hen', null, 0.12),
(5007, 'Paul Adam', 'Rome', 0.13);

INSERT INTO customers (customer_id, name, city, grade, salesman_id) VALUES
(3002, 'Nick Rimando', 'New York', 100, 5001),
(3005, 'Graham Zusi', 'California', 200, 5002),
(3001, 'Brad Guzan', 'London', null, 5005),
(3004, 'Fabian Johns', 'Paris', 300, 5006),
(3007, 'Brad Davis', 'New York', 200, 5001),
(3009, 'Geoff Camero', 'Berlin', 100, 5003),
(3008, 'Julian Green', 'London', 300, 5002);

INSERT INTO orders (order_number, amount, order_date, customer_id, salesman_id) VALUES
(70001, 150.5, '2012-10-05', 3005, 5002),
(70009, 270.65, '2012-09-10', 3001, 5005),
(70002, 65.26, '2012-10-05', 3002, 5001),
(70004, 110.5, '2012-08-17', 3009, 5003),
(70007, 948.5, '2012-09-10', 3005, 5002),
(70005, 2400.6, '2012-07-27', 3007, 5001),
(70008, 5760, '2012-09-10', 3002, 5001);

CREATE ROLE junior_dev LOGIN;

CREATE VIEW salesmen_newyork AS
SELECT * FROM salesman
WHERE city = 'New York';

CREATE VIEW order_details AS
SELECT
    orders.order_number,
    orders.order_date,
    orders.amount,
    salesman.name AS salesman_name,
    customers.name AS customer_name
FROM orders
LEFT JOIN salesman ON orders.salesman_id = salesman.salesman_id
LEFT JOIN customers ON orders.customer_id = customers.customer_id;

GRANT ALL PRIVILEGES ON order_details TO junior_dev;

CREATE VIEW highest_grade_customers AS
SELECT * FROM customers
WHERE grade = (SELECT MAX(grade) FROM customers);

GRANT SELECT ON highest_grade_customers TO junior_dev;

CREATE VIEW salesman_count_per_city AS
SELECT city, COUNT(*) AS salesman_count
FROM salesman
GROUP BY city;

CREATE VIEW salesman_with_multiple_customers AS
SELECT
    salesman.salesman_id,
    salesman.name,
    COUNT(customers.customer_id) AS customer_count
FROM salesman
LEFT JOIN customers ON salesman.salesman_id = customers.salesman_id
GROUP BY salesman.salesman_id, salesman.name
HAVING COUNT(customers.customer_id) > 1;

CREATE ROLE intern;

GRANT junior_dev TO intern;