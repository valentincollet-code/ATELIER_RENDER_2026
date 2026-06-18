from flask import Flask
import os

app = Flask(__name__)

@app.route("/")
def home():
    return "Flask + Docker + GHCR + Terraform + Render"

@app.route("/health")
def health():
    return {"status": "Tout est ok ou pas"}

@app.route("/info")
def info():
    return {
        "app": "Flask Render",
        "student": "Valentin COLLET",
        "version": "v1"
    }

@app.route("/env")
def env():
    return {"env": os.getenv("ENV")}
    
if __name__ == "__main__":
    port = int(os.environ.get("PORT", 10000))
