import os
import pickle

import mlflow.pyfunc
import numpy as np
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel

import mlflow

app = FastAPI(title="Forecast-o-matic API")

MLFLOW_TRACKING_URI = os.getenv("MLFLOW_TRACKING_URI", "http://mlflow:5000")
mlflow.set_tracking_uri(MLFLOW_TRACKING_URI)

# Modèle global
model = None


# Schéma d’entrée
class ForecastInput(BaseModel):
    features: list[float]


# Endpoint pour recharger un modèle depuis MLflow
@app.post("/reload-model")
def reload_model(model_name: str, stage: str = "Production"):
    global model
    try:
        model_uri = f"models:/{model_name}/{stage}"
        model = mlflow.pyfunc.load_model(model_uri)
        return {"message": f"Modèle '{model_name}' rechargé depuis le stage '{stage}'"}
    except Exception as e:
        raise HTTPException(
            status_code=500, detail=f"Erreur de chargement du modèle : {str(e)}"
        )


# Endpoint de prédiction
@app.post("/predict")
def predict(input: ForecastInput):
    if model is None:
        raise HTTPException(status_code=500, detail="Aucun modèle chargé")

    X = np.array(input.features).reshape(1, -1)
    prediction = model.predict(X).tolist()
    return {"prediction": prediction}


# Endpoint pour lister les modèles disponibles
@app.get("/models")
def list_models():
    try:
        client = mlflow.tracking.MlflowClient()
        registered_models = client.list_registered_models()
        return {
            "models": [
                {
                    "name": m.name,
                    "latest_versions": [
                        {
                            "version": v.version,
                            "stage": v.current_stage,
                            "status": v.status,
                        }
                        for v in m.latest_versions
                    ],
                }
                for m in registered_models
            ]
        }
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
