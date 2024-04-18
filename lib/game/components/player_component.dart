import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/sprite.dart';
import 'package:scuba_sweep/game/game/my_game.dart';

enum Direction { right, left, none }

class PlayerComponent extends SpriteAnimationComponent
    with DragCallbacks, HasGameRef<MyGame> {
  final double _animationSpeed = 0.05;

  late final SpriteAnimation _initialAnimation;
  late final SpriteAnimation _goLeftAnimation;
  late final SpriteAnimation _goRightAnimation;

  bool hasShield = false;
  bool isDead = false;

  Direction direction = Direction.none;
  bool _isDragged = false;

  PlayerComponent()
      : super(
          size: Vector2.all(120.0),
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    super.onLoad();
    await _loadAnimations().then((_) => {animation = _initialAnimation});
    setToInitialPosition();
  }

  setToInitialPosition() {
    position = Vector2(gameRef.size.x / 2, gameRef.size.y - 100);
  }

  Future<void> startMovingUp() async {
    position.y = gameRef.size.y - 100;

    for (double newY = 0; newY < 100; ++newY) {
      position.y -= 2;
      await Future.delayed(const Duration(milliseconds: 20));
    }
  }

  @override
  void onDragStart(DragStartEvent event) {
    _isDragged = true;
    super.onDragStart(event);
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    if (_isDragged && !isDead) {
      final delta = event.localDelta.x;
      position.x += delta;
      gameRef.boosterManager.shieldAnimation?.position = position;

      if (delta > 1) {
        direction = Direction.right;
      } else if (delta < -1) {
        direction = Direction.left;
      } else {
        direction = Direction.none;
      }

      _updateAnimation();
    }
    super.onDragUpdate(event);
  }

  @override
  void onDragEnd(DragEndEvent event) {
    _isDragged = false;
    animation = _initialAnimation;
    super.onDragEnd(event);
  }

  void _updateAnimation() {
    switch (direction) {
      case Direction.left:
        animation = _goLeftAnimation;
        break;
      case Direction.right:
        animation = _goRightAnimation;
        break;
      case Direction.none:
        animation = _initialAnimation;
        break;
    }
  }

  Future<void> _loadAnimations() async {
    final spriteSheet = SpriteSheet(
      image: await gameRef.images.load('svrle.png'),
      srcSize: Vector2(384, 384),
    );

    _initialAnimation = spriteSheet.createAnimation(
      row: 2,
      stepTime: _animationSpeed,
      to: 8,
    );

    _goLeftAnimation = spriteSheet.createAnimation(
      row: 0,
      stepTime: _animationSpeed,
      to: 8,
    );

    _goRightAnimation = spriteSheet.createAnimation(
      row: 1,
      stepTime: _animationSpeed,
      to: 8,
    );
  }

  Rect getPlayerRect() => Rect.fromCircle(
      center: Offset(position.x, position.y - 10), radius: size.x * 0.2);
}
