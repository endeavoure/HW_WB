select
	city,
	case
		when age <= 20 then 'young'
		when age between 21 and 49 then 'adult'
		else 'old'
	end as age_group,
	count(*) as age_count
from users
group by city, age_group
order by city, age_count desc