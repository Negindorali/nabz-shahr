import duckdb

duckdb.sql("DESCRIBE SELECT * FROM 'fhvhv_tripdata_2024-01.parquet'").df().to_csv(
    "../../docs/schema.csv", index=False
)


with open("../../docs/anomalies.sql") as f:
    duckdb.sql(f.read()).show()


with open("../../docs/zone_checks.sql") as f:
    duckdb.sql(f.read()).show()


with open("../../docs/final_checks.sql") as f:
    queries = f.read().split(";")

for q in queries:
    if q.strip():
        duckdb.sql(q).show()
