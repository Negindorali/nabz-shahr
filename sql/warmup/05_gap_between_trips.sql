WITH sample AS (
  SELECT dispatching_base_num AS base,
         pickup_datetime
  FROM 'fhvhv_tripdata_2024-01.parquet'
  WHERE dispatching_base_num = 'B03404'
),
with_prev AS (
  SELECT base,
         pickup_datetime,
         LAG(pickup_datetime) OVER (
           PARTITION BY base
           ORDER BY pickup_datetime
         ) AS prev_pickup
  FROM sample
)
SELECT base,
       pickup_datetime,
       prev_pickup,
       DATE_DIFF('second', prev_pickup, pickup_datetime) AS gap_seconds
FROM with_prev
WHERE prev_pickup IS NOT NULL
ORDER BY pickup_datetime
LIMIT 100;
