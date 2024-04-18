import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:scuba_sweep/game/game/my_game.dart';
import 'package:scuba_sweep/game/helper/enums.dart';

class EnemyComponent extends SpriteComponent with HasGameRef<MyGame> {
  final String id;
  final double positionX;
  final Enemy enemy;

  bool _isDead = false;

  EnemyComponent({
    required this.id,
    required Sprite sprite,
    required this.positionX,
    required this.enemy,
  }) : super(
          size: Vector2.all(100.0),
          sprite: sprite,
          anchor: Anchor.center,
        );

  @override
  void onLoad() {
    super.onLoad();
    setPosition();
    setSize();
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (_isDead) {
      return;
    }
    moveEnemy(dt);
    if (enemy == Enemy.pufferfish) resize();

    final playerPosition = gameRef.player.position;
    final playerRect = Rect.fromCircle(
        center: Offset(playerPosition.x, playerPosition.y),
        radius: (gameRef.player.size.x / 2) - 20);
    final enemyRect = Rect.fromCircle(
        center: Offset(position.x, position.y),
        radius: (size.y / 2) - (enemy == Enemy.pufferfish ? 50 : 20));

    if (!gameRef.player.hasShield && playerRect.overlaps(enemyRect)) {
      _isDead = true;
      gameRef.sharkAttack(id);
    }
  }

  setPosition() {
    position = Vector2(positionX, 0);
  }

  setSize() {
    switch (enemy) {
      case Enemy.shark:
        size = Vector2(220, 130);
        break;
      case Enemy.jellyfish:
        size = Vector2(80, 120);
        break;
      default:
        size = Vector2.all(100);
    }
  }

  moveEnemy(double dt) async {
    if (enemy == Enemy.jellyfish) {
      position.y += gameRef.gameSpeed.speed * dt;
    } else {
      position.y += gameRef.gameSpeed.speed * dt;
    }

    if (enemy == Enemy.shark) {
      bool moveRight = positionX < (gameRef.size.x / 2);
      position.x += moveRight ? 2 : -2;
      if (!moveRight) {
        sprite = await Sprite.load('sharkl.png');
      }
    }
  }

  resize() {
    if (size.x < 350) {
      size += Vector2.all(1);
    }
  }
}
