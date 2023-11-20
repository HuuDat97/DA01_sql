---baitap1
select 
min(distinct replacement_cost)
from public.film

---baitap2
select 
sum(case when replacement_cost >=9.99 and replacement_cost <=19.99 then 1 else 0 end) as low
from public.film

---baitap3
select 
f.title,
f.length, 
c.name as category_name
from film as f
join public.film_category as fc
on f.film_id=fc.film_id
join public.category as c
on fc.category_id=c.category_id
where c.name = 'Drama' or c.name ='Sports'
ORDER BY f.length DESC
LIMIT 1

---baitap4
select 
count(f.title),
c.name
from film as f
join public.film_category as fc
on f.film_id=fc.film_id
join public.category as c
on fc.category_id=c.category_id
group by c.name
ORDER BY count(f.title) DESC
LIMIT 1

---baitap5
select 
a.first_name || ' ' || a.last_name as name,
count(film_id)
from public.actor as a
join public.film_actor as fa
on a.actor_id=fa.actor_id
group by name
ORDER BY count(film_id) DESC
LIMIT 1

---baitap6
select count(a.address_id)
from public.address as a
left join public.customer as c
on a.address_id=c.address_id
where c.customer_id is null

---baitap7
select c.city,
sum(p.amount)
from public.city as c
join public.address as a
on c.city_id=a.city_id
join public.customer as cu
on cu.address_id=a.address_id
join public.payment as p
on cu.customer_id=p.customer_id
group by c.city
order by sum(p.amount) desc
limit 1

---baitap8
select c.city,
sum(p.amount),
co.country
from public.city as c
join public.address as a
on c.city_id=a.city_id
join public.customer as cu
on cu.address_id=a.address_id
join public.payment as p
on cu.customer_id=p.customer_id
join public.country as co
on co.country_id=c.country_id
group by c.city,co.country
order by sum(p.amount)
limit 1
















