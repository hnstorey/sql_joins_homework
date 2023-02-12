-- Question 1: List all customers who live in Texas (use JOINs)
select customer_id, first_name, last_name, district
from customer
inner join address
on customer.address_id = address.address_id
where district = 'Texas';

-- Question 2: Get all payments above $6.99 with the customer's full name
select first_name, last_name, amount
from customer
inner join payment
on customer.customer_id = payment.customer_id 
where amount > 6.99;

-- Question 3: Show all customers names who have made payments over $175 (use subqueries)
select first_name,last_name,sum_
from customer
INNER join (select payment.customer_id,sum(amount) as sum_
	from payment
	group by payment.customer_id 
	having sum(amount) > 175) as sum_table
on customer.customer_id = sum_table.customer_id
ORDER by sum_ desc;

-- Question 4: List all customers that live in Nepal (use the city table)
-- from customer: first_name,last_name, address_id
-- from address: address_id, city_id
-- from city: city_id, country_id
-- from country: country_id, country

select customer.first_name, customer.last_name, country
from customer
full join address
on customer.address_id = address.address_id 
full join city
on address.city_id = city.city_id 
full join country
on city.country_id = country.country_id 
where country = 'Nepal';

-- Question 5: Which staff members had the most transactions?
-- from rental: max(count(rental_id)), staff_id
-- from staff: staff_id, first_name, last_name

select staff.staff_id,first_name,last_name,count(max_list)
from staff
inner join (select staff_id, count(rental_id)
	from rental
	group by staff_id
	having count(rental_id)=(
		select max(count_)
			from (select staff_id,count(rental_id) as count_
			from rental
			group by staff_id) as count_list)) as max_list
on staff.staff_id = max_list.staff_id
group by staff.staff_id;

-- Question 6: How many movies of each rating are there?
select rating,count(rating)
from film
group by rating;

-- Question 7: Show all customers who have made a single payment above $6.99 (use subqueries).
-- from customer: customer_id, first_name, last_name
-- from payment: distinct(customer_id), amount > 6.99

select customer_id, first_name, Last_name
from customer
where customer_id in (select distinct(customer_id)
	from payment
	where amount > 6.99)
order by customer_id asc;

-- Question 8: How many free rentals did our store give away?
select count(rental_id)
from payment
where amount is null;
