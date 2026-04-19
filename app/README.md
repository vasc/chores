# chores (Flutter app)

Household chore tracker client — Flutter for iOS, Android, macOS.

For the big picture, see [`../README.md`](../README.md),
[`../CLAUDE.md`](../CLAUDE.md), and [`../docs/`](../docs/).

## Commands

| Command | What it does |
|---|---|
| `flutter pub get` | Fetch dependencies |
| `dart run build_runner build --delete-conflicting-outputs` | Generate typed GraphQL Dart |
| `dart run build_runner watch --delete-conflicting-outputs` | Regen on change |
| `flutter analyze` | Static analysis (must be clean) |
| `flutter test` | Widget / unit tests |
| `flutter run -d macos` | Run on macOS desktop |
| `flutter run -d ios` | Run on iOS simulator |
| `flutter run -d android` | Run on Android emulator |

## API endpoint

Defaults to `http://localhost:4000/graphql`. Override with a dart-define:

```bash
flutter run --dart-define=API_URL=http://10.0.2.2:4000/graphql     # Android emulator → host
flutter run --dart-define=API_URL=https://api.example.com/graphql  # real backend
```

## Layout

```
app/
├── pubspec.yaml
├── analysis_options.yaml
├── build.yaml                      graphql_codegen config
├── android/ ios/ macos/            Platform folders
├── test/                           Widget tests
└── lib/
    ├── main.dart                   App entry
    ├── theme.dart                  Material theme
    ├── router.dart                 go_router with auth redirects
    ├── auth/
    │   ├── auth_storage.dart       Secure storage for JWT
    │   ├── household_storage.dart  Household ID persistence
    │   └── auth_controller.dart    Riverpod session controller
    ├── client/
    │   └── graphql_client.dart     HTTP link + auth link
    ├── graphql/
    │   ├── schema.graphql          Synced from server
    │   └── operations/             *.graphql + generated *.graphql.dart
    ├── widgets/
    │   └── error_box.dart
    └── screens/
        ├── splash_screen.dart
        ├── welcome_screen.dart
        ├── adult_signup.dart
        ├── adult_login.dart
        ├── kid_picker_screen.dart
        ├── home_chores_screen.dart
        ├── chore_detail_screen.dart
        ├── rewards_screen.dart
        ├── approvals_screen.dart
        └── admin/
            └── admin_screen.dart   Tabs: Members, Chores, Rewards
```

## State and data

- **State management**: Riverpod. The `authControllerProvider` holds the
  current session and drives the router.
- **GraphQL client**: `graphql_flutter`. The client is created once in
  `graphqlClientProvider` with an auth link that reads the stored JWT
  on every request.
- **Generated types**: `graphql_codegen` reads `lib/graphql/schema.graphql`
  + every `lib/graphql/operations/*.graphql`, and emits
  `*.graphql.dart` next to each source file. Each operation produces a
  `Query$Name` / `Variables$…` class and a `documentNodeQueryName`
  `DocumentNode` constant.
- **Secure storage**: `flutter_secure_storage` persists the JWT and
  household ID. On macOS, this uses Keychain and requires the
  `com.apple.security.network.client` entitlement for the companion
  sync to work.

## Platform configuration

### Android

- `AndroidManifest.xml` declares `android.permission.INTERNET` and points
  at `@xml/network_security_config` for cleartext rules.
- `res/xml/network_security_config.xml` allows cleartext **only** to
  `localhost`, `10.0.2.2`, and `127.0.0.1` — default-deny elsewhere.

### iOS

- `Info.plist` sets `NSAppTransportSecurity > NSAllowsLocalNetworking =
  true` so debug builds can hit localhost. Production API must be HTTPS.

### macOS

- Sandboxed. `DebugProfile.entitlements` includes
  `com.apple.security.network.client` and
  `com.apple.security.network.server`.
  `Release.entitlements` includes the client entitlement only.

## Adding a screen

1. Create `lib/screens/<name>_screen.dart`.
2. If it needs data, add `.graphql` operations to
   `lib/graphql/operations/<feature>.graphql` and regenerate.
3. Register the route in `lib/router.dart`.
4. Link from whatever parent screen launches it.

## Adding a GraphQL operation

1. Edit or create a file in `lib/graphql/operations/`.
2. Reference shared fragments from `operations/fragments.graphql`.
3. Run `dart run build_runner build --delete-conflicting-outputs`.
4. Import the generated class from `<file>.graphql.dart`.

## Testing

- `flutter analyze` must be clean — no warnings, no unused imports.
- `flutter test` runs widget tests under `test/`. The current suite is a
  smoke test; extend it for non-trivial UI logic.
- No integration tests today. See
  [`../docs/DEVELOPMENT.md`](../docs/DEVELOPMENT.md#manual-qa-checklist)
  for the manual walkthrough.

## Hot reload notes

- Riverpod providers rebuild cleanly on hot reload.
- Changes to `*.graphql.dart` require `build_runner` to re-emit.
  Running `dart run build_runner watch` in parallel keeps this automatic.
- If you get weird state after hot-reload (e.g. stale tokens), restart
  with `R` (shift-R).
