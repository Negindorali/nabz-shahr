SELECT 'pickup_not_in_lookup' AS check_name,
       COUNT(*) AS records
FROM 'fhvhv_tripdata_2024-01.parquet' t
LEFT JOIN 'taxi_zone_lookup.csv' z ON t.PULocationID = z.LocationID
WHERE z.LocationID IS NULL
UNION ALL
SELECT 'dropoff_not_in_lookup', COUNT(*)
FROM 'fhvhv_tripdata_2024-01.parquet' t
LEFT JOIN 'taxi_zone_lookup.csv' z ON t.DOLocationID = z.LocationID
WHERE z.LocationID IS NULL
UNION ALL
SELECT 'pickup_unknown_zone', COUNT(*)
FROM 'fhvhv_tripdata_2024-01.parquet'
WHERE PULocationID IN (264, 265)
UNION ALL
SELECT 'dropoff_unknown_zone', COUNT(*)
FROM 'fhvhv_tripdata_2024-01.parquet'
WHERE DOLocationID IN (264, 265);
