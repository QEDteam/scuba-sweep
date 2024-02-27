import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart' as cp;
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_flutter_app/data/providers/score_provider.dart';
import 'package:my_flutter_app/game/components/booster_manager.dart';
import 'package:my_flutter_app/game/components/enemy_manager.dart';
import 'package:my_flutter_app/game/components/player_component.dart';
import 'package:my_flutter_app/game/components/score_component.dart';
import 'package:my_flutter_app/game/components/trash_manager.dart';
import 'package:my_flutter_app/game/game/widgets/game_header.dart';
import 'package:my_flutter_app/game/game/widgets/game_over_menu.dart';
import 'package:my_flutter_app/game/game/widgets/pause_menu.dart';
import 'package:my_flutter_app/game/helper/enums.dart';

class MyGame extends FlameGame {
  final BuildContext context;
  final WidgetRef ref;

  MyGame(this.context, this.ref);

  SpeedMode gameSpeed = SpeedMode.slow;

  final PlayerComponent player = PlayerComponent();

  late final ScoreComponent scoreComponent = ScoreComponent(context);
  final BoosterManager boosterManager = BoosterManager();
  final TrashManager trashManager = TrashManager();
  final EnemyManager enemyManager = EnemyManager();

  late final Vector2 gameSize;

  int level = 1;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    gameSize = size;
    loadBackground();
  }

  void loadBackground() async {
    final parallaxBackground = await loadParallaxComponent(
      [
        ParallaxImageData('blue.png'),
        ParallaxImageData('shadow_stones.png'),
        ParallaxImageData('fish.png'),
        ParallaxImageData('corals.png'),
        ParallaxImageData('stones.png'),
        ParallaxImageData('bubbles.png'),
        ParallaxImageData('rays.png'),
      ],
      baseVelocity: Vector2(0, -10),
      velocityMultiplierDelta: Vector2(0, 1.8),
      repeat: ImageRepeat.repeatY,
      fill: LayerFill.width,
    );
    add(parallaxBackground);
  }

  @override
  void pauseEngine() {
    super.pauseEngine();
    overlays.remove(GameHeader.id);
    overlays.add(PauseMenu.id);
    boosterManager.timer.cancel();
    trashManager.timer.cancel();
    enemyManager.timer.cancel();
  }

  @override
  void resumeEngine() {
    super.resumeEngine();
    overlays.remove(PauseMenu.id);
    overlays.add(GameHeader.id);
    boosterManager.start();
    trashManager.start();
    enemyManager.start();
  }

  void startGame() async {
    scoreComponent.reset();
    ref.read(scoreNotifierProvider.notifier).getHighScore();
    add(player);
    overlays.add(GameHeader.id);
    add(scoreComponent);
    player.startMovingUp();
    add(enemyManager);
    enemyManager.start();
    add(trashManager);
    trashManager.start();
    add(boosterManager);
    boosterManager.start();
  }

  levelUp() {
    if (level + 1 <= Enemy.values.length) {
      level++;
    }
  }

  double get randomPositionX => Random().nextInt(gameSize.x.toInt()).toDouble();

  void updateSpeed() {
    const speedList = SpeedMode.values;
    final index = speedList.indexOf(gameSpeed) + 1;
    if (index < speedList.length) {
      gameSpeed = speedList[index];
    }
  }

  void sharkAttack(String componentId) {
    final enemies = enemyManager.enemyComponents;
    final index = enemies.indexWhere((element) => element.id == componentId);
    if (index != -1) {
      addEffect(
          effect: AnimationEffect.burst,
          position: enemies[index].position,
          size: Vector2.all(192));

      gameOver();
    }
  }

  void gameOver() async {
    ref.read(scoreNotifierProvider.notifier).loadScores(scoreComponent.score);
    overlays.remove(GameHeader.id);
    overlays.add(GameOverMenu.id);
    trashManager.reset();
    boosterManager.timer.cancel();
    enemyManager.reset();
    gameSpeed = SpeedMode.slow;
  }

  Future<void> addEffect(
      {required AnimationEffect effect,
      required Vector2 position,
      required Vector2 size}) async {
    final animationEffect = cp.SpriteAnimationComponent.fromFrameData(
      await images.load('${effect.effectName}.png'),
      cp.SpriteAnimationData.sequenced(
        amount: effect.amount,
        amountPerRow: 5,
        textureSize: size,
        stepTime: effect.speed,
        loop: false,
      ),
      size: size / 2,
      removeOnFinish: true,
      anchor: cp.Anchor.center,
    );

    animationEffect.position = position;
    add(animationEffect);
  }
}
