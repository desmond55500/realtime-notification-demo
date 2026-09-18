# Realtime Notification Demo

A public-safe full-stack demo showing how a Flutter client and FastAPI backend can model device registration, push delivery, notification payloads, and deep-link routing.

This repository is independent portfolio work. It contains no company code, production credentials, Firebase service-account files, or private endpoints.

## What it demonstrates

- Flutter notification-state handling
- Device-token registration flow
- Typed notification payloads
- Deep-link style routing from notification data
- FastAPI request validation
- Provider abstraction for push delivery
- Mock push provider for safe local testing
- Backend tests
- Separate Flutter and Python CI jobs

## Architecture

```text
Flutter app
   |
   | register device token
   v
FastAPI /devices
   |
   | notification request
   v
FastAPI /notifications/send
   |
   v
PushProvider interface
   |
   +--> MockPushProvider (this demo)
   +--> FirebasePushProvider (production implementation point)
```

On the Flutter side, notification data is converted into a typed event and passed to a router. The router decides which screen should open instead of scattering navigation logic across callbacks.

## Repository layout

```text
backend/
  app/
    main.py
    models.py
    push.py
  tests/
    test_api.py
  requirements.txt
mobile/
  lib/
    main.dart
    notification_event.dart
    notification_router.dart
  test/
    notification_router_test.dart
  pubspec.yaml
```

## Backend

```bash
cd backend
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
uvicorn app.main:app --reload
```

Swagger: http://127.0.0.1:8000/docs

## Flutter

```bash
cd mobile
flutter pub get
flutter test
flutter run
```

If platform folders are missing, run `flutter create .` once inside `mobile/`.

## Production integration

A real deployment would implement the `PushProvider` interface with Firebase Admin SDK, store device tokens in PostgreSQL, authenticate registration requests, rotate stale tokens, and use environment-managed service credentials.

The demo intentionally keeps those pieces replaceable and excludes real secrets.
