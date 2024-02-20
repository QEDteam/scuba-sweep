
import 'package:flame/components.dart';
import 'package:my_flutter_app/game/game/my_game.dart';
import 'package:my_flutter_app/game/helper/enums.dart';

class FallingComponent extends SpriteComponent with HasGameRef<MyGame> {
  final String id;

  FallingComponent(
      {required this.id, required Sprite sprite, required positionX})
      : super(
          size: Vector2.all(60.0),
          position: Vector2(positionX, 0),
          sprite: sprite,
          anchor: Anchor.center,
        );

  @override
  void update(double dt) {
    position.y += gameRef.gameSpeed.speed * dt;

    if (gameRef.player.toRect().overlaps(toRect())) {
      collectFallingComponent(id);
    }
  }

  void collectFallingComponent(String componentId) {
    final fallingComponents = gameRef.fallingComponents;
    final index =
        fallingComponents.indexWhere((element) => element.id == componentId);
    if (index != -1) {
      gameRef.addEffect(
        effect: AnimationEffect.punch,
        position: fallingComponents[index].position,
        size: Vector2.all(AnimationEffect.punch.size),
      );
      gameRef.remove(fallingComponents[index]);
      gameRef.scoreComponent.incrementScore();
      
    }
  }

  
}
