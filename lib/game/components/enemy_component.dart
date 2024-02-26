

import 'package:flame/components.dart';
import 'package:my_flutter_app/game/game/my_game.dart';
import 'package:my_flutter_app/game/helper/enums.dart';

class EnemyComponent extends SpriteComponent with HasGameRef<MyGame> {
  final String id;
  final double positionX;
  final Enemy enemy;

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
    moveEnemy(dt);
    if (enemy == Enemy.pufferfish) resize();

    final bufferZone = - size.x * 0.2; 

    final playerRect = gameRef.player.toRect();
    final enemyRect = toRect().inflate(bufferZone);

    if (!gameRef.player.hasShield && playerRect.overlaps(enemyRect)) {
      gameRef.sharkAttack(id);
    }
  }

  setPosition() {
    switch (enemy) {
      case Enemy.jellyfish:
        position = Vector2(positionX, gameRef.size.y);
        break;
      default:
        position = Vector2(positionX, 0);
    }
  }

  setSize() {
    switch (enemy) {
      case Enemy.shark:
        size = Vector2(280,130);
        break;
      case Enemy.jellyfish:
        size = Vector2.all(200);
        break;
      default:
        size = Vector2.all(100);
    }
  }

  moveEnemy(double dt) async {
    if (enemy == Enemy.jellyfish) {
      position.y -= gameRef.gameSpeed.speed * dt * 0.7;
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
