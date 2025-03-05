with requests_count_percent_rank as (
select
	gifts.gift_name,
    count(gift_requests.gift_id) as requests,
    round(cast(percent_rank() over(order by count(gift_requests.gift_id)) as numeric), 2) as percent_rank
from gifts
inner join gift_requests using (gift_id)
group by 1
),

percent_rank_dense_rank as (
select
	gift_name,
    percent_rank,
    dense_rank() over(order by percent_rank desc) as rank
from requests_count_percent_rank
),

percent_rank_dense_rank_sorted as (
select
	gift_name,
  	percent_rank,
  	rank,
    row_number() over(partition by rank order by percent_rank desc, gift_name asc) as rn
from percent_rank_dense_rank
)

select
	gift_name,
    percent_rank
from percent_rank_dense_rank_sorted
where 
	rank = 2
	and
    rn = 1
;