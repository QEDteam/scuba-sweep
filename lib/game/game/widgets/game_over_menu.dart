import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scuba_sweep/data/providers/auth_provider.dart';
import 'package:scuba_sweep/data/providers/score_provider.dart';
import 'package:scuba_sweep/game/game/my_game.dart';
import 'package:scuba_sweep/game/game/widgets/score_table.dart';

class GameOverMenu extends ConsumerWidget {
  static const id = 'GameOverMenu';
  final MyGame game;
  const GameOverMenu(this.game, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(scoreNotifierProvider);

    return Center(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          color: Colors.black.withAlpha(100),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 100),
              child: Wrap(
                direction: Axis.vertical,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 10,
                children: [
                  const Text(
                    'Game over',
                    style: TextStyle(
                      fontSize: 50,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Score: ${state.score}',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.indigo[900],
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 30),
                    child: Text(
                      'Top scores:',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  state.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : ScoresTable(state.topHighScores),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      game.overlays.remove(GameOverMenu.id);
                      game.resumeEngine();
                      game.startGame();
                    },
                    child: const Text(
                      'Play again',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () =>
                        ref.read(signInProvider.notifier).signOut(),
                    child: const Text(
                      'Sign out',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
