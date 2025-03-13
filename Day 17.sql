with utc_time as (
select
	workshop_id,
    workshop_name,
    timezone,
    business_start_time,
    business_start_time + (business_start_time - (business_start_time at time zone timezone)::time)::interval as utc_start_time
FROM workshops
)

select *
from utc_time
where utc_start_time > '09:00:00'
order by utc_start_time desc
;