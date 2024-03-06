import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:scuba_sweep/game/game/my_game.dart';
import 'package:scuba_sweep/game/helper/enums.dart';

class BoosterComponent extends SpriteAnimationComponent
    with HasGameRef<MyGame> {
  final String id;
  final double _speed = 200;
  final double _animationSpeed = 0.03;
  late final SpriteAnimationComponent shieldAnimation;

  BoosterComponent({required Vector2 position, required this.id,})
      : super(
          size: Vector2.all(50.0),
          position: position,
        );

  @override
  Future<void> onLoad() async {
    super.onLoad();
    _loadBoosterComponent();
    _loadAnimation();
    size = Vector2.all(80);
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
    gameRef.boosterManager.removeBooster(this.id);
    gameRef.boosterManager.shieldAnimation = shieldAnimation;
    gameRef.player.hasShield = true;
    gameRef.add(shieldAnimation);
    gameRef.gameSpeed = SpeedMode.boost;
    gameRef.parallaxComponent.updateSpeed(SpeedMode.boost);
  }

  void _loadAnimation() async {
    List<double> stepTimes = List<double>.filled(30, _animationSpeed);
    stepTimes[13] = 3; // 3 seconds of pause for desired shield frame

    shieldAnimation = SpriteAnimationComponent.fromFrameData(
      await gameRef.images.load('shield.png'),
      SpriteAnimationData.variable(
        amount: 30,
        amountPerRow: 6,
        textureSize: Vector2(384, 384),
        stepTimes: stepTimes,
        loop: false,
      ),
      size: Vector2(200, 200),
      removeOnFinish: true,
      anchor: Anchor.center,
    );
  }

  void _loadBoosterComponent() async {
    final spriteSheet = SpriteSheet(
      image: await gameRef.images.load('sea_shell.png'),
      srcSize: Vector2.all(384),
    );
    animation = spriteSheet.createAnimation(
      row: 0,
      stepTime: 0.1,
      from: 0,
      to: 10,
    );
  }
}
