import 'package:flame/components.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';
import 'package:scuba_sweep/game/game/my_game.dart';
import 'package:scuba_sweep/game/helper/enums.dart';

class MyParallaxComponent extends Component with HasGameRef<MyGame> {
  ParallaxComponent? _parallaxComponent;
  @override
  Future<void> onLoad() async {
    _parallaxComponent = await gameRef.loadParallaxComponent(
      [
        ParallaxImageData('shadow_stones.png'),
        ParallaxImageData('fish.png'),
        ParallaxImageData('corals.png'),
        ParallaxImageData('stones.png'),
        ParallaxImageData('bubbles.png'),
        ParallaxImageData('rays.png'),
      ],
      baseVelocity: Vector2(0, -15),
      velocityMultiplierDelta: Vector2(0, 1.8),
      repeat: ImageRepeat.repeatY,
      fill: LayerFill.width,
    );
    gameRef.add(_parallaxComponent!);
  }

  updateSpeed(SpeedMode gameSpeed) {
    _parallaxComponent?.parallax!.baseVelocity = Vector2(
        0, -15 - (gameSpeed == SpeedMode.slow ? 0 : gameSpeed.speed / 100 + 12));
  }

  reset() {
    _parallaxComponent?.parallax!.baseVelocity = Vector2(0, -10);
  }
}

class BackgroundComponent extends PositionComponent with HasGameRef<MyGame> {
  Color baseBackground = getBackgroundColor(1);
  @override
  void render(Canvas canvas) {
    canvas.drawColor(getBackgroundColor(gameRef.level), BlendMode.src);
  }
}

Color getBackgroundColor(int level) {
  switch (level) {
    case 1:
      return const Color.fromARGB(255, 6, 128, 222);
    case 2:
      return const Color.fromARGB(255, 5, 101, 149);
    case 3:
      return const Color.fromARGB(255, 19, 90, 182);
    case 4:
      return const Color.fromARGB(255, 39, 42, 196);
    case 5:
      return const Color.fromARGB(255, 68, 51, 192);
    case 6:
      return const Color.fromARGB(255, 127, 32, 165);
    default:
      return const Color.fromARGB(255, 9, 68, 186);
  }
}
