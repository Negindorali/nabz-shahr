SELECT PULocationID AS pickup_zone,
       DOLocationID AS dropoff_zone,
       COUNT(*) AS trips
FROM 'fhvhv_tripdata_2024-01.parquet'
GROUP BY 1, 2
ORDER BY trips DESC
LIMIT 10;
