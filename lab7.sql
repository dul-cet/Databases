-- 1. Create the countries table
CREATE TABLE countries (
    country_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    continent VARCHAR(50),
    population INTEGER
);

-- Insert sample data into countries
INSERT INTO countries (name, continent, population)
VALUES
    ('United States', 'North America', 331000000),
    ('Canada', 'North America', 38000000),
    ('Mexico', 'North America', 126000000),
    ('France', 'Europe', 67000000),
    ('Germany', 'Europe', 83000000);

-- 2. Create the departments table
CREATE TABLE departments (
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(50) UNIQUE,
    budget INTEGER,
    location_id INTEGER
);

-- Insert sample data into departments
INSERT INTO departments (department_name, budget, location_id)
VALUES
    ('HR', 100000, 1),
    ('Engineering', 500000, 2),
    ('Sales', 300000, 3),
    ('Marketing', 200000, 4);

-- 3. Create the employees table
CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    surname VARCHAR(50),
    salary INTEGER,
    department_id INTEGER REFERENCES departments(department_id)
);

-- Insert sample data into employees
INSERT INTO employees (name, surname, salary, department_id)
VALUES
    ('John', 'Doe', 70000, 1),
    ('Jane', 'Smith', 80000, 2),
    ('Alice', 'Johnson', 90000, 2),
    ('Bob', 'Brown', 60000, 3),
    ('Charlie', 'Davis', 40000, NULL);  -- This employee has no department

-- Indexes based on the tasks

-- 1. Create an index on the countries name column
CREATE INDEX idx_countries_name ON countries (name);

-- 2. Create a composite index on employees' name and surname columns
CREATE INDEX idx_employees_name_surname ON employees (name, surname);

-- 3. Create a unique index on employees' salary for range queries
CREATE UNIQUE INDEX idx_employees_salary_range ON employees (salary);

-- 4. Create an index on the first 4 characters of employees' name
CREATE INDEX idx_employees_name_substr ON employees (substring(name from 1 for 4));

-- 5. Create indexes for joining employees and departments on department_id, with filtering on budget and salary
CREATE INDEX idx_emp_dept_budget_salary ON employees (department_id, salary);
CREATE INDEX idx_dept_budget ON departments (budget);

-- Sample Queries to Test the Indexes

-- Test query for Task 1
SELECT * FROM countries WHERE name = 'France';

-- Test query for Task 2
SELECT * FROM employees WHERE name = 'John' AND surname = 'Doe';

-- Test query for Task 3
SELECT * FROM employees WHERE salary < 85000 AND salary > 65000;

-- Test query for Task 4
SELECT * FROM employees WHERE substring(name from 1 for 4) = 'Alic';

-- Test query for Task 5
SELECT * FROM employees e
JOIN departments d ON d.department_id = e.department_id
WHERE d.budget > 200000 AND e.salary < 85000;