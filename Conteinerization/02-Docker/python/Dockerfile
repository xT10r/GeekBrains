FROM python:3.9.6-slim

ADD . /app
WORKDIR /app

RUN \
pip install --upgrade pip && \
pip install -r /app/requirements.txt

EXPOSE 8080

ENTRYPOINT python /app/app.py runserver 0.0.0.0:8080
