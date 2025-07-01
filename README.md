# Invoice App

[![Codemagic build status](https://api.codemagic.io/apps/6864253ef2b608e1bd8d9e29/6864253ef2b608e1bd8d9e28/status_badge.svg)](https://codemagic.io/app/6864253ef2b608e1bd8d9e29/6864253ef2b608e1bd8d9e28/latest_build)

An Open Source Invoice App

## Run App

```bash
flutter run --dart-define=SUPABASE_URL=<YOUR_URL> --dart-define=ANON_KEY=<YOUR_ANON_KEY>
```

You may get `SUPABASE_URL` and `ANON_KEY` from [supabase](https://supabase.com/)

## Generate App Localization

```bash
flutter gen-l10n
```

## Unit Test

```bash
flutter test
```

## Generate Code Coverage

```bash
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
```

## Flutter Doctor summary

```bash
Doctor summary (to see all details, run flutter doctor -v):
[✓] Flutter (Channel stable, 3.32.5, on macOS 15.5 24F74 darwin-arm64, locale en-IN)
[✓] Android toolchain - develop for Android devices (Android SDK version 34.0.0)
[✓] Xcode - develop for iOS and macOS (Xcode 16.0)
```
