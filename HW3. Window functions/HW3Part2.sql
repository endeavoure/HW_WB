--Задание 1

select distinct
	sa.shopnumber,
	sh.city,
	sh.address,
	sum(sa.qty) over (partition by sa.shopnumber) as sum_qty,
	sum(sa.qty * g.price) over (partition by sa.shopnumber) as sum_qty_price
from sales sa
join shops sh on sa.shopnumber = sh.shopnumber
join goods g on sa.id_good = g.id_good
where sa.date_ = '02.01.2016'
order by shopnumber asc

--Задание 2

select 
	sa.date_,
	sh.city,
	sum(sa.qty * g.price) / sum(sum(sa.qty * g.price)) over (partition by sa.date_) as sum_sales_rel
from sales sa
join shops sh on sa.shopnumber = sh.shopnumber
join goods g on sa.id_good = g.id_good
where category = 'ЧИСТОТА'
group by sa.date_, sh.city


--Задание 3

with ranked as (
select
	date_,
	shopnumber,
	id_good,
	sum(qty) as sum_qty,
	row_number() over (partition by date_, shopnumber order by sum(qty) desc) as rn
from sales
group by date_, shopnumber, id_good
)
select
	date_,
	shopnumber,
	id_good
from ranked
where rn <= 3


--Задание 4

with filt_sales as (
select
	sa.date_,
	sa.shopnumber,
	g.category,
	sum(sa.qty * g.price) as sum_sales
from sales sa
join shops sh on sa.shopnumber = sh.shopnumber
join goods g on sa.id_good = g.id_good
where sh.city = 'СПб'
group by sa.date_, sa.shopnumber, g.category
)
select
	date_,
	shopnumber,
	category,
	coalesce(lag(sum_sales) over (partition by shopnumber, category order by date_), 0) as prev_sales
from filt_sales
order by date_ asc