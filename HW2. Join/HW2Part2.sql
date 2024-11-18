--Задание 2
create temporary table pr_info as
select
	product_name,
	product_category,
	coalesce(order_ammount, 0) as order_ammount
from products_3
left join orders_2 on orders_2.product_id = products_3.product_id	
group by products_3.product_id, product_category, order_ammount, product_name
order by products_3.product_id asc


create temporary table cat_sum as
select
	product_category,
	sum(ammount) as total_sum
from products_3
left join (select
		       product_id as p_id,
			   sum(order_ammount) as ammount
		   from orders_2
		   group by product_id
		   order by product_id asc) as foo
on p_id = product_id
group by product_category
order by total_sum desc


create temporary table name_cat_total as
select
	product_name,
	product_category,
	max(sum) as product_sum
from (select
		  product_name,
		  product_category,
		  sum(order_ammount)
	  from pr_info
	  group by product_name, product_category) as foo
group by product_category, product_name

create temporary table max_prod as
select
	product_name,
	product_sum,
	product_category
from name_cat_total t
where product_sum = (select
					      max(product_sum)
					  from name_cat_total
					  where product_category = t.product_category)


select
	cat_sum.product_category,
	total_sum,
    (select
    	 product_category
     from cat_sum
     where total_sum = (select max(total_sum) from cat_sum)),
    max_prod.product_name
from cat_sum
inner join max_prod on max_prod.product_category = cat_sum.product_category
order by cat_sum.product_category asc