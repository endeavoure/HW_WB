-- Задание 1 Часть 1
create temporary table customers_orders as
select
	order_id,
	order_date,
	shipment_date,
	order_ammount,
	order_status,
	orders_new.customer_id,
	customers_new.name as orderer_name,
	shipment_date::timestamp - order_date::timestamp as time_diff
from orders_new
left join customers_new on orders_new.customer_id = customers_new.customer_id


select *
from
	(select
		orderer_name,
		time_diff
	from customers_orders
	group by orderer_name, time_diff) as foo
where time_diff = (select
				       max(time_diff)
		      	   from customers_orders)
order by orderer_name asc



-- Задание 1 Часть 2
create temporary table freq_orderers as
select
	*
from 
	(select
		customer_id,
		orderer_name,
		count(*) as num_orders
	 from customers_orders
	 group by customer_id, orderer_name) as foo
where num_orders = (select
						max(num_orders)
					from
						(select
							customer_id,
							orderer_name,
							count(*) as num_orders
						from customers_orders
						group by customer_id, orderer_name) as foo1)
						
						
select
	orderer_name,
	avg(time_diff) as average_time_diff,
	sum(order_ammount) as total_order_sum
from
	(select
		 customers_orders.customer_id,
		 customers_orders.orderer_name,
		 customers_orders.time_diff,
		 customers_orders.order_ammount
	 from customers_orders
	 inner join freq_orderers on freq_orderers.customer_id = customers_orders.customer_id) as foo3
group by orderer_name
order by total_order_sum desc



--Задание 1 Часть 3
create temporary table delays as
select
	orderer_name,
	count(*) as num_delays
from customers_orders
where extract(epoch from time_diff)/(3600*24) > 5
group by orderer_name
order by orderer_name


create temporary table cancellations as
select
	orderer_name,
	count(*) as num_cancel,
	sum(order_ammount) as total_sum
from customers_orders
where order_status = 'Cancel'
group by orderer_name
order by orderer_name


select
	coalesce(delays.orderer_name, cancellations.orderer_name) as orderer_name,
	coalesce(num_delays, 0) as num_delays,
	coalesce(num_cancel, 0) as num_cancel,
	coalesce(total_sum, 0) as total_sum
from delays
full join cancellations on cancellations.orderer_name = delays.orderer_name
order by total_sum desc