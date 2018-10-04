-- USE sakila;

-- Answers 1a.
SELECT first_name, last_name FROM actor;

-- Answers 1b
ALTER TABLE actor
ADD COLUMN Actor_Name VARCHAR(50)

SELECT CONCAT (first_name, ' ',last_name) as Actor_Name
FROM actor;

-- Answers 2a
SELECT actor_id, first_name, last_name FROM actor
WHERE first_name = "Joe";

-- Answers 2b
SELECT first_name, last_name FROM actor
WHERE last_name LIKE '%GEN%';

-- Answers 2c
SELECT last_name, first_name FROM actor
WHERE last_name LIKE '%LI%'
ORDER BY last_name, first_name;

-- Answers 2d
SELECT country_id, country FROM country
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

-- Answers 3a
ALTER TABLE actor
ADD COLUMN description BLOB;

-- Answers 3b
ALTER TABLE actor
DROP description;

-- Answers 4a
-- SELECT last_name FROM actor;
-- SELECT COUNT(last_name) as "Actor Count" FROM actor;

SELECT last_name, COUNT(*)
FROM actor
GROUP BY last_name;

-- Answers 4b
SELECT last_name, COUNT(*)
FROM actor
GROUP BY last_name
HAVING COUNT(*) > 2;

-- Answers 4c
SELECT actor_id, first_name, last_name FROM actor
WHERE last_name = "WILLIAMS";

UPDATE actor
SET first_name = "HARPO"
WHERE actor_id = 172;

-- Answers 4d
UPDATE actor
SET first_name = "GROUCHO"
WHERE first_name = "HARPO";

-- Answers 5a
CREATE TABLE address (
address_id SMALLINT(5),
address VARCHAR(50) ,
address2 VARCHAR(50),
district VARCHAR(20),
city_id SMALLINT(5),
postal_code VARCHAR(10), 
phone VARCHAR(20),
location GEOMETRY,
last_update TIMESTAMP
);

-- Answers 6a
SELECT staff.first_name, staff.last_name, address.address
FROM staff
LEFT JOIN address ON staff.address_id = address.address_id;
