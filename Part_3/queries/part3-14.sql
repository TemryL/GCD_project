SELECT C.NAME AS Country_Name, P.NAME AS Publisher_Name
FROM STDDATA_COUNTRY C, GCD_PUBLISHER P, (
    SELECT COUNTRY_ID AS C_ID, ID AS P_ID, 
        ROW_NUMBER() OVER(PARTITION BY COUNTRY_ID ORDER BY Series_count DESC) AS Row_number
    FROM (
        SELECT P.ID, P.COUNTRY_ID, Series_count
        FROM GCD_PUBLISHER P, (
            SELECT PUBLISHER_ID, COUNT(*) AS Series_count
            FROM GCD_SERIES
            GROUP BY PUBLISHER_ID
        )
        WHERE P.ID=PUBLISHER_ID AND COUNTRY_ID IN (
            SELECT COUNTRY_ID
            FROM GCD_PUBLISHER
            GROUP BY COUNTRY_ID
            HAVING COUNT(*)>=200
        )
    )
)
WHERE Row_number<=2 AND C.ID=C_ID AND P.ID=P_ID;