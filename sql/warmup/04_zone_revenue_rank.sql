WITH zone_revenue AS (
  SELECT PULocationID AS zone,
         SUM(base_passenger_fare) AS revenue
  FROM 'fhvhv_tripdata_2024-01.parquet'
  GROUP BY 1
)
SELECT zone,
       revenue,
       RANK() OVER (ORDER BY revenue DESC) AS revenue_rank
FROM zone_revenue
ORDER BY revenue_rank;
