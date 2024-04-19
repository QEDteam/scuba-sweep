import 'dart:async' as da;
import 'dart:core';

import 'package:flame/components.dart';
import 'package:scuba_sweep/game/components/booster_component.dart';
import 'package:scuba_sweep/game/game/my_game.dart';
import 'package:scuba_sweep/game/game/overlay_widgets/booster_progress_overlay.dart';
import 'package:uuid/uuid.dart';

class BoosterManager extends Component with HasGameRef<MyGame> {
  final List<BoosterComponent> _boosters = [];
  SpriteAnimationComponent? shieldAnimation;

  da.Timer timer = da.Timer(Duration.zero, () {});
  final Uuid uuid = const Uuid();

  @override
  void update(double dt) {
    super.update(dt);

    _boosters.removeWhere((booster) => booster.position.y > gameRef.size.y);

    try {
      if (shieldAnimation!.isRemoved) {
        gameRef.updateSpeed();
        gameRef.player.hasShield = false;
        gameRef.overlays.remove(BoosterProgressOverlay.id);
      }
    } catch (_) {}
  }

  start() {
    timer = da.Timer.periodic(const Duration(seconds: 10), (_) => addBooster());
  }

  void addBooster() {
    final booster = BoosterComponent(
      position: Vector2(gameRef.randomPositionX, 0),
      id: uuid.v4(),
    );
    _boosters.add(booster);
    gameRef.add(booster);
  }

  void removeBooster(String id) {
    final index = _boosters.indexWhere((booster) => booster.id == id);
    if (index != -1) {
      gameRef.remove(_boosters[index]);
      _boosters.removeAt(index);
    }
  }

  void reset() {
    timer.cancel();
    for (var booster in _boosters) {
      booster.removeFromParent();
    }
  }
}
