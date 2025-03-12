select
    a.place_name,
    sl.timestamp
from areas as a
join sleigh_locations as sl on st_contains(a.polygon::geometry, sl.coordinate::geometry)
;
