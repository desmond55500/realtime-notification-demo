from fastapi.testclient import TestClient

from app.main import app

client = TestClient(app)


def test_register_and_send_notification():
    register = client.post(
        "/devices",
        json={
            "user_id": "demo-user",
            "token": "demo-token-12345",
            "platform": "android",
        },
    )
    assert register.status_code == 201

    sent = client.post(
        "/notifications/send",
        json={
            "user_id": "demo-user",
            "title": "Order update",
            "body": "Your order is on the way.",
            "route": "/orders/detail",
            "entity_id": "order-42",
        },
    )
    assert sent.status_code == 200
    assert sent.json()["delivered"] == 1
    assert sent.json()["provider"] == "mock"


def test_send_requires_registered_device():
    response = client.post(
        "/notifications/send",
        json={
            "user_id": "missing-user",
            "title": "Hello",
            "body": "World",
            "route": "/",
        },
    )
    assert response.status_code == 404
