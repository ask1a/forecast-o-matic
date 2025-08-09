# Makefile pour forecast-o-matic

ENV_NAME=venvforecast

.PHONY: install clean run-api jupyter mlflow format lint test quality-check docker-up-status docker-down

install:
	@echo "Création de l'environnement virtuel '$(ENV_NAME)'..."
	python3 -m venv $(ENV_NAME)
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

format:
	black .
	isort .

lint:
	flake8 .

test:
	pytest --cov=src --cov-report=term-missing

quality-check: format lint test

docker-down:
	@echo "Arrêt des containers..."
	docker-compose down

docker-up-status:
	@echo "Lancement des services en mode détaché avec build..."
	docker-compose up --build -d
	@echo "État des services :"
	docker-compose ps
	@echo "Vérification des services exposés :"
	@docker-compose config | awk '
        /^[^[:space:]]/ {service=$$1}
        /ports:/ {show=1; next}
        show && /^[[:space:]]*-"[0-9]+:[0-9]+"/ {
            gsub(/"/, "", $$0);
            split($$0, p, ":");
            url="http://localhost:" p[1];
            printf "→ %s sur %s : ", service, url;
            cmd="curl -s -o /dev/null -w \"%{http_code}\" " url;
            cmd | getline code;
            close(cmd);
            if (code == "200") {
                print "✅ OK";
            } else {
                print "❌ KO (HTTP " code ")";
            }
        }
        /^[^[:space:]]/ {show=0}
	'
