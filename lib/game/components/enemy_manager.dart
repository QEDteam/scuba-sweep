import 'dart:math';

import 'package:flame/components.dart';
import 'package:my_flutter_app/game/components/enemy_component.dart';
import 'package:my_flutter_app/game/game/my_game.dart';
import 'package:my_flutter_app/game/helper/enums.dart';
import 'dart:async' as da;

import 'package:uuid/uuid.dart';

class EnemyManager extends Component with HasGameRef<MyGame> {
  final List<EnemyComponent> enemyComponents = [];
  da.Timer timer = da.Timer(Duration.zero, () {});

  final Uuid uuid = const Uuid();

  final List<Future<Sprite>> enemySprites = Enemy.values.map((e) {
    final sprite = Sprite.load(e.imagePath);
    return sprite;
  }).toList();

  @override
  void update(double dt) {
    super.update(dt);
    enemyComponents.removeWhere((enemy) => enemy.position.y > gameRef.size.y);
  }

  start() {
    timer = da.Timer.periodic(const Duration(seconds: 2), (_) => addEnemy());
  }

  addEnemy() async {
    final randomEnemy = Random().nextInt(gameRef.level);
      final enemyComponent = EnemyComponent(
        enemy: Enemy.values[randomEnemy],
        positionX: gameRef.randomPositionX,
        id: uuid.v4(),
        sprite: await enemySprites[randomEnemy],
      );
      gameRef.add(enemyComponent);
      enemyComponents.add(enemyComponent);
  }

  reset() {
    timer.cancel();
    for (var enemyComponent in enemyComponents) {
      enemyComponent.removeFromParent();
    }
  }
}
