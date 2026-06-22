# Cade Meu Carro

Never lose your car in a parking lot again. **Cade Meu Carro** (Portuguese for "Where's My Car") lets you save your parking spot location with floor, section letter, and spot number — then shows you exactly where you parked.

<p align="center">
  <img width="300" height="560" src="https://github.com/eshinkawa/carFinderFlutter/blob/main/assets/screenshots/android-screenshot.jpg">
  <img width="300" height="560" src="https://github.com/eshinkawa/carFinderFlutter/blob/main/assets/screenshots/iphone-screenshot.PNG">
</p>

## Features

- Save parking spot (floor, section, spot number) with timestamp
- View saved parking location on a styled display card
- Browsable history of all past parking spots
- Delete individual history entries
- Dark purple theme optimized for parking garage use

## Tech Stack

| Layer | Technology |
|---|---|
| Framework | Flutter 3.x (Dart 3.x, null-safe) |
| State Management | [Provider](https://pub.dev/packages/provider) |
| Local Database | [Hive](https://pub.dev/packages/hive) |
| Key-Value Storage | [Shared Preferences](https://pub.dev/packages/shared_preferences) |
| HTTP Client | [http](https://pub.dev/packages/http) |

## Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) 3.0+
- Android Studio / Xcode (for platform builds)
- A device or emulator (Android API 21+ / iOS 13.0+)

### Installation

```bash
git clone https://github.com/eshinkawa/carFinderFlutter.git
cd carFinderFlutter
flutter pub get
```

### Running

```bash
flutter run
```

### Build

```bash
# Android APK
flutter build apk --release

# iOS
flutter build ios --release
```

## Project Structure

```
lib/
├── main.dart                          # App entry point, Hive init, Provider setup
├── routes.dart                        # MaterialApp with named routes
├── controllers/
│   └── parking.controller.dart        # Parking business logic (ChangeNotifier)
├── models/
│   ├── history_item.dart              # Hive model for parking history
│   └── parkingItem.dart               # Parking lot model (API)
├── views/
│   ├── splash_screen.view.dart        # Splash screen with logo
│   ├── home.view.dart                 # Bottom nav: parking + history tabs
│   ├── parking.view.dart              # Main parking spot selection view
│   └── history.view.dart              # Saved parking history list
├── widgets/
│   ├── button.dart                    # Reusable styled button
│   ├── dropItem.dart                  # Reusable dropdown picker
│   ├── sign.dart                      # Parking spot display card
│   └── fader.dart                     # Fade transition route
├── services/
│   ├── webservice.dart                # Generic HTTP client wrapper
│   └── location.dart                  # Location service (WIP)
├── interfaces/
│   └── parking.interface.dart         # Repository contract
└── utils/
    └── constants.dart                 # String and URL constants
```

## License

[MIT](LICENSE)
