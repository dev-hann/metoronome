import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'metronome_platform_interface.dart';

class MethodChannelMetronome extends MetronomePlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('metronome');

  @override
  Future<bool> isPlaying() async {
    final result = await methodChannel.invokeMethod<bool>('isPlaying');
    return result ?? false;
  }

  @override
  Future<bool> play(int bpm) async {
    final result = await methodChannel.invokeMethod<bool>(
      'play',
      {"bpm": bpm},
    );
    return result ?? false;
  }

  @override
  Future<bool> stop() async {
    final result = await methodChannel.invokeMethod<bool>('stop');
    return result ?? false;
  }

  @override
  Future<bool> setBPM(int bpm) async {
    final result = await methodChannel.invokeMethod<bool>(
      'setBPM',
      {"bpm": bpm},
    );
    return result ?? false;
  }

  @override
  Future<int> getBPM() async {
    final result = await methodChannel.invokeMethod<int>('getBPM');
    return result ?? -1;
  }
}
