-- 1. Create database
CREATE DATABASE lab2;

-- 2. Create a table
CREATE TABLE countries (
    country_id SERIAL PRIMARY KEY,
    country_name VARCHAR(100),
    region_id INTEGER,
    population INTEGER
);

-- 3. Insert a row with data
INSERT INTO countries (country_name, region_id, population)
VALUES ('Canada', 2, 38000000);

-- 4. Insert a row with country_name only
INSERT INTO countries (country_name)
VALUES ('Japan');

-- 5. Insert NULL into region_id
INSERT INTO countries (country_name, region_id, population)
VALUES ('Australia', NULL, 25000000);

-- 6. Insert 3 rows with a single statement
INSERT INTO countries (country_name, region_id, population)
VALUES
    ('France', 3, 67000000),
    ('Germany', 3, 83000000),
    ('Italy', 3, 60000000);

-- 7. Set default value for country_name
ALTER TABLE countries
ALTER COLUMN country_name SET DEFAULT 'Kazakhstan';

-- 8. Insert default value for country_name
INSERT INTO countries (region_id, population)
VALUES (4, 19000000);

-- 9. Insert only default values
INSERT INTO countries DEFAULT VALUES;

-- 10. Create duplicate of the table
CREATE TABLE countries_new (LIKE countries INCLUDING ALL);

-- 11. Insert all rows from countries to countries_new
INSERT INTO countries_new
SELECT * FROM countries;

-- 12. Change region_id to 1 if it equals NULL
UPDATE countries
SET region_id = 1
WHERE region_id IS NULL;

-- 13. Increase population by 10%
SELECT country_name, population * 1.10 AS "New Population"
FROM countries;

-- 14. Remove rows with population less than 100k
DELETE FROM countries
WHERE population < 100000
RETURNING *;

-- 15. Remove rows from countries_new if country_id exists in countries
DELETE FROM countries_new
WHERE country_id IN (SELECT country_id FROM countries)
RETURNING *;

-- 16. Remove all rows from countries
DELETE FROM countries
RETURNING *;