FROM python:3.12-slim

WORKDIR /app

# فقط پکیج‌های سیستمی لازم برای build چرخ‌دنده‌های بومی (uvloop/httptools)، نه کل toolchain
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

ENV PORT=8000
EXPOSE 8000

CMD ["sh", "-c", "uvicorn main:app --host 0.0.0.0 --port ${PORT}"]
