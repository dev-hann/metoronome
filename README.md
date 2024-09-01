# Flutter Metronome Plugin

A Flutter plugin for creating a metronome, with implementations for both iOS and Android. The plugin uses `AVAudioEngine` on iOS and `AudioTrack` on Android to deliver a precise and customizable metronome experience.

## Features

- Real-time BPM adjustment
- Background audio playback
- Custom click sound generation
- Cross-platform support: iOS and Android

## Platform Implementation

- **iOS**: Uses `AVAudioEngine` for low-latency, high-quality audio playback.
- **Android**: Uses `AudioTrack` for efficient and accurate sound playback.

## Installation

To use this plugin, add it to your dependencies in `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  metronome:
    git:
      url: https://github.com/dev-hann/metronome.git
