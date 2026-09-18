from dataclasses import dataclass
from typing import Protocol

from .models import NotificationRequest


class PushProvider(Protocol):
    async def send(self, token: str, notification: NotificationRequest) -> bool:
        ...


@dataclass
class MockPushProvider:
    name: str = "mock"

    async def send(self, token: str, notification: NotificationRequest) -> bool:
        # A real Firebase implementation would map the typed payload to
        # firebase_admin.messaging.Message and send it here.
        return bool(token and notification.title)
