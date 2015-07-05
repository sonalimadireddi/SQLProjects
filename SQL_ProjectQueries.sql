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

#Left(),MIN(),MAX()
#Using the left() commnad - How many rentals each month 
SELECT left(r.rental_date,7), count(r.rental_id)

FROM rental r

GROUP BY 1

ORDER BY 2 desc

;

/*OUTPUT
2005-07	6709
2005-08	5686
2005-06	2311
2005-05	1156
2006-02	182
*/

#Using the min() and max() commands
#Finding out the min and max rental dates for each movie 

SELECT f.title as "Film Title", MIN(r.rental_date) as "First time rented", MAX(r.rental_date) as "Most recent time rented"

FROM rental r, inventory i, film f

WHERE r.inventory_id=i.inventory_id AND i.film_id=f.film_id

GROUP BY f.film_id

;

/* Sample Output
ACADEMY DINOSAUR	2005-05-27 07:03:28	2005-08-23 01:01:01
ACE GOLDFINGER	2005-07-07 19:46:51	2006-02-14 15:16:03
ADAPTATION HOLES	2005-05-31 04:50:07	2005-08-23 13:54:39
AFFAIR PREJUDICE	2005-05-27 20:44:36	2006-02-14 15:16:03
AFRICAN EGG	2005-05-28 07:53:38	2006-02-14 15:16:03
AGENT TRUMAN	2005-05-26 15:32:46	2005-08-21 16:03:01
AIRPLANE SIERRA	2005-06-20 21:11:50	2005-08-22 17:18:05
AIRPORT POLLOCK	2005-05-25 19:37:47	2005-08-23 20:24:36
ALABAMA DEVIL	2005-07-06 18:32:49	2005-08-23 14:26:51
*/

#1)Every customer's last rental date  

SELECT c.customer_id, concat(c.first_name, " ",c.last_name) as "Name" , c.email as "Customer Email", MAX(r.rental_date) as "last rental date"

FROM customer c, rental r 

WHERE c.customer_id=r.customer_id

GROUP BY 1
;

/*Sample Output
1	MARY SMITH	2005-08-22 20:03:46
2	PATRICIA JOHNSON	2005-08-23 17:39:35
3	LINDA WILLIAMS	2005-08-23 07:10:14
4	BARBARA JONES	2005-08-23 07:43:00
5	ELIZABETH BROWN	2006-02-14 15:16:03
*/

#2)Revenue by month
SELECT left(p.payment_date,7) as "Month", SUM(p.amount) as "Revenue"

FROM payment p 

GROUP BY 1
;

/*Output
2005-05	4824.43
2005-06	9631.88
2005-07	28373.89
2005-08	24072.13
2006-02	514.18
*/

#Usage of Distinct Function 
#How many distinct renters we have per month
SSELECT left(r.rental_date,7) as "Month", count(r.rental_id) as" total rentals", count(distinct r.customer_id) as "number of customers", count(r.rental_id)/count(distinct r.customer_id) as "number of customers per month"

FROM rental r
 
GROUP BY 1
;

/* Sample Output
2005-05	1156	520	2.2231
2005-06	2311	590	3.9169
2005-07	6709	599	11.2003
2005-08	5686	599	9.4925
2006-02	182		158	1.1519
*/

#The number of distinct films rented each month
SELECT left(r.rental_date, 7) as "rental month", count(r.rental_id) as "total rentals", count(distinct i.film_id) as "distinct films", count(r.rental_id)/count(distinct i.film_id) as "rentals per film per month"

FROM rental r, inventory i

WHERE r.inventory_id=i.inventory_id

GROUP BY 1

;

/* Output 
2005-05	1156	686	1.6851
2005-06	2311	900	2.5678
2005-07	6709	958	7.0031
2005-08	5686	958	5.9353
2006-02	182	168	1.0833
*/

#IN(),Comparison operators and Having()
#Question - Find the number of rentals in certain categories such as comedy, sports and family 
SELECT c.name as category, count(r.rental_id)

FROM rental r, inventory i, film_category fc, category c

WHERE r.rental_id=i.inventory_id 
	AND i.film_id=fc.film_id 
	AND fc.category_id=c.category_id
	AND c.name in ("Comedy", "Sports","Family")

GROUP BY 1
;

/*Output
Comedy	941
Family	1096
Sports	1179
*/

#Comparision Operators 
#Users who have rented atleast 3 times 

SELECT r.customer_id as "customer id", count(r.rental_id) as "number of rentals"

FROM rental r

GROUP BY 1

Having count(r.rental_id) >= 3
;

/*Output
1	32
2	27
3	26
4	22
5	38
6	28
7	33
8	24
9	23
*/

# revenue for store 1 where the film is rated R or PG-13
SELECT f.rating as rating, p.amount as revenue

FROM film f, payment p, inventory i, rental r

WHERE p.rental_id=r.rental_id
	AND r.inventory_id=i.inventory_id
	AND i.film_id=f.film_id
	AND i.store_id =1
	AND f.rating in ('R','PG-13')

GROUP BY 1,2 

ORDER BY 2 desc
;

/*Output
1	PG-13	8091.51
1	R	6514.62
*/




























