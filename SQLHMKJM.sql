-- USE sakila;

-- Answers 1a.
SELECT actor.first_name as "Actor First Name", 
actor.last_name as "Actor Last Name"
FROM actor;

-- Answers 1b
SELECT CONCAT(actor.first_name,' ',actor.last_name) as 'Actor Name'
FROM actor;

-- Answers 2a
SELECT actor.actor_id as "Actor ID", 
actor.first_name as "First Name",
actor.last_name as "Last Name"
FROM actor
WHERE actor.first_name = "Joe";

-- Answers 2b
SELECT actor.first_name as "Actor First Name",
actor.last_name as "Actor Last Name" 
FROM actor
WHERE last_name LIKE '%GEN%';

-- Answers 2c
SELECT actor.last_name as "Actor Last Name", 
actor.first_name as "Actor First Name" 
FROM actor
WHERE actor.last_name LIKE '%LI%'
ORDER BY actor.last_name, actor.first_name;

-- Answers 2d
SELECT country.country_id as "Country ID", 
country.country as "Country" 
FROM country
WHERE country.country IN 
	('Afghanistan', 'Bangladesh', 'China');

-- Answers 3a
ALTER TABLE actor
ADD COLUMN description BLOB;

-- Answers 3b
ALTER TABLE actor
DROP description;

-- Answers 4a
SELECT actor.last_name as "Actor Last Names", 
COUNT(actor.last_name) as "Name Count"
FROM actor
GROUP BY actor.last_name;

-- Answers 4b
SELECT actor.last_name as "Actor Last Names", 
COUNT(actor.last_name) as "Name Count above two"
FROM actor
GROUP BY actor.last_name
HAVING COUNT(actor.last_name) > 2;

-- Answers 4c first query gets actor ID for actor, then second updates
UPDATE actor
SET actor.first_name = "HARPO"
WHERE actor.last_name = "WILLIAMS" 
AND 
actor.first_name = "GROUCHO";

-- Answers 4d
UPDATE actor
SET actor.first_name = "GROUCHO"
WHERE actor.first_name = "HARPO";



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
last_update TIMESTAMP,
PRIMARY KEY (address_id)
);


-- Answers 6a
SELECT staff.first_name as 'First Name', 
staff.last_name as 'Last Name', 
address.address as 'Address'
FROM staff
LEFT JOIN address ON staff.address_id = address.address_id
GROUP BY staff.first_name, staff.last_name;

-- Answers 6b
SELECT staff.first_name as 'First Name', 
staff.last_name as 'Last Name',
SUM(payment.amount) as 'Total Payment'
FROM staff
LEFT JOIN payment ON staff.staff_id = payment.staff_id
GROUP BY staff.first_name, staff.last_name;

-- Answers 6c
SELECT film.title as 'Film Name',
film_actor.actor_id as '# of Actors'
FROM film
INNER JOIN film_actor ON film_actor.film_id = film.film_id
GROUP BY film_actor.actor_id DESC
limit 10;

-- Answers 6d
SELECT film.title as "Title",
COUNT(inventory.film_id) as "# of Copies"
FROM film
JOIN inventory ON film.film_id = inventory.film_id
WHERE film.title = 'Hunchback Impossible';

-- Answers 6e
SELECT customer.first_name as 'Customer First Name', 
customer.last_name as 'Customer Last Name', 
sum(payment.amount) as 'Total Amount Paid'
FROM payment
LEFT JOIN customer ON payment.customer_id = customer.customer_id
GROUP BY customer.first_name, customer.last_name
ORDER BY customer.last_name, customer.first_name;

-- Answers 7a 
SELECT film.title as "English Speaking Film Titles Beginning with K or Q"
	FROM film
	WHERE film.language_id 
    IN  (
		Select language.language_id
		From language
		Where language.language_id =1)
        AND 
        film.title LIKE 'Q%' 
        OR 
        film.title LIKE 'K%';
   
-- Answers 7b
SELECT actor.first_name as "First Name of Actor in Alone Trip", 
	actor.last_name as "Last Name of Actor in Alone Trip"
	FROM actor
	Where actor.actor_id IN
		(Select film_actor.actor_id
		From film_actor
		Where film_actor.film_id IN 
			(Select film.film_id
			from film
			where film.title = 'Alone Trip')
		);

-- Answers 7c 

SELECT customer.first_name as "First Name",
customer.last_name as "Last Name",
customer.email as "Email",
country.country as "Country"
FROM country
INNER JOIN city ON country.country_id = city.country_id
INNER JOIN address ON city.city_id = address.city_id
INNER JOIN customer ON address.address_id = customer.address_id
WHERE country.country = "Canada"
GROUP BY customer.first_name, customer.last_name
ORDER BY customer.first_name, customer.last_name;

-- Answers 7d 

SELECT film.title as "Family Film Titles", category.name as "Movie Type"
FROM film
INNER JOIN film_category ON film.film_id = film_category.film_id
INNER JOIN category ON film_category.category_id = category.category_id
WHERE category.name = 'Family';

-- Answers 7e
SELECT film.title as "Film Name",
COUNT(payment.amount) as "# of Rentals"
FROM payment
INNER JOIN rental ON payment.rental_id = rental.rental_id
INNER JOIN inventory ON rental.inventory_id = inventory.inventory_id
INNER JOIN film on inventory.film_id = film.film_id
GROUP BY film.title
ORDER BY COUNT(payment.amount) DESC, film.title DESC;

-- Answers 7f

SELECT inventory.store_id as "Store ID",
SUM(film.rental_rate) as "Total Rental in dollars"
FROM film
INNER JOIN inventory ON film.film_id = inventory.film_id
GROUP BY inventory.store_id;

-- Answers 7g

SELECT store.store_id as "Store ID#", 
city.city as "Store City",
country.country as "Store Country"
FROM country
INNER JOIN city ON country.country_id = city.country_id
INNER JOIN address ON city.city_id = address.city_id
INNER JOIN store on address.address_id = store.address_id
ORDER BY store.store_id, city.city, country.country;

-- Answers 7h 
SELECT category.name as "Top 5 Genres",
SUM(payment.amount) as "Amount in $"
FROM inventory
INNER JOIN rental ON inventory.inventory_id = rental.inventory_id
INNER JOIN payment ON rental.rental_id = payment.rental_id
INNER JOIN film_category ON inventory.film_id = film_category.film_id
INNER JOIN category ON film_category.category_id = category.category_id
GROUP BY category.name
ORDER BY SUM(payment.amount) DESC
limit 5;


-- Answers 8a
CREATE VIEW Top_five_genres AS
SELECT category.name as "Top 5 Genres",
SUM(payment.amount) as "Amount in $"
FROM inventory
INNER JOIN rental ON inventory.inventory_id = rental.inventory_id
INNER JOIN payment ON rental.rental_id = payment.rental_id
INNER JOIN film_category ON inventory.film_id = film_category.film_id
INNER JOIN category ON film_category.category_id = category.category_id
GROUP BY category.name
ORDER BY SUM(payment.amount) DESC
limit 5;

-- Answers 8b

SELECT * FROM top_five_genres;

-- Answers 8c
DROP VIEW top_five_genres;