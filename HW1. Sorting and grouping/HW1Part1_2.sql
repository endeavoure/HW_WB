select 
	category, 
	round(avg(price), 2) as avg_price
from products
where name like '%Home%' or name like '%Hair%'
group by category