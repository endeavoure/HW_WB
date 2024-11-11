select 
	seller_id,
	max(month_from_registration) as month_from_registration,
	max_delivery_difference
from (
select
	seller_id,
	(current_date - to_date(date_reg, 'DD-MM-YYYY')) / 30 as month_from_registration,
	(select 
	 	max(delivery_days) - min(delivery_days)
	 from sellers
	 where seller_id in (select seller_id from sellers_categorized where seller_type = 'poor')) as max_delivery_difference
from sellers
where seller_id in (select seller_id from sellers_categorized where seller_type = 'poor')
order by seller_id asc) as sellers_min_date
group by seller_id, max_delivery_difference
order by seller_id asc