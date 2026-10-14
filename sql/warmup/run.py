import duckdb

with open("01_daily_trips.sql") as f:
    query = f.read()

with open("02_busiest_hour_per_zone.sql") as f:
    query2 = f.read()

with open("03_revenue_7day_moving_avg.sql") as f:
    query3 = f.read()

with open("04_zone_revenue_rank.sql") as f:
    query4 = f.read()

with open("05_gap_between_trips.sql") as f:
    query5 = f.read()

with open("06_top_routes.sql") as f:
    query6 = f.read()

with open("07_avg_tip_by_hour.sql") as f:
    query7 = f.read()

with open("08_cumulative_revenue.sql") as f:
    query8 = f.read()

with open("09_zones_above_average.sql") as f:
    query9 = f.read()

with open("10_longest_trips.sql") as f:
    query10 = f.read()


duckdb.sql(query).show()
duckdb.sql(query2).show()
duckdb.sql(query3).show()
duckdb.sql(query4).show()
duckdb.sql(query5).show()
duckdb.sql(query6).show()
duckdb.sql(query7).show()
duckdb.sql(query8).show()
duckdb.sql(query9).show()
duckdb.sql(query10).show()
