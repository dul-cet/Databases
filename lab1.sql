CREATE TABLE tasks (
    id SERIAL,
    name VARCHAR(50),
    user_id INT,
    PRIMARY KEY (id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);