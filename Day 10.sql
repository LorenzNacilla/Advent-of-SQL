create EXTENSION IF NOT EXISTS tablefunc;

select
	*
from
	crosstab(
      '
      select
      	DATE,
      	DRINK_NAME,
      	sum(QUANTITY) as SUMMED_QUANTITY
      from
      	DRINKS
      group by
      	1, 2
      order by
      	1, 2
      ',
      '
      select distinct
      	DRINK_NAME
      from
      	DRINKS
      where
      	DRINK_NAME in (''Eggnog'', ''Hot Cocoa'', ''Peppermint Schnapps'')
      order by
      	1
      '
    ) AS DRINK_QUANTITY_DATES (Date date, "Eggnog" int, "Hot Cocoa" int, "Peppermint Schnapps" int )
where
	"Hot Cocoa" = 38
    and
    "Peppermint Schnapps" = 298
    and
    "Eggnog" = 198