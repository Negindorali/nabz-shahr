WITH hourly AS (SELECT PULocationID AS zone, EXTRACT (hour FROM pickup_datetime) AS hr, COUNT (*) AS trips
FROM 'fhvhv_tripdata_2024-01.parquet'
GROUP BY 1, 2
  ),

  ranked AS (
SELECT zone, hr, trips, ROW_NUMBER() OVER (PARTITION BY zone ORDER BY trips DESC) AS rn
FROM hourly
  )
SELECT zone, hr, trips
FROM ranked
WHERE rn = 1
ORDER BY trips DESC;
