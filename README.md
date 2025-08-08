#  forecast-o-matic

**Cadre modulaire pour la prévision de séries temporelles**, conçu pour les data scientists qui veulent aller vite, bien, et avec un style de malade.

---

##  Objectif

Ce projet propose une architecture complète pour :
- Créer et tester des modèles de prévision (forecast)
- Déployer une API de prédiction (FastAPI)
- Suivre les modèles avec MLflow
- Prototyper dans un bac à sable de notebooks
- Orchestrer les flux de données avec Airflow

---

##  Structure du projet
forecast-o-matic/  
├── api/           # API de prédiction (FastAPI)  
├── airflow/       # Pipelines ETL (DAGs Airflow)  
├── mlflow/        # Suivi des modèles et expériences  
├── sandbox/       # Prototypes et notebooks exploratoires  
├── src/           # Code source des modèles  
├── data/          # Données d'exemple  
├── requirements.txt  
└── README.md  

##  Technologies utilisées

- **Python** (forecasting, ML, API)
- **FastAPI** (serveur de prédiction)
- **MLflow** (tracking des modèles)
- **Airflow** (orchestration ETL)
- **Jupyter Notebooks** (prototypage)
- **Docker** (containerisation)

##  Conventions de nommage

Pour assurer la clarté et la cohérence du code, le projet suit les conventions suivantes :

###  Dossiers et fichiers
- `snake_case` pour les noms de fichiers Python (`train_model.py`, `data_loader.py`)
- `kebab-case` pour les noms de dossiers techniques (`just-a-steack/`, `airflow/`)
- Préfixes explicites : `api_`, `dag_`, `model_`, `utils_`

###  Variables et fonctions
- `snake_case` pour les variables et fonctions (`train_model`, `load_data`)
- Noms descriptifs et complets (`forecast_horizon_6_days`, `raw_data_path`)
- Pas d’abréviations obscures

###  Classes
- `PascalCase` pour les classes (`TimeSeriesModel`, `DataPreprocessor`)

###  Modèles et artefacts
- Nom du modèle : `model_<nom>_<horodatage>.pkl`
- Expériences MLflow : `exp_<nom_du_dataset>_<modèle>`


Ces conventions facilitent la lecture, la collaboration et l’automatisation dans les pipelines.

---

##  Installation

```bash
git clone https://github.com/ask1a/forecast-o-matic.git
cd forecast-o-matic
python -m venv forecast
# Sur Linux/macOS :
source forecast/bin/activate
# Sur Windows :
forecast\Scripts\activate
pip install -r requirements.txt
```

##  Démarrer un exemple

1. Lance un notebook depuis `sandbox/`
2. Entraîne un modèle avec `src/train.py`
3. Déploie l’API avec `api/main.py`
4. Suis les performances avec MLflow
5. Orchestration des données via Airflow
