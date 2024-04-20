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
  late final SpriteAnimation _rightTransitionAnimation;
  late final SpriteAnimation _leftTransitionAnimation;

  bool hasShield = false;
  bool isDead = false;

  Direction direction = Direction.none;
  bool _isDragged = false;
  bool _isTransitioning = false;

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

      Direction newDirection;

      if (delta > 2) {
        newDirection = Direction.right;
      } else if (delta < -2) {
        newDirection = Direction.left;
      } else {
        newDirection = Direction.none;
      }

      if (direction != newDirection) {
        manageTransition(newDirection);
      }
    }
    super.onDragUpdate(event);
  }

  void manageTransition(Direction newDirection) {
    if (_isTransitioning) {
      return;
    }
    _isTransitioning = true;
    animation = _rightTransitionAnimation;

    if (direction == Direction.none && newDirection == Direction.right) {
      animation = _rightTransitionAnimation;
    } else if (direction == Direction.right && newDirection == Direction.none) {
      animation = _rightTransitionAnimation.reversed();
    } else if (direction == Direction.none && newDirection == Direction.left) {
      animation = _leftTransitionAnimation;
    } else if (direction == Direction.left && newDirection == Direction.none) {
      animation = _leftTransitionAnimation.reversed();
    } else {
      _isTransitioning = false;
      direction = newDirection;
      _updateAnimation();
      return;
    }

    direction = newDirection;
    Future.delayed(const Duration(milliseconds: 130), () {
      _isTransitioning = false;
      _updateAnimation();
    });
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

    final transitionSpriteSheet = SpriteSheet(
      image: await gameRef.images.load('tr_right.png'),
      srcSize: Vector2(384, 384),
    );

    _rightTransitionAnimation = transitionSpriteSheet.createAnimation(
        row: 0, stepTime: _animationSpeed / 6, to: 16, loop: false);

    final leftTransitionSpriteSheet = SpriteSheet(
        image: await gameRef.images.load('tr_left.png'),
        srcSize: Vector2(384, 384));

    _leftTransitionAnimation = leftTransitionSpriteSheet.createAnimation(
        row: 0, stepTime: _animationSpeed / 6, to: 16, loop: false);
  }

  Rect getPlayerRect() => Rect.fromCircle(
      center: Offset(position.x, position.y - 10), radius: size.x * 0.2);
}
