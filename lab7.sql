-- 1. Create an index on the countries name column
CREATE INDEX idx_countries_name ON countries (name);

-- 2. Create a composite index on employees' name and surname columns
CREATE INDEX idx_employees_name_surname ON employees (name, surname);

-- 3. Create a unique index on employees' salary for range queries
CREATE UNIQUE INDEX idx_employees_salary_range ON employees (salary);

-- 4. Create an index on the first 4 characters of employees' name
CREATE INDEX idx_employees_name_subst ON employees (substring(name from 1 for 4));

-- 5. Create indexes for joining employees and departments on department_id, with filtering on budget and salary
CREATE INDEX idx_emp_dept_budget_salary ON employees (department_id, salary);
CREATE INDEX idx_dept_budget ON departments (budget);