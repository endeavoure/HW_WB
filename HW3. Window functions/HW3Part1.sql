-- Задание 1 с использованием max/min

create temporary table max_salary as
select
	industry,
	max(salary) as max_sal
from salary
group by industry

create temporary table min_salary as
select
	industry,
	min(salary) as min_sal
from salary
group by industry


with top_salary as (
select
	s.salary,
	s.industry,
	s.first_name ||' '|| s.last_name as name_highest_sal
from salary s
join max_salary on s.industry = max_salary.industry and s.salary = max_salary.max_sal
)
select 
	s.first_name,
	s.last_name,
	s.industry,
	s.salary,
	t.name_highest_sal
from salary s
join top_salary t on s.industry = t.industry


with bottom_salary as (
select
	s.salary,
	s.industry,
	s.first_name ||' '|| s.last_name as name_lowest_sal
from salary s
join min_salary on s.industry = min_salary.industry and s.salary = min_salary.min_sal
)
select 
	s.first_name,
	s.last_name,
	s.industry,
	s.salary,
	b.name_lowest_sal
from salary s
join bottom_salary b on s.industry = b.industry



-- Задание 1 с использованием first/last value

--Максимум
select
	first_name,
	last_name,
	industry,
	salary,
	first_value(first_name ||' '|| last_name) over (
		partition by industry
		order by salary desc
	) as name_highest_sal
from salary

--Минимум
select
	first_name,
	last_name,
	industry,
	salary,
	first_value(first_name ||' '|| last_name) over (
		partition by industry
		order by salary asc
	) as name_lowest_sal
from salary