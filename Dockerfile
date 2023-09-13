FROM python:3.10-slim

WORKDIR server

COPY ./requirements.txt .

RUN apt-get update \
    && apt-get install gcc -y \
    && apt-get clean

RUN pip install -r requirements.txt \
    && rm -rf /root/.cache/pip

COPY . .

WORKDIR ../

CMD ["uvicorn", "server.main:app", "--proxy-headers", "--host", "0.0.0.0", "--port", "80"]
