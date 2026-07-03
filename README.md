# volt_ai_q (VoltIQ)

VoltIQ is a Flutter application built with **Riverpod** (state management) and **go_router** (navigation). It simulates real-time energy updates (live kW + tariff mode) and drives features like **optimization** and **alerts**.

---

## Architecture flow (end-to-end)

### 1) App bootstrap
- **Entry:** `lib/main.dart`
  - Wraps the app in `ProviderScope`.
  - After first frame, initializes the update layer:
    - `WebSocketService().init(ref.container)`

### 2) Routing + navigation gating
- **Router:** `lib/core/routing/app_router.dart`
  - `initialLocation: /login`
  - Redirect logic is driven by `authProvider`:
    - Not authenticated → force `/login`
    - Authenticated but onboarding incomplete → force `/onboarding`
    - Authenticated + onboarding complete → redirect away from `/login` and `/onboarding` to `/dashboard`
  - Authenticated pages are wrapped in a `ShellRoute` using:
    - `MainAppScaffold(child: child)`

### 3) Main UI shell
- **Shell wrapper:** `lib/ui/main_app/main_app_scaffold.dart`
  - Applies the app background.
  - Hosts the active screen (`widget.child`).
  - On mobile, shows a bottom navigation bar.
  - Always overlays:
    - `FloatingChatButton`
    - `ChatOverlay`

### 4) State + live updates
Key Riverpod state:
- `liveKWProvider` (`lib/data/providers/live_kw_provider.dart`): `StateProvider<double>`
- `tariffModeProvider` (`lib/data/providers/tariff_provider.dart`): `StateProvider<TariffMode>`
- `alertsProvider` (`lib/data/providers/alerts_provider.dart`): `StateNotifierProvider<AlertsNotifier, List<Alert>>`
- `optimizationProvider` (`lib/data/providers/optimization_provider.dart`): `StateNotifierProvider<OptimizationNotifier, OptimizationState>`

**Update source:** `lib/services/websocket_service.dart`
- Currently uses a `Timer.periodic` to mock updates.
- On each tick it can:
  - change tariff mode occasionally
  - adjust live kW continuously
  - add simulated alerts occasionally

Because screens watch these providers, the UI updates reactively.

### 5) Feature screens
- **Optimization:** `lib/ui/main_app/screens/optimization/optimization_screen.dart`
  - Triggers `runOptimization()` on first frame.
  - Renders:
    - loading/pipeline while `OptimizationLoading`
    - results when `OptimizationLoaded`

- **Alerts:** `lib/ui/main_app/screens/alerts/alerts_screen.dart`
  - Watches `alertsProvider`.
  - Shows unread count.
  - Supports:
    - `markAllAsRead()`
    - `markAsRead(id)`

---

## Tech stack
- Flutter
- Riverpod (`flutter_riverpod`)
- go_router
- WebSocket dependency present in `pubspec.yaml` (service currently mocked)
- Other notable libraries:
  - `dio`, `http`
  - `hive`
  - `fl_chart`
  - `flutter_local_notifications`

---

## Getting started

### Prerequisites
- Flutter SDK installed
- Platform tooling for your target (Android Studio / Xcode / web browser)

### Install dependencies
```bash
flutter pub get
```

### Run
```bash
flutter run
```

(Optional web)
```bash
flutter run -d chrome
```

---

## Current status
See `TODO.md` for the active checklist. Notable pending items include:
- missing landing widgets
- router/provider/model fixes needed for compilation
- UI syntax/deprecation fixes

---

## Repository structure (high-signal)
- `lib/core/routing/` → `app_router.dart`
- `lib/services/` → `websocket_service.dart`, API/chat/notification/storage services
- `lib/data/providers/` → Riverpod providers for auth, live updates, alerts, optimization
- `lib/ui/main_app/screens/` → feature screens (dashboard, optimization, alerts, etc.)

