with season_number_cte as (
select distinct
    season,
    case
    	when season = 'Spring' then 1
        when season = 'Summer' then 2
        when season = 'Fall' then 3
        when season = 'Winter' then 4
	end as season_number
from TreeHarvests
)

select
    round(avg(TreeHarvests.trees_harvested) over(partition by TreeHarvests.field_name order by TreeHarvests.harvest_year asc, season_number_cte.season_number asc rows between 2 preceding and current row), 2) as three_season_moving_average
from TreeHarvests
join season_number_cte using (season)
order by three_season_moving_average desc
limit 1
;