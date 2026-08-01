import os
import sys

# make the app package importable when running from repo root
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from app import app as flask_app


def test_app_imports():
    """Confirms the Flask app object builds without crashing on import."""
    assert flask_app is not None


def test_index_route_returns_200():
    """Confirms the home page route responds successfully."""
    flask_app.config["TESTING"] = True
    client = flask_app.test_client()
    response = client.get("/")
    assert response.status_code == 200
