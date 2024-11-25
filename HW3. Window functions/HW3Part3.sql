create table query (
	searchid int,
	year int,
	month int,
	day int,
	userid int,
	ts int,
	devicetype varchar(50),
	deviceid int,
	query varchar(250),
	is_final int
)

insert into query (searchid, year, month, day, userid, ts, devicetype, deviceid, query)
values
	(1, 2024, 11, 7, 1, 1730937600, 'android', 1, 'к'),
	(2, 2024, 11, 7, 1, 1730938000, 'android', 1, 'купить'),
	(3, 2024, 11, 7, 2, 1730938500, 'apple', 2, 'купить масло моторное'),
	(4, 2024, 11, 7, 2, 1730938600, 'apple', 2, 'купить масло'),
	(5, 2024, 11, 7, 2, 1730938900, 'apple', 2, 'купить фильтр воздушный'),
	(6, 2024, 11, 7, 3, 1730940000, 'android', 3, 'куп'),
	(7, 2024, 11, 7, 3, 1730940100, 'android', 3, 'купить аккумулятор'),
	(8, 2024, 11, 7, 3, 1730940300, 'android', 3, 'купить аккумулятор лада веста'),
	(9, 2024, 11, 8, 4, 1731024000, 'android', 1, 'купить'),
	(10, 2024, 11, 8, 4, 1731024400, 'android', 1, 'купить сомалийскую'),
	(11, 2024, 11, 8, 4, 1731024460, 'android', 1, 'купить сомалийскую кошку'),
	(12, 2024, 11, 8, 2, 1731025000, 'apple', 2, 'купить контрактный мотор'),
	(13, 2024, 11, 8, 2, 1731025200, 'apple', 2, 'купить мотор'),
	(14, 2024, 11, 8, 3, 1731026000, 'android', 3, 'купить мойку керхер для авто'),
	(15, 2024, 11, 8, 3, 1731026050, 'android', 3, 'купить мойку для авто'),
	(16, 2024, 11, 8, 3, 1731026500, 'android', 3, 'купить шампунь авто'),
	(17, 2024, 11, 9, 5, 1731110400, 'apple', 4, 'купить мишлен резина шипы'),
	(18, 2024, 11, 9, 5, 1731110461, 'apple', 4, 'купить резину шипы'),
	(19, 2024, 11, 9, 6, 1731111000, 'android', 5, 'купить гугл пиксель новый'),
	(19, 2024, 11, 9, 6, 1731111700, 'android', 5, 'купить гугл пиксель новый максимальная начинка'),
	(20, 2024, 11, 9, 7, 1731111900, 'android', 6, 'лада веста спорт купить')
	

create temp table tempr as
select
	searchid,
	ts,
	devicetype,
	query,
	lead(ts) over (partition by userid, deviceid order by ts) as next_ts,
	lead(query) over (partition by userid, deviceid order by ts) as next_query
from query

update query
set is_final = case 
	when t.next_ts is null or (t.next_ts - t.ts) > 180 then 1
	when (t.next_ts - t.ts) > 60 and length(t.next_query) < length(t.query) then 2
	else 0
end
from tempr t
where query.searchid = t.searchid

select *
from query
where devicetype = 'android' and (is_final = 1 or is_final = 2) and year = 2024 and month = 11 and day = 8
