FROM python:3.10-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

ENV FLASK_APP=crudapp.py

RUN flask db init && flask db migrate -m "entries table" && flask db upgrade

EXPOSE 5000

CMD ["flask", "run", "--host=0.0.0.0"]