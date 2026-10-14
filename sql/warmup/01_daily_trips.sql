SELECT DATE(pickup_datetime) AS day,
       COUNT(*) AS trips
FROM 'fhvhv_tripdata_2024-01.parquet'
GROUP BY 1
ORDER BY 1;
