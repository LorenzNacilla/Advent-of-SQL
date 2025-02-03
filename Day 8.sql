WITH RECURSIVE staff_hierarchy AS (
SELECT 
	staff_id, 
	staff_name, 
	manager_id,
	1 AS level,
  	CAST(staff_id AS TEXT) AS path
FROM
	staff
WHERE
  	manager_id IS NULL
UNION ALL
SELECT 
	s.staff_id, 
	s.staff_name, 
	s.manager_id,
	sh.level + 1,
  	CONCAT(sh.path, ',', s.staff_id)
 FROM staff AS s
 JOIN staff_hierarchy AS sh ON s.manager_id = sh.staff_id
)
SELECT
	*
FROM 
	staff_hierarchy
ORDER BY
	level DESC
;