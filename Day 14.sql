with json_array as (
select
	record_id,
    record_date,
    jsonb_array_elements(cleaning_receipts) as receipts
from santarecords
)

select
	receipts ->> 'garment' as garment,
    receipts ->> 'color' as color,
    receipts ->> 'drop_off' as drop_off_date
from json_array
where 
	receipts ->> 'garment' = 'suit'
    and
    receipts ->> 'color' = 'green'
order by receipts ->> 'drop_off' desc
;