# نبض شهر (Nabz-e Shahr)

پلتفرم داده‌ی لحظه‌ای و دسته‌ای برای سفرهای تاکسی اینترنتی، روی داده‌ی عمومی NYC TLC.
شرح کامل پروژه و تیکت‌ها: [`docs/project-brief.html`](docs/project-brief.html)

> این README موقت است. در تیکت NBZ-802 آن را به انگلیسی و کامل بازنویسی کن.

## شروع کار

```bash
source .venv/bin/activate      # فعال کردن محیط پایتون
cp .env.example .env           # و بعد مقدارها را عوض کن
```

## بالا آوردن سرویس‌ها

همه‌ی دستورها از ریشه‌ی پروژه اجرا می‌شوند. چون فایل compose در `infra/` است، `--env-file .env` لازم است.

```bash
docker compose -f infra/docker-compose.yml --env-file .env up -d     # بالا آوردن
docker compose -f infra/docker-compose.yml --env-file .env down      # پایین آوردن (داده می‌ماند)
docker compose -f infra/docker-compose.yml --env-file .env down -v   # پایین آوردن و پاک کردن داده
```

| سرویس | آدرس | ورود |
|---|---|---|
| MinIO S3 API | http://localhost:9000 | `MINIO_ROOT_USER` / `MINIO_ROOT_PASSWORD` از `.env` |
| کنسول MinIO | http://localhost:9001 (پورت: `MINIO_CONSOLE_PORT`) | همان |

### MinIO (NBZ-101)

- داده در volume به نام `minio-data` می‌ماند و با `down` و `up` پاک نمی‌شود.
- سرویس `minio-init` با هر `up` یک‌بار اجرا می‌شود، bucketهای `landing` و `lake` را اگر نباشند می‌سازد و خارج می‌شود.
- رمز root فقط موقع ساخته شدن volume اعمال می‌شود. اگر آن را در `.env` عوض کردی، یک‌بار `down -v` بزن.
- ایمیج رسمی `minio/minio` و `minio/mc` از Docker Hub و quay.io حذف شده‌اند. به‌جای آن‌ها از `pgsty/minio` و `pgsty/mc` استفاده می‌شود که build جامعه از همان کد است.

### گرفتن ایمیج‌ها از ایران

Docker Hub موقع دانلود لایه‌ها `403 Forbidden` می‌دهد. یک‌بار mirror را تنظیم کن:

```bash
echo '{ "registry-mirrors": ["https://docker.arvancloud.ir"] }' | sudo tee /etc/docker/daemon.json
sudo systemctl restart docker
```

بعد از آن `pull` عادی کار می‌کند:

```bash
docker compose -f infra/docker-compose.yml --env-file .env pull
```

mirrorهای جایگزین: `hub.hamdocker.ir`، `registry.docker.ir`، `docker.iranserver.com`.

