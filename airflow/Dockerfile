# airflow/Dockerfile
FROM apache/airflow:slim-3.0.4-python3.12

USER root

# Installer les extras nécessaires + MLflow + FastAPI
RUN pip install --no-cache-dir \
    apache-airflow[mlflow,http]==3.0.4 \
    mlflow \
    fastapi \
    uvicorn \
    requests

# Copier les DAGs
COPY airflow/dags /opt/airflow/dags

# Revenir à l'utilisateur airflow
USER airflow
