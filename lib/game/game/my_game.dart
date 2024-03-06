import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart' as cp;
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scuba_sweep/data/providers/message_provider.dart';
import 'package:scuba_sweep/data/providers/score_provider.dart';
import 'package:scuba_sweep/game/components/background_component.dart';
import 'package:scuba_sweep/game/components/booster_manager.dart';
import 'package:scuba_sweep/game/components/enemy_manager.dart';
import 'package:scuba_sweep/game/components/player_component.dart';
import 'package:scuba_sweep/game/components/score_component.dart';
import 'package:scuba_sweep/game/components/trash_manager.dart';
import 'package:scuba_sweep/game/game/overlay_widgets/env_message_overlay.dart';
import 'package:scuba_sweep/game/game/overlay_widgets/game_header.dart';
import 'package:scuba_sweep/game/game/overlay_widgets/pause_menu.dart';
import 'package:scuba_sweep/game/helper/enums.dart';

class MyGame extends FlameGame {
  final BuildContext context;
  final WidgetRef ref;

  MyGame(this.context, this.ref);

  SpeedMode gameSpeed = SpeedMode.slow;

  final PlayerComponent player = PlayerComponent();

  late final ScoreComponent scoreComponent = ScoreComponent(context);
  late final MyParallaxComponent parallaxComponent = MyParallaxComponent();
  late final BackgroundComponent backgroundComponent = BackgroundComponent()
    ..size = size;
  final BoosterManager boosterManager = BoosterManager();
  final TrashManager trashManager = TrashManager();
  final EnemyManager enemyManager = EnemyManager();

  late final Vector2 gameSize;

  int level = 0;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    gameSize = size;
    add(backgroundComponent);
    add(parallaxComponent);
  }

  pauseGame() {
    pauseEngine();
    overlays.remove(GameHeader.id);
    overlays.add(PauseMenu.id);
    boosterManager.timer.cancel();
    trashManager.timer.cancel();
    enemyManager.timer.cancel();
  }

  resumeGame() {
    resumeEngine();
    overlays.remove(PauseMenu.id);
    overlays.add(GameHeader.id);
    boosterManager.start();
    trashManager.start();
    enemyManager.start();
  }

  void startGame() async {
    level = 1;
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
    ref.read(aiMessageNotifierProvider.notifier).getAiMessage();
  }

  levelUp() {
    level++;
    if (!player.hasShield) {
      updateSpeed();
    }
  }

  double get randomPositionX => Random().nextInt(gameSize.x.toInt()).toDouble();

  void updateSpeed() async {
    const speedValues = SpeedMode.values;
    gameSpeed =
        level < speedValues.length ? speedValues[level - 1] : speedValues.last;
    await parallaxComponent.updateSpeed(gameSpeed);
  }

  void sharkAttack(String componentId) async {
    final enemies = enemyManager.enemyComponents;
    final index = enemies.indexWhere((element) => element.id == componentId);
    if (index != -1) {
      addEffect(
          effect: AnimationEffect.crash,
          position: enemies[index].position,
          size: Vector2.all(192));
      remove(enemies[index]);
      Future.delayed(const Duration(milliseconds: 300), () {
        gameOver();
      });
    }
  }

  void gameOver() async {
    pauseEngine();
    ref.read(scoreNotifierProvider.notifier).loadScores(scoreComponent.score);
    overlays.remove(GameHeader.id);
    overlays.add(EnvMessageOverlay.id);
    reset();
  }

  void reset() {
    trashManager.reset();
    boosterManager.timer.cancel();
    enemyManager.reset();
    level = 0;
    gameSpeed = SpeedMode.slow;
    parallaxComponent.reset();
    remove(player);
  }

  Future<void> addEffect(
      {required AnimationEffect effect,
      required Vector2 position,
      required Vector2 size}) async {
    const splash = AnimationEffect.splash;
    final animationEffect = cp.SpriteAnimationComponent.fromFrameData(
      await images.load('${splash.name}.png'),
      cp.SpriteAnimationData.sequenced(
        amount: splash.amount,
        amountPerRow: splash.amountPerRow,
        textureSize: Vector2.all(splash.size),
        stepTime: splash.speed,
        loop: false,
      ),
      size: size / 1.5,
      removeOnFinish: true,
      anchor: cp.Anchor.center,
    );

    animationEffect.position = position;
    add(animationEffect);
  }
}
