import 'package:flame/components.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_app/game/game/my_game.dart';

class MyParallaxComponent extends Component with HasGameRef<MyGame> {
  @override
  Future<void> onLoad() async {
    final parallaxBackground = await gameRef.loadParallaxComponent(
      [
        ParallaxImageData('blue.png'),
        ParallaxImageData('shadow_stones.png'),
        ParallaxImageData('fish.png'),
        ParallaxImageData('corals.png'),
        ParallaxImageData('stones.png'),
        ParallaxImageData('bubbles.png'),
        ParallaxImageData('rays.png'),
      ],
      baseVelocity: Vector2(0, -10),
      velocityMultiplierDelta: Vector2(0, 1.8),
      repeat: ImageRepeat.repeatY,
      fill: LayerFill.width,
    );
    gameRef.add(parallaxBackground);
  }
}