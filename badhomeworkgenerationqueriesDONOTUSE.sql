-- Answers 7c 
-- Took this out of the homework because it was generating bad information
SELECT customer.first_name as "First Name", 
customer.last_name as "Last Name", 
customer.email as "Email" ,
country.country as "country"
FROM city, country, customer, address
WHERE country.country_id = city.country_id
AND address.address_id = customer.address_id
AND country.country = "Canada"
GROUP BY customer.first_name, customer.last_name
ORDER BY customer.first_name, customer.last_name;

-- Answers 7d
SELECT film.title as "Family Film Titles"
FROM film
WHERE film.film_id IN 
		(SELECT film_id
		FROM film_category
		WHERE category_id = 8
        );

-- 3 WAYS TO COMPLETE, ABOVE AND 2 BELOW (one with a JOIN statement 

SELECT film.title as "Family Film Titles", category.name as "Movie Type"
FROM film, category, film_category
WHERE category.category_id = film_category.category_id
AND film_category.film_id = film.film_id
AND category.name = 'Family';

-- Answers 7e needs work

SELECT film.title as "Film Name",
COUNT(payment.amount) as "# of Rents"
from payment, rental, inventory, film
WHERE payment.rental_id = rental.rental_id
AND rental.inventory_id = inventory.inventory_id
AND inventory.film_id = film.film_id
GROUP BY film.title 
ORDER BY COUNT(payment.amount) DESC;

-- Answers 7g but incorrectly, pulls all hte store addresses
SELECT store.store_id as "Store ID#", 
city.city as "Store City", 
country.country as "Store Country"
FROM store, city, country, address
WHERE store.address_id = address.address_id
AND city.country_id = country.country_id
ORDER BY country, city;

SELECT * FROM address
WHERE address_id IN (1,2);

SELECT * FROM country 
where country_id IN (8,20);

-- Answers 7h

SELECT category.name as "Top 5 Genres", 
SUM(payment.amount) as "Amount in $"
FROM category, rental, payment, inventory, film_category
WHERE rental.rental_id = payment.rental_id
AND category.category_id = film_category.category_id
AND inventory.film_id = film_category.film_id
AND rental.inventory_id = inventory.inventory_id
GROUP BY category.name
ORDER BY sum(payment.amount) DESC
limit 5;