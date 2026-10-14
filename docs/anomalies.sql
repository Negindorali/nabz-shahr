SELECT 'negative_fare' AS anomaly,
       COUNT(*)        AS records
FROM 'fhvhv_tripdata_2024-01.parquet'
WHERE base_passenger_fare < 0
UNION ALL
SELECT 'negative_driver_pay', COUNT(*)
FROM 'fhvhv_tripdata_2024-01.parquet'
WHERE driver_pay < 0
UNION ALL
SELECT 'zero_trip_time', COUNT(*)
FROM 'fhvhv_tripdata_2024-01.parquet'
WHERE trip_time = 0
UNION ALL
SELECT 'zero_trip_miles', COUNT(*)
FROM 'fhvhv_tripdata_2024-01.parquet'
WHERE trip_miles = 0
UNION ALL
SELECT 'dropoff_before_pickup', COUNT(*)
FROM 'fhvhv_tripdata_2024-01.parquet'
WHERE dropoff_datetime < pickup_datetime
UNION ALL
SELECT 'trip_longer_than_6h', COUNT(*)
FROM 'fhvhv_tripdata_2024-01.parquet'
WHERE trip_time > 6 * 3600
UNION ALL
SELECT 'trip_over_100_miles', COUNT(*)
FROM 'fhvhv_tripdata_2024-01.parquet'
WHERE trip_miles > 100
UNION ALL
SELECT 'trip_time_mismatch', COUNT(*)
FROM 'fhvhv_tripdata_2024-01.parquet'
WHERE ABS(DATE_DIFF('second', pickup_datetime, dropoff_datetime) - trip_time) > 60;
