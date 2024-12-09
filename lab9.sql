-- Task 1: Function to increase a value by 10
CREATE OR REPLACE FUNCTION increase_value(a INTEGER) RETURNS INTEGER AS $$
BEGIN
    RETURN a + 10;
END;
$$ LANGUAGE plpgsql;

SELECT increase_value(5);

-- Task 2: Function to compare two numbers
CREATE OR REPLACE FUNCTION compare_numbers(a INTEGER, b INTEGER) RETURNS TEXT AS $$
BEGIN
    IF a > b THEN
        RETURN 'Greater';
    ELSIF a = b THEN
        RETURN 'Equal';
    ELSE
        RETURN 'Lesser';
    END IF;
END;
$$ LANGUAGE plpgsql;

SELECT compare_numbers(5, 10);

-- Task 3: Function to generate a series from 1 to n
CREATE OR REPLACE FUNCTION number_series(n INTEGER) RETURNS TABLE(number INTEGER) AS $$
BEGIN
    RETURN QUERY
    SELECT generate_series(1, n);
END;
$$ LANGUAGE plpgsql;

SELECT * FROM number_series(10);

CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    position VARCHAR(50),
    salary NUMERIC(10, 2)
);

INSERT INTO employees (name, position, salary) VALUES
('John Doe', 'Manager', 60000),
('Jane Smith', 'Developer', 50000),
('Emily Davis', 'Analyst', 45000);

-- Task 4: Function to find employee details by name
CREATE OR REPLACE FUNCTION find_employee(emp_name VARCHAR) RETURNS TABLE(employee_id INTEGER, employee_name VARCHAR, job_position VARCHAR, employee_salary NUMERIC) AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, position, salary FROM employees WHERE name = emp_name;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM find_employee('John Doe');

CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    price NUMERIC(10, 2),
    category VARCHAR(50)
);

INSERT INTO products (name, price, category) VALUES
('Laptop', 1200.00, 'Electronics'),
('Phone', 800.00, 'Electronics'),
('Chair', 150.00, 'Furniture'),
('Table', 300.00, 'Furniture');

-- Task 5: Function to list products from a category
CREATE OR REPLACE FUNCTION list_products(category_name VARCHAR) RETURNS TABLE(product_id INTEGER, product_name VARCHAR, product_price NUMERIC, product_category VARCHAR) AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, price, category FROM products WHERE category = category_name;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM list_products('Electronics');

-- Task 6: Functions for bonus calculation and salary update
CREATE OR REPLACE FUNCTION calculate_bonus(salary NUMERIC) RETURNS NUMERIC AS $$
BEGIN
    RETURN salary * 0.10;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_salary(emp_id INTEGER) RETURNS VOID AS $$
DECLARE
    current_salary NUMERIC;
    bonus NUMERIC;
BEGIN
    SELECT salary INTO current_salary FROM employees WHERE id = emp_id;

    bonus := calculate_bonus(current_salary);

    UPDATE employees SET salary = salary + bonus WHERE id = emp_id;

END;
$$ LANGUAGE plpgsql;

SELECT update_salary(2);

SELECT * FROM employees;

-- Task 7: Function with nested blocks for complex calculation
CREATE OR REPLACE FUNCTION complex_calculation(a INTEGER, b VARCHAR) RETURNS TEXT AS $$
DECLARE
    numeric_result INTEGER;
    text_result VARCHAR;
BEGIN
    BEGIN
        numeric_result := a * 10;
    END;

    BEGIN
        text_result := 'Processed: ' || b;
    END;

    RETURN text_result || ' | Numeric Result: ' || numeric_result;
END;
$$ LANGUAGE plpgsql;

SELECT complex_calculation(6, 'Data');