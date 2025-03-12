with place_and_time as (
select
  a.place_name,
  sl.timestamp
from areas as a
join sleigh_locations as sl on st_contains(a.polygon::geometry, sl.coordinate::geometry)
),

min_max_dates as (
select
  place_name,
  min(timestamp) as min_time,
  max(timestamp) as max_time
from place_and_time
group by 1
)

select
  place_name,
  round(extract(epoch from (max_time - min_time))/3600, 2) as difference
from min_max_dates
order by round(extract(epoch from (max_time - min_time))/3600, 2) desc
;