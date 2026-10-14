# Data Contract: FHVHV Trip Records (January 2024)

**Source:** NYC TLC Trip Record Data، `fhvhv_tripdata_2024-01.parquet`
**Rows:** 19,663,930
**Lookup:** `taxi_zone_lookup.csv` (265 rows, LocationID 1–265)

## 1. Schema, معنی و قواعد اعتبار

| Column | Type | Null % | معنی | قاعده‌ی اعتبار |
|--------|------|--------|------|----------------|
| hvfhs_license_num | VARCHAR | 0 | شناسه‌ی مجوز شرکت (Uber/Lyft/...) | not null |
| dispatching_base_num | VARCHAR | 0 | پایگاه اعزام‌کننده‌ی سفر | not null |
| originating_base_num | VARCHAR | 26.54 | پایگاه مبدأ درخواست | nullable؛ همیشه همراه on_scene_datetime null می‌شود |
| request_datetime | TIMESTAMP | 0 | زمان درخواست مسافر | not null؛ ≤ pickup_datetime |
| on_scene_datetime | TIMESTAMP | 26.54 | زمان رسیدن راننده به محل | nullable؛ همراه originating_base_num |
| pickup_datetime | TIMESTAMP | 0 | زمان سوار شدن | not null؛ داخل ژانویه ۲۰۲۴ |
| dropoff_datetime | TIMESTAMP | 0 | زمان پیاده شدن | not null؛ ≥ pickup_datetime |
| PULocationID | INTEGER | 0 | منطقه‌ی سوار شدن | در lookup باشد (۱–۲۶۵) |
| DOLocationID | INTEGER | 0 | منطقه‌ی پیاده شدن | در lookup باشد (۱–۲۶۵) |
| trip_miles | DOUBLE | 0 | مسافت سفر (مایل) | ≥ 0 |
| trip_time | BIGINT | 0 | مدت سفر (ثانیه) | > 0 |
| base_passenger_fare | DOUBLE | 0 | کرایه‌ی پایه (دلار) | ≥ 0 |
| tolls | DOUBLE | 0 | عوارض | ≥ 0 |
| bcf | DOUBLE | 0 | عوارض صندوق Black Car | ≥ 0 |
| sales_tax | DOUBLE | 0 | مالیات فروش | ≥ 0 |
| congestion_surcharge | DOUBLE | 0 | هزینه‌ی ازدحام | ≥ 0 |
| airport_fee | DOUBLE | 0 | هزینه‌ی فرودگاه | ≥ 0 |
| tips | DOUBLE | 0 | انعام | ≥ 0 |
| driver_pay | DOUBLE | 0 | پرداخت به راننده | ≥ 0 |
| shared_request_flag | VARCHAR | 0 | مسافر درخواست سفر اشتراکی داد؟ (Y/N) | Y یا N |
| shared_match_flag | VARCHAR | 0 | سفر واقعاً اشتراکی شد؟ (Y/N) | Y یا N |
| access_a_ride_flag | VARCHAR | 0 | سفر برای برنامه‌ی MTA Access-A-Ride؟ | Y یا N |
| wav_request_flag | VARCHAR | 0 | درخواست خودروی ویژه‌ی ویلچر | Y یا N |
| wav_match_flag | VARCHAR | 0 | خودروی ویلچری تخصیص داده شد؟ | Y یا N |

## 2. ناهنجاری‌ها

| ناهنجاری | قاعده‌ی نقض‌شده | تعداد رکورد |
|----------|-----------------|-------------|
| کرایه‌ی منفی | base_passenger_fare ≥ 0 | 191 |
| پرداخت منفی به راننده | driver_pay ≥ 0 | 137 |
| سفر با مدت صفر | trip_time > 0 | 2 |
| سفر با مسافت صفر | trip_miles ≥ 0 و معنی‌دار | 3,286 |
| سفر بیش از ۶ ساعت | trip_time ≤ 6h | 90 |
| سفر بیش از ۱۰۰ مایل | trip_miles ≤ 100 | 1,660 |
| پیاده‌شدن قبل از سوارشدن | dropoff ≥ pickup | 0 |
| ناسازگاری trip_time با اختلاف زمان‌ها | اختلاف ≤ 60 ثانیه | 0 |
| شناسه‌ی منطقه‌ی مبدأ نامعتبر | PULocationID در lookup | 0 |
| شناسه‌ی منطقه‌ی مقصد نامعتبر | DOLocationID در lookup | 0 |

## 3. رابطه با taxi_zone_lookup.csv

- `PULocationID` و `DOLocationID` کلید خارجی (foreign key) به `LocationID` در lookup هستند (رابطه‌ی چند-به-یک).
- نوع‌ها فرق دارند (INTEGER در مقابل BIGINT)، ولی join بدون مشکل کار می‌کند.
- هر ۲۶۵ شناسه‌ی سفرها در lookup وجود دارد (۰ شناسه‌ی نامعتبر).
- `LocationID = 265` یعنی «Unknown». مبدأ: 765 سفر، مقصد: 741,161 سفر (≈ 3.8%). `264` در مقصدها وجود ندارد.

## 4. نکات و تصمیم‌ها

- هیچ ستونی در Parquet به‌صورت NOT NULL تعریف نشده؛ قواعد بالا از اینجا می‌آیند.
- `airport_fee` و سایر هزینه‌ها صفر یعنی «بدون هزینه»، نه «نامعلوم».
- سفرهای با کرایه‌ی منفی احتمالاً بازپرداخت/اصلاحیه‌اند؛ در تحلیل درآمد باید حذف یا جدا شوند (تصمیم نهایی: ...).
