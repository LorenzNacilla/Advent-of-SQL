SELECT
	C.NAME AS CHILD_NAME,
    G.NAME AS TOY_NAME,
    G.PRICE
FROM
	CHILDREN AS C
INNER JOIN GIFTS AS G ON C.CHILD_ID = G.CHILD_ID
WHERE
	PRICE > (SELECT
            	AVG(PRICE)
            FROM
             	GIFTS
            )
ORDER BY
	G.PRICE ASC
