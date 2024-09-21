DELETE FROM countries
WHERE population < 100000
RETURNING *;