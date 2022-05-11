SELECT S.TITLE, Reprint_count
FROM GCD_STORY S, (
    SELECT S.ID, COUNT(*) AS Reprint_count
    FROM GCD_STORY S, GCD_STORY_REPRINT SR
    WHERE S.ID=SR.ORIGIN_ID
    GROUP BY S.ID
    HAVING COUNT(*)>=30
    ORDER BY Reprint_count DESC
) ID_TO_COUNT
WHERE S.ID=ID_TO_COUNT.ID