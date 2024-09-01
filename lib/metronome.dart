import 'metronome_platform_interface.dart';

class Metronome {
  Future<bool> play(int bpm) {
    return MetronomePlatform.instance.play(bpm);
  }

  Future<bool> stop() {
    return MetronomePlatform.instance.stop();
  }

  Future<bool> isPlaying() {
    return MetronomePlatform.instance.isPlaying();
  }
}
