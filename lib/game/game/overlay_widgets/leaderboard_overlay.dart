import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scuba_sweep/data/providers/score_provider.dart';
import 'package:scuba_sweep/game/game/my_game.dart';
import 'package:scuba_sweep/game/game/overlay_widgets/game_over_menu.dart';
import 'package:scuba_sweep/game/game/overlay_widgets/overlay_frame.dart';
import 'package:scuba_sweep/game/game/overlay_widgets/score_table.dart';
import 'package:scuba_sweep/game/helper/styles.dart';

class LeaderBoardOverlay extends ConsumerWidget {
  static const id = 'LeaderBoardMenu';
  final MyGame game;
  const LeaderBoardOverlay(this.game, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(scoreNotifierProvider);

    return OverlayFrame(
        child: SizedBox(
      width: MediaQuery.of(context).size.width - 80,
      child: Column(
        children: [
          Text(
            'Leaderboard',
            style: titleTextStyle,
          ),
          const SizedBox(height: 40),
          state.isLoading
              ? const Center(child: CircularProgressIndicator())
              : ScoresTable(state.topHighScores),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () {
              game.overlays.remove(LeaderBoardOverlay.id);
              game.overlays.add(GameOverMenu.id);
            },
            child: Text(
              'back',
              style: exitTextstyle,
            ).tr(),
          ),
        ],
      ),
    ));
  }
}
