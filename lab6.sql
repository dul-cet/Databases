-- 1. Create the database
CREATE DATABASE lab6;

-- 2. Create tables
CREATE TABLE locations (
    location_id SERIAL PRIMARY KEY,
    street_address VARCHAR(25),
    postal_code VARCHAR(12),
    city VARCHAR(30),
    state_province VARCHAR(12)
);

CREATE TABLE departments (
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(50) UNIQUE,
    budget INTEGER,
    location_id INTEGER REFERENCES locations
);

CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(50),
    phone_number VARCHAR(20),
    salary INTEGER,
    department_id INTEGER REFERENCES departments
);

-- Insert sample data into the locations table
INSERT INTO locations (street_address, postal_code, city, state_province)
VALUES
('123 Main St', '12345', 'New York', 'NY'),
('456 Park Ave', '67890', 'Los Angeles', 'CA'),
('789 Broadway', '11223', 'Chicago', 'IL');

-- Insert sample data into the departments table
INSERT INTO departments (department_name, budget, location_id)
VALUES
('Sales', 100000, 1),
('Engineering', 200000, 2),
('Marketing', 150000, 1),
('Human Resources', 80000, 3),
('Finance', 120000, NULL);  -- No location assigned for Finance

-- Insert sample data into the employees table
INSERT INTO employees (first_name, last_name, email, phone_number, salary, department_id)
VALUES
('John', 'Doe', 'john.doe@example.com', '555-1234', 60000, 4),
('Jane', 'Smith', 'jane.smith@example.com', '555-5678', 75000, 3),
('Alice', 'Johnson', 'alice.j@example.com', '555-8765', 50000, 1),
('Bob', 'Williams', 'bob.w@example.com', '555-4321', 68000, 2),
('Charlie', 'Brown', 'charlie.b@example.com', '555-9876', 58000, NULL);  -- No department assigned

-- 3. Select the first name, last name, department id, and department name for each employee
SELECT employees.first_name, employees.last_name, employees.department_id, departments.department_name
FROM employees
LEFT JOIN departments ON employees.department_id = departments.department_id;

-- 4. Select the first name, last name, department id and department name for employees in departments 80 or 40
SELECT employees.first_name, employees.last_name, employees.department_id, departments.department_name
FROM employees
JOIN departments ON employees.department_id = departments.department_id
WHERE employees.department_id IN (8, 4);

-- 5. Select the first and last name, department name, city, and state province for each employee
SELECT employees.first_name, employees.last_name, departments.department_name, locations.city, locations.state_province
FROM employees
JOIN departments ON employees.department_id = departments.department_id
JOIN locations ON departments.location_id = locations.location_id;

-- 6. Select all departments, including those with no employees
SELECT departments.department_name, employees.first_name, employees.last_name
FROM departments
LEFT JOIN employees ON departments.department_id = employees.department_id;

-- 7. Select the first name, last name, department id and department name for all employees, including those without a department
SELECT employees.first_name, employees.last_name, employees.department_id, departments.department_name
FROM employees
LEFT JOIN departments ON employees.department_id = departments.department_id;