--- EX1
SELECT NAME
FROM CITY
WHERE CountryCode = 'USA' AND Population > 120000

---EX2
SELECT * FROM CITY
WHERE COUNTRYCODE = 'JPN'

---EX3
SELECT CITY, STATE
FROM STATION;

---EX4
select distinct CITY from STATION
where CITY like 'a%' or CITY like 'i%' or CITY like 'u%' or CITY like 'o%' or CITY like 'e%'

---EX5
select distinct CITY from STATION
where CITY like '%a' or CITY like '%i' or CITY like '%u' or CITY like '%o' or CITY like '%e'

---EX6
select distinct CITY from STATION
where NOT CITY like 'a%' AND NOT CITY like 'i%' AND NOT CITY like 'u%' AND NOT CITY like 'o%' AND NOT CITY like 'e%'

---EX7
SELECT name FROM Employee
order by name ASC

---EX8
select name from Employee
where salary > 2000 and months < 10
order by employee_id asc

---EX9
select product_id from Products
where low_fats = 'Y' and recyclable = 'Y'

---EX10
select name from Customer
Where referee_id !=2 or referee_id is null

---EX11
select name, population, area from World
where area > 3000000 or population > 25000000

---EX12
select distinct author_id as id from Views
where author_id = viewer_id
order by author_id asc

---EX13
SELECT part,assembly_step
FROM parts_assembly
WHERE finish_date IS NULL

---EX14
SELECT * FROM lyft_drivers
where yearly_salary <= 30000 
OR yearly_salary >= 70000

---EX15
select * from uber_advertising
where year = 2019 
and money_spent > 100000
