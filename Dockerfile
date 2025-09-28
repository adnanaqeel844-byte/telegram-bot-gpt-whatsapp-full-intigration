FROM python:3.11-slim
WORKDIR /app
RUN apt-get update && apt-get install -y curl ffmpeg build-essential && rm -rf /var/lib/apt/lists/*
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
EXPOSE 5000
HEALTHCHECK --interval=30s --timeout=10s --retries=3 CMD curl -f http://localhost:5000/healthz || exit 1
VOLUME ["/app/logs", "/app/data", "/app/backups"]
CMD ["python", "bot.py"]