with unnested as (
select
    unnest(email_addresses) as email,
    split_part(unnest(email_addresses), '@', 2) as domain
from contact_list
),

count_of_emails as (
select
	domain,
    count(email) as email_count
from unnested
group by 1
),

array_list as (
select
	domain,
    array_agg(email) as users
from unnested
group by 1
)

select
	count_of_emails.domain,
    count_of_emails.email_count,
    array_list.users
from count_of_emails
join array_list using (domain)
order by count_of_emails.email_count desc
;