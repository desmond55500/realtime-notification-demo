from collections import defaultdict

from fastapi import FastAPI, HTTPException, status

from .models import DeviceRegistration, NotificationRequest, NotificationResult
from .push import MockPushProvider

app = FastAPI(
    title="Realtime Notification Demo",
    version="1.0.0",
    description="Public-safe push notification architecture demo.",
)

_devices: dict[str, dict[str, DeviceRegistration]] = defaultdict(dict)
_provider = MockPushProvider()


@app.get("/health")
def health():
    return {"status": "ok"}


@app.post("/devices", status_code=status.HTTP_201_CREATED)
def register_device(payload: DeviceRegistration):
    _devices[payload.user_id][payload.token] = payload
    return {
        "registered": True,
        "user_id": payload.user_id,
        "platform": payload.platform,
    }


@app.delete("/devices/{user_id}/{token}")
def unregister_device(user_id: str, token: str):
    user_devices = _devices.get(user_id, {})
    removed = user_devices.pop(token, None)

    if removed is None:
        raise HTTPException(status_code=404, detail="Device token not found.")

    return {"removed": True}


@app.post("/notifications/send", response_model=NotificationResult)
async def send_notification(payload: NotificationRequest):
    tokens = list(_devices.get(payload.user_id, {}).keys())

    if not tokens:
        raise HTTPException(status_code=404, detail="No registered devices for user.")

    delivered = 0
    for token in tokens:
        if await _provider.send(token, payload):
            delivered += 1

    return NotificationResult(delivered=delivered, provider=_provider.name)
