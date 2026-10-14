WITH zone_daily AS (
  SELECT PULocationID AS zone,
         DATE(pickup_datetime) AS day,
         SUM(base_passenger_fare) AS revenue
  FROM 'fhvhv_tripdata_2024-01.parquet'
  GROUP BY 1, 2
),
zone_avg AS (
  SELECT zone,
         AVG(revenue) AS avg_daily_revenue
  FROM zone_daily
  GROUP BY 1
),
overall AS (
  SELECT AVG(avg_daily_revenue) AS overall_avg
  FROM zone_avg
)
SELECT z.zone,
       z.avg_daily_revenue,
       o.overall_avg
FROM zone_avg z
CROSS JOIN overall o
WHERE z.avg_daily_revenue > o.overall_avg
ORDER BY z.avg_daily_revenue DESC;
