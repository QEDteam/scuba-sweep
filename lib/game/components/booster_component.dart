import 'package:flame/components.dart';
import 'package:my_flutter_app/game/game/my_game.dart';
import 'package:my_flutter_app/game/helper/enums.dart';

class BoosterComponent extends SpriteComponent with HasGameRef<MyGame> {
  final double _speed = 200;
  final double _animationSpeed = 0.05;
  late final SpriteAnimationComponent shieldAnimation;

  BoosterComponent({required Vector2 position})
      : super(
          size: Vector2.all(50.0),
          position: position,
        );

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite('star.png');
    _loadAnimation();
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.y += _speed * dt;

    final bufferZone = -size.x * 0.2;

    final playerRect = gameRef.player.toRect();
    final boosterRect = toRect().inflate(bufferZone);

    if (playerRect.overlaps(boosterRect)) boost();
  }

  void boost() {
    gameRef.boosterManager.shieldAnimation = shieldAnimation;
    gameRef.player.hasShield = true;
    gameRef.add(shieldAnimation);
    gameRef.gameSpeed = SpeedMode.boost;
  }

  void _loadAnimation() async {
    List<double> stepTimes = List<double>.filled(60, _animationSpeed);
    stepTimes[29] = 3; // 3 seconds of pause for desired shield frame

    shieldAnimation = SpriteAnimationComponent.fromFrameData(
      await gameRef.images.load('shield.png'),
      SpriteAnimationData.variable(
        amount: 60,
        amountPerRow: 5,
        textureSize: Vector2(192, 192),
        stepTimes: stepTimes,
        loop: false,
      ),
      size: Vector2(200, 200),
      removeOnFinish: true,
      anchor: Anchor.center,
    );
  }
}
