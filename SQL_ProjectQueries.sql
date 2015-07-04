# Customer ID, first and last name and their mailing address 
#Customer ID, first and last name information can be taken from the customer table. Mailing address can be taken from the address table

SELECT customer.customer.id, customer.first_name, customer.last_name, address.address

FROM customer, address

WHERE customer.address_id=address.address_id
;

#Every film, category of the film, anguage of the film 

SELECT film.title, category.name

FROM film, film_category,category

WHERE film.film_id=category.category_id
;

#How many times has each movie been rented out

SELECT f.titel,count(r.rental_id)

FROM film f, rental r, inventory i

WHERE f.film_id=i.film_id AND i.rental_id=r.rental.id

GROUP BY 1

#Revenue per movie title

SELECT f.titel,count(r.rental_id)

FROM film f, rental r, inventory i

WHERE f.film_id=i.film_id AND i.rental_id=r.rental.id

GROUP BY 1

#Version 2 - Revenue per movie title
#Using the as keyword to name the columns in the output
SELECT f.title as "Film Title",count(r.rental_id) as "Number of Rentals",f.rental_rate as "Rate",count(r.rental_id) *f.rental_rate as Revenue 

FROM film f JOIN rental r JOIN inventory i

WHERE f.film_id=i.film_id AND i.inventory_id=r.inventory_id

GROUP BY 1

ORDER BY 4 desc

#Which customer is buying the most movies 

SELECT p.customer_id, SUM(p.amount)

FROM payment p

GROUP BY p.customer_id

ORDER BY SUM(p.amount) desc

#Version 2: Display the names of the customers who have bought the maximum movies 
SELECT p.customer_id, SUM(p.amount)

FROM payment p

GROUP BY p.customer_id

ORDER BY SUM(p.amount) desc





