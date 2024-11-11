create table sellers_no_bed as
select * from sellers
where category != 'Bedding'

create table sellers_categorized as
select
	seller_id,
	count(category) as total_categ,
	avg(rating) as avg_rating,
	sum(revenue) as total_revenue,
	case
		when count(category) > 1 and sum(revenue) > 50000 then 'rich'
		when count(category) > 1 and sum(revenue) < 50000 then 'poor'
	end as seller_type
from sellers_no_bed
group by seller_id
order by seller_id asc

select * from sellers_categorized