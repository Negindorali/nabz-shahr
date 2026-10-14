WITH daily AS (
  SELECT DATE(pickup_datetime) AS day,
         SUM(base_passenger_fare) AS revenue
  FROM 'fhvhv_tripdata_2024-01.parquet'
  GROUP BY 1
)
SELECT day,
       revenue,
       SUM(revenue) OVER (
         ORDER BY day
         ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
       ) AS cumulative_revenue
FROM daily
ORDER BY day;
