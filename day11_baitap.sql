---ex1
SELECT
    COUNTRY.Continent,
    FLOOR(AVG(CITY.Population)) 
FROM
    COUNTRY
JOIN
    CITY ON COUNTRY.Code = CITY.CountryCode
GROUP BY
    COUNTRY.Continent;

---ex2
SELECT 
ROUND(SUM(
CASE 
WHEN signup_action = 'Confirmed' THEN 1 ELSE 0 
END)*1.0/ COUNT(signup_action),2) as confirm_rate
FROM emails
JOIN texts
ON emails.email_id=texts.email_id

---ex3
SELECT age_breakdown.age_bucket,
ROUND(100.0*SUM(CASE WHEN activities.activity_type = 'open' THEN time_spent  
END)/SUM(CASE WHEN activities.activity_type = 'open' or activities.activity_type = 'send' THEN time_spent  
END),2) as open_perc,
ROUND(100.0*SUM(CASE WHEN activities.activity_type = 'send' THEN time_spent  
END)/SUM(CASE WHEN activities.activity_type = 'open' or activities.activity_type = 'send' THEN time_spent  
END),2) as send_perc
FROM activities
LEFT JOIN age_breakdown
ON activities.user_id = age_breakdown.user_id
GROUP BY age_breakdown.age_bucket

---ex4
SELECT customer_id	
FROM customer_contracts
LEFT JOIN products ON customer_contracts.product_id = products.product_id
GROUP BY customer_id	
HAVING COUNT(DISTINCT product_category) = (SELECT COUNT(DISTINCT product_category) FROM products);

---ex5
Select  emp2.employee_id,emp2.name,
count(emp2.employee_id) as reports_count,
ROUND(AVG(emp1.age*1.00), 0) AS average_age
From Employees as emp1
Inner join Employees as emp2
ON emp1.reports_to = emp2.employee_id
group by  emp2.employee_id,emp2.name

---ex6
SELECT
p.product_name ,
SUM(o.unit) AS unit
FROM Products as p
JOIN Orders as o ON p.product_id = o.product_id
WHERE
    o.order_date >= '2020-02-01' AND o.order_date < '2020-03-01'
GROUP BY p.product_name 
HAVING SUM(o.unit) >= 100;

---ex7
SELECT pages.page_id FROM pages
FULL OUTER JOIN page_likes ON pages.page_id = page_likes.page_id
WHERE liked_date is NULL
ORDER BY pages.page_id ASC
