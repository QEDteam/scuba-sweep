# Scuba Sweep - Flutter Game

![image info](https://github.com/QEDteam/scuba-sweep/assets/30495155/627c1dfe-8e15-471f-92a0-ec98703995c4)

## Welcome to Scuba Sweep, a captivating underwater adventure game built with Flutter

Our project draws inspiration from our deep concern for the environment, particularly the dire issue of plastic pollution in our oceans. Witnessing the suffering of innocent sea creatures like turtles and fish due to plastic waste deeply saddens us. Consequently, we are driven by a strong desire to showcase actionable steps we can take to make a positive difference. The game was built for [DEVPOST Global Gamers Challenge - Flutter](https://globalgamers.devpost.com/)

## What it does

Scuba Sweep aims to shed light on the pressing issue of ocean plastic pollution. Players immerse themselves in the role of a diver navigating through the ocean depths, tasked with collecting different types of plastic debris encountered along the way. Amidst this mission, they must also navigate past hazardous sea creatures, adding an element of challenge and urgency to the gameplay experience.

<img width="200" src="https://github.com/QEDteam/scuba-sweep/assets/30495155/5125c4c4-1cf6-466c-a79c-d7af08701c12"/>
<img width="200" src="https://github.com/QEDteam/scuba-sweep/assets/30495155/e3faab95-55e6-4985-9ed7-9195ca6b5214"/>
<img width="200" src="https://github.com/QEDteam/scuba-sweep/assets/30495155/02084009-e844-42b5-915e-59fe1a08277e"/>
<img width="200" src="https://github.com/QEDteam/scuba-sweep/assets/30495155/100d7102-a484-478d-a567-1183c7ea22b1"/>

## How we built it

The game is crafted using Flutter, with Flame serving as the game engine and Riverpod for state management. Players have the freedom to select their own nickname to personalize their score tracking experience.

As the game begins, the diver component is introduced, automatically ascending and responsive to left or right movements via drag controls. Gradually, plastic and enemy components are introduced, each featuring distinct movements tailored to their creature type, heightening the challenge for players.

Additionally, divers can collect booster components like the shell pearl, providing a temporary shield, offering protection against enemy encounters. The game concludes when the player component collides with enemies, signaling the end of the gameplay session.

## Prerequisites

Foundation is built with [Flutter Presetup](https://github.com/vbalagovic/flutter-presetup) tool that we developed internaly to help kickstart new projects.

- Flutter version 3.16.2
- [Use fvm for flutter versioning if default flutter version is not right]
- if fvm flutter is not setup in your working environment (vs code/ android studio) use prefix fvm when running command `fvm flutter build ...`

- vs code settings.json for fvm usage automatically based by project

```json
"dart.flutterSdkPath": ".fvm/flutter_sdk",
// Remove .fvm files from search
"search.exclude": {
    "**/.fvm": true
},
// Remove from file watching
"files.watcherExclude": {
    "**/.fvm": true
},
```

## Getting Started

This project uses Flutter flavor, with two flavors:

- dev
- prod

Populate `lib/main_{flavor}.dart` file to update params for specific environments

- ### Running flavors

    To run dev env debug:

    ```bash
    flutter run --flavor dev -t lib/main_dev.dart
    ```

    To run prod env debug:

    ```bash
    flutter run --flavor prod -t lib/main_prod.dart
    ```

## Building application

Build per flavors, for android firebase build apk and for play store appbundle

### Android

- Dev APK:

```bash
fvm flutter build apk --split-per-abi --flavor dev -t lib/main_dev.dart
```

- Prod AppBundle:

```bash
fvm flutter build appbundle --flavor prod -t lib/main_prod.dart
```

#### IOs

- Dev ipa:

```bash
fvm flutter build ipa --flavor dev -t lib/main_dev.dart
```

- Prod ipa:

```bash
fvm flutter build ipa --flavor prod -t lib/main_prod.dart
```

## Generate Icons

To assets folder add icons named by env `launcher-icon-dev.png`, `launcher-icon-prod.png` and then run:

```bash
fvm flutter pub get && fvm flutter pub run flutter_launcher_icons:main -f flutter_launcher_icons*
```

## Generate freezed files

```bash
fvm flutter pub run build_runner build --delete-conflicting-outputs
```

## Download Apk File

[Apk File from releases directory](https://github.com/QEDteam/scuba-sweep/raw/main/releases/scuba_sweep1-2-1.apk)
