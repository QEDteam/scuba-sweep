import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart' as cp;
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_flutter_app/data/providers/score_provider.dart';
import 'package:my_flutter_app/game/components/enemy_component.dart';
import 'package:my_flutter_app/game/components/falling_component.dart';
import 'package:my_flutter_app/game/components/player_component.dart';
import 'package:my_flutter_app/game/components/score_component.dart';
import 'package:my_flutter_app/game/game/widgets/game_header.dart';
import 'package:my_flutter_app/game/game/widgets/game_over_menu.dart';
import 'package:my_flutter_app/game/game/widgets/pause_menu.dart';
import 'package:my_flutter_app/game/helper/enums.dart';
import 'package:uuid/uuid.dart';

class MyGame extends FlameGame {
  final BuildContext context;
  final WidgetRef ref;

  MyGame(this.context, this.ref);

  SpeedMode gameSpeed = SpeedMode.slow;

  final PlayerComponent player = PlayerComponent();

  final List<FallingComponent> fallingComponents = [];
  final List<EnemyComponent> enemyComponents = [];
  late final ScoreComponent scoreComponent = ScoreComponent(context);

  late final Vector2 gameSize;
  Timer fallingComponentsTimer = Timer(Duration.zero, () {});
  Timer enemyComponentsTimer = Timer(Duration.zero, () {});
  var uuid = const Uuid();

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
    fallingComponentsTimer.cancel();
    enemyComponentsTimer.cancel();
  }

  @override
  void resumeEngine() {
    super.resumeEngine();
    overlays.remove(PauseMenu.id);
    overlays.add(GameHeader.id);
    _startAddingFallingComponents();
    startAddingEnemies();
  }

  void startGame() async {
    scoreComponent.reset();
    ref.read(scoreNotifierProvider.notifier).getHighScore();
    add(player);
    overlays.add(GameHeader.id);
    _startAddingFallingComponents();
    add(scoreComponent);
    player.startMovingUp();
    startAddingEnemies();
  }

  void _startAddingFallingComponents() async {
    final List<Future<cp.Sprite>> plasticSprites = PlasticType.values.map((e) {
      final sprite = cp.Sprite.load(e.imagePath);
      return sprite;
    }).toList();
    fallingComponentsTimer = Timer.periodic(const Duration(milliseconds: 800), (_) async {
      final randomPlastic = Random().nextInt(PlasticType.values.length);
      final fallingComponent = FallingComponent(
        id: uuid.v4(),
        sprite: await plasticSprites[randomPlastic],
        positionX: randomPositionX,
      );
      add(fallingComponent);
      fallingComponents.add(fallingComponent);
    });
  }

  void startAddingEnemies() {
    final List<Future<cp.Sprite>> enemySprites = Enemy.values.map((e) {
      final sprite = cp.Sprite.load(e.imagePath);
      return sprite;
    }).toList();
    enemyComponentsTimer =
        Timer.periodic(const Duration(seconds: 3), (_) async {
      final randomEnemy = Random().nextInt(level);
      final enemyComponent = EnemyComponent(
        enemy: Enemy.values[randomEnemy],
        positionX: randomPositionX,
        id: uuid.v4(),
        sprite: await enemySprites[randomEnemy],
      );
      add(enemyComponent);
      enemyComponents.add(enemyComponent);
    });
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
    final index =
        enemyComponents.indexWhere((element) => element.id == componentId);
    if (index != -1) {
      addEffect(
          effect: AnimationEffect.burst,
          position: enemyComponents[index].position,
          size: Vector2.all(192));

      gameOver();
    }
  }

  void gameOver() async {
    ref.read(scoreNotifierProvider.notifier).loadScores(scoreComponent.score);
    overlays.remove(GameHeader.id);
    overlays.add(GameOverMenu.id);
    fallingComponentsTimer.cancel();
    enemyComponentsTimer.cancel();
    for (var fallingComponent in fallingComponents) {
      fallingComponent.removeFromParent();
    }
    for (var enemyComponent in enemyComponents) {
      enemyComponent.removeFromParent();
    }
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
