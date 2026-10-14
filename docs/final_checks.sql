SELECT DOLocationID, COUNT(*) AS records
FROM 'fhvhv_tripdata_2024-01.parquet'
WHERE DOLocationID IN (264, 265)
GROUP BY 1;

SELECT COUNT(*) AS only_one_is_null
FROM 'fhvhv_tripdata_2024-01.parquet'
WHERE (originating_base_num IS NULL) <> (on_scene_datetime IS NULL);
