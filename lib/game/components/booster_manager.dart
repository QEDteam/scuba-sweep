import 'dart:async' as da;
import 'dart:core' ;

import 'package:flame/components.dart';
import 'package:my_flutter_app/game/components/booster_component.dart';
import 'package:my_flutter_app/game/game/my_game.dart';

class BoosterManager extends Component with HasGameRef<MyGame> {
  final List<BoosterComponent> _boosters = [];
  SpriteAnimationComponent? shieldAnimation;

  da.Timer timer = da.Timer(Duration.zero, () {});

  @override
  void update(double dt) {
    super.update(dt);
    try {
      if (shieldAnimation!.isRemoved) {
        gameRef.updateSpeed();
        gameRef.player.hasShield = false;
      }
    } catch (_) {}
  }

  start() {
    timer = da.Timer.periodic(const Duration(seconds: 7), (_) => addBooster());
  }

  void addBooster() {
    final booster = BoosterComponent(position: Vector2(0, 0));
    _boosters.add(booster);
    gameRef.add(booster);
  }
}
