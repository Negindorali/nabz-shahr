SELECT EXTRACT(hour FROM pickup_datetime) AS hr,
       AVG(tips) AS avg_tip,
       COUNT(*) AS trips
FROM 'fhvhv_tripdata_2024-01.parquet'
GROUP BY 1
ORDER BY 1;
