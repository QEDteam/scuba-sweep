import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:scuba_sweep/game/game/my_game.dart';

class ScoreComponent extends PositionComponent with HasGameRef<MyGame> {
  int score = 0;
  final BuildContext context;

  ScoreComponent(this.context);

  @override
  void render(Canvas canvas) {
    var textStyle = const TextStyle(
      color: Colors.white,
      fontSize: 24,
    );
    final textSpan = TextSpan(
      text: 'Score: $score',
      style: textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    final safeAreaPadding =
        EdgeInsets.only(top: MediaQuery.of(context).padding.top);
    final offset = const Offset(10, 10) + safeAreaPadding.topLeft;
    textPainter.layout();
    textPainter.paint(canvas, offset);
  }

  void incrementScore() {
    score++;
    if (score % 10 == 0) {
      gameRef.levelUp();
    }
  }

  void reset() {
    score = 0;
  }
}
