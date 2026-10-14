WITH daily AS (
  SELECT DATE(pickup_datetime) AS day,
         SUM(base_passenger_fare) AS revenue
  FROM 'fhvhv_tripdata_2024-01.parquet'
  GROUP BY 1
)
SELECT day,
       revenue,
       AVG(revenue) OVER (
         ORDER BY day
         ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
       ) AS moving_avg_7d
FROM daily
ORDER BY day;
