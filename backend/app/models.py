from typing import Literal

from pydantic import BaseModel, Field


class DeviceRegistration(BaseModel):
    user_id: str = Field(min_length=1, max_length=100)
    token: str = Field(min_length=8, max_length=2048)
    platform: Literal["android", "ios", "web"]


class NotificationRequest(BaseModel):
    user_id: str = Field(min_length=1, max_length=100)
    title: str = Field(min_length=1, max_length=120)
    body: str = Field(min_length=1, max_length=500)
    route: str = Field(default="/", max_length=200)
    entity_id: str | None = Field(default=None, max_length=100)


class NotificationResult(BaseModel):
    delivered: int
    provider: str
