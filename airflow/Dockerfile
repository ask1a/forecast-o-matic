# airflow/Dockerfile
FROM apache/airflow:2.8.1-python3.12

USER root
RUN pip install requests

COPY ./airflow/dags /opt/airflow/dags

USER airflow

