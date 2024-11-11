select
	seller_id,
	string_agg(category, '-' order by category) as category_pair
from sellers
where extract(year from to_date(date_reg, 'DD-MM-YYYY')::DATE) = 2022
group by seller_id
having count(*) = 2 and sum(revenue) > 75000