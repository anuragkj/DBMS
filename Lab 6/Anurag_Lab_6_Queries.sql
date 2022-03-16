#Query 1
CREATE VIEW QUERY1 AS
SELECT actor_id, first_name, last_name 
FROM actor
WHERE last_name LIKE '%GEN%';

#Query 2
CREATE VIEW QUERY2 AS
SELECT country_id, country
FROM country 
WHERE country IN 
('Afghanistan', 'Bangladesh', 'China');

#Query 3
CREATE VIEW QUERY3 AS
SELECT f.title AS 'Film Title', COUNT(fa.actor_id) AS `Number of Actors`
FROM film_actor fa
INNER JOIN film f 
ON fa.film_id= f.film_id
GROUP BY f.title;

#Query 4
CREATE VIEW QUERY4 AS
SELECT last_name, COUNT(*) AS 'Number of Actors' 
FROM actor GROUP BY last_name;

#Query 5
CREATE VIEW QUERY5 AS
SELECT last_name, COUNT(*) AS 'Number of Actors' 
FROM actor GROUP BY last_name HAVING count(*) >=2;

#Query 6
CREATE VIEW QUERY6 AS
SELECT first_name, last_name, address
FROM staff s 
JOIN address a
ON s.address_id = a.address_id;

#Query 7
CREATE VIEW QUERY7 AS
SELECT first_name, last_name
FROM actor
WHERE actor_id IN
(
Select actor_id
FROM film_actor
WHERE film_id IN 
(
SELECT film_id
FROM film
WHERE title = 'Alone Trip'
));

#Query 8
CREATE VIEW QUERY8 AS
SELECT f.title, COUNT(rental_id) AS 'Times Rented'
FROM rental r
JOIN inventory i
ON (r.inventory_id = i.inventory_id)
JOIN film f
ON (i.film_id = f.film_id)
GROUP BY f.title
ORDER BY `Times Rented` DESC;

#Query 9
CREATE VIEW QUERY9 AS
SELECT s.store_id, cty.city, country.country 
FROM store s
JOIN address a 
ON (s.address_id = a.address_id)
JOIN city cty
ON (cty.city_id = a.city_id)
JOIN country
ON (country.country_id = cty.country_id);

#Query 10
DROP view QUERY1;

#Check
SELECT * FROM QUERY3;