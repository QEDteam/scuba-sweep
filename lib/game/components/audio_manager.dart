import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:scuba_sweep/game/game/my_game.dart';

class AudioManager extends Component with HasGameRef<MyGame> {
  AudioManager();

  @override
  Future<void> onLoad() async {
    await initialize();
  }

  initialize() async {
    await FlameAudio.audioCache.loadAll([
      'boost.wav',
      'collect.wav',
      'crash.wav',
    ]);

    //FlameAudio.bgm.initialize();
  }

  bool audioOn = true;

  void play(String audioFile) {
    if (audioOn) {
      FlameAudio.play(audioFile);
    }
  }

  void toggleAudio() {
    audioOn = !audioOn;
    switch (audioOn) {
      case true:
        playBgmMusic();
      case false:
        FlameAudio.bgm.stop();
    }
  }

  void playBgmMusic() {
    if (audioOn) {
      FlameAudio.bgm.play('bgm.mp3');
    }
  }
}
