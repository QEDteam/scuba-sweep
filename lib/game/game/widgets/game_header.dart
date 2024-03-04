import 'package:flutter/material.dart';
import 'package:scuba_sweep/game/game/my_game.dart';

class GameHeader extends StatelessWidget {
  static const id = 'GameHeader';
  final MyGame game;

  const GameHeader(this.game, {super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.topRight,
        child: Material(
          color: Colors.transparent,
          child: IconButton(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
            onPressed: () {
              game.pauseGame();
            },
            icon: const Icon(
              Icons.pause,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
