import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'metronome_method_channel.dart';

abstract class MetronomePlatform extends PlatformInterface {
  /// Constructs a MetronomePlatform.
  MetronomePlatform() : super(token: _token);

  static final Object _token = Object();

  static MetronomePlatform _instance = MethodChannelMetronome();

  static MetronomePlatform get instance => _instance;

  static set instance(MetronomePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool> play(int bpm) {
    throw UnimplementedError('play() has not been implemented.');
  }

  Future<bool> stop() {
    throw UnimplementedError('stop() has not been implemented.');
  }

  Future<bool> isPlaying() {
    throw UnimplementedError('isPlaying() has not been implemented.');
  }
}
