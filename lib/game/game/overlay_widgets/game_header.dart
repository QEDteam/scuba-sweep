import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scuba_sweep/data/providers/score_provider.dart';
import 'package:scuba_sweep/game/game/my_game.dart';
import 'package:scuba_sweep/game/helper/styles.dart';

class GameHeader extends ConsumerWidget {
  static const id = 'GameHeader';
  final MyGame game;

  const GameHeader(this.game, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
      child: Align(
        alignment: Alignment.topCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  'Score:',
                  style: subtitleStyle,
                ),
                const SizedBox(width: 5),
                Text(
                  ref.watch(scoreNotifierProvider).score.toString(),
                  style: subtitleStyle.copyWith(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            Material(
              color: Colors.transparent,
              child: IconButton(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                onPressed: () {
                  game.pauseEngine();
                },
                icon: const Icon(
                  Icons.pause,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
