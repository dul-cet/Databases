CREATE TABLE Books (
    book_id INT PRIMARY KEY,
    title VARCHAR(100),
    author VARCHAR(100),
    price DECIMAL(10, 2),
    quantity INT
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    book_id INT,
    customer_id INT,
    order_date DATE,
    quantity INT,
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100)
);

INSERT INTO Books (book_id, title, author, price, quantity) VALUES
(1, 'Database 101', 'A. Smith', 40.00, 10),
(2, 'Learn SQL', 'B. Johnson', 35.00, 15),
(3, 'Advanced DB', 'C. Lee', 50.00, 5);

INSERT INTO Customers (customer_id, name, email) VALUES
(101, 'John Doe', 'johndoe@example.com'),
(102, 'Jane Doe', 'janedoe@example.com');

-- 1) Transaction for Placing an Order
BEGIN;
INSERT INTO Orders (order_id, book_id, customer_id, order_date, quantity)
VALUES (1, 1, 101, CURRENT_DATE, 2);
UPDATE Books
SET quantity = quantity - 2
WHERE book_id = 1;
COMMIT;

-- 2) Transaction with Rollback
BEGIN;
DO $$
DECLARE
    available_stock INT;
BEGIN
    SELECT quantity INTO available_stock FROM Books WHERE book_id = 3;

    IF available_stock >= 10 THEN
        INSERT INTO Orders (order_id, book_id, customer_id, order_date, quantity)
        VALUES (2, 3, 102, CURRENT_DATE, 10);

        UPDATE Books
        SET quantity = quantity - 10
        WHERE book_id = 3;
    ELSE
        RAISE NOTICE 'Insufficient stock. Rolling back transaction.';
        ROLLBACK;
    END IF;
END $$;

-- 3) Isolation Level Demonstration
-- Session 1:
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
BEGIN;
UPDATE Books
SET price = 37.00
WHERE book_id = 2;

-- Session 2: before commit from Session 1
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
BEGIN;
SELECT price AS "Price Before Commit" FROM Books WHERE book_id = 2;

-- Commit Session 1
COMMIT;

SELECT price AS "Price After Commit" FROM Books WHERE book_id = 2;

-- Commit Session 2
COMMIT;

-- 4) Durability Check
BEGIN;
UPDATE Customers
SET email = 'newemail@example.com'
WHERE customer_id = 101;
COMMIT;

SELECT * FROM Customers WHERE customer_id = 101;