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
####  Fonctions : clarté et responsabilité unique
Responsabilité unique : chaque fonction doit accomplir une seule tâche bien définie.  
Nom explicite : commence toujours le nom d’une fonction par un verbe d’action décrivant ce qu’elle fait.  
✅ load_data(), train_model(), evaluate_forecast()  
❌ data(), stuff(), do_things()  

###  Classes
- `PascalCase` pour les classes (`TimeSeriesModel`, `DataPreprocessor`)

###  Modèles et artefacts
- Nom du modèle : `model_<nom>_<horodatage>.pkl`
- Expériences MLflow : `exp_<nom_du_dataset>_<modèle>`


Ces conventions facilitent la lecture, la collaboration et l’automatisation dans les pipelines.

---

## Utilisation du Makefile
Ce projet inclut un Makefile pour simplifier les tâches courantes. Assure-toi d’être dans le dossier racine (forecast-o-matic/) avant d’exécuter les commandes suivantes :
### Créer l’environnement virtuel et installer les dépendances
`make install`

### Nettoyer les fichiers temporaires et l’environnement
`make clean`

### Lancer l’API FastAPI
`make run-api`

### Ouvrir Jupyter Notebook
`make jupyter`

### Démarrer l’interface MLflow
`make mlflow`

---

##  Installation
Sur WSL installer avant make, venv dans la version python (ici 3.12) et compilateur nécessaire (aarch64-linux-gnu-gcc):
```
sudo apt install make
sudo apt install python3.12-venv
sudo apt update
sudo apt install build-essential gcc g++ python3-dev
```

```bash
git clone https://github.com/ask1a/forecast-o-matic.git
cd forecast-o-matic
```
puis:
```
make install
source venvforecast/bin/activate
```
ou bien:
```
python -m venv venvforecast
# Sur Linux/macOS :
source venvforecast/bin/activate
# Sur Windows :
venvforecast\Scripts\activate
pip install -r requirements.txt
```

##  Démarrer un exemple

1. Lance un notebook depuis `sandbox/`
2. Entraîne un modèle avec `src/train.py`
3. Déploie l’API avec `api/main.py`
4. Suis les performances avec MLflow
5. Orchestration des données via Airflow
