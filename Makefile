# Makefile pour forecast-o-matic

ENV_NAME=forecast

.PHONY: install clean run-api jupyter mlflow

install:
    @echo "Création de l'environnement virtuel '$(ENV_NAME)'..."
    python -m venv $(ENV_NAME)
    @echo "Environnement créé."
    @echo "Installation des dépendances..."
    $(ENV_NAME)/bin/pip install --upgrade pip
    $(ENV_NAME)/bin/pip install -r requirements.txt
    @echo "Installation terminée."

clean:
    @echo "Nettoyage des fichiers temporaires..."
    rm -rf __pycache__ */__pycache__ *.pyc $(ENV_NAME)
    @echo "Nettoyage terminé."

run-api:
    @echo "Lancement de l'API FastAPI..."
    $(ENV_NAME)/bin/uvicorn app.main:app --reload

jupyter:
    @echo "Lancement de Jupyter Notebook..."
    $(ENV_NAME)/bin/jupyter notebook

mlflow:
    @echo "Lancement de MLflow UI..."
    $(ENV_NAME)/bin/mlflow ui
