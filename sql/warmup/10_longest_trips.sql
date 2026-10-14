WITH threshold AS (
  SELECT QUANTILE_CONT(trip_time, 0.95) AS p95
  FROM 'fhvhv_tripdata_2024-01.parquet'
)
SELECT t.PULocationID AS pickup_zone,
       t.DOLocationID AS dropoff_zone,
       t.trip_time,
       t.trip_miles,
       th.p95
FROM 'fhvhv_tripdata_2024-01.parquet' t
CROSS JOIN threshold th
WHERE t.trip_time > th.p95
ORDER BY t.trip_time DESC
LIMIT 100;
