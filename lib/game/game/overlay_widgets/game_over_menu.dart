import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scuba_sweep/data/providers/score_provider.dart';
import 'package:scuba_sweep/game/game/my_game.dart';
import 'package:scuba_sweep/game/game/overlay_widgets/leaderboard_overlay.dart';
import 'package:scuba_sweep/game/game/overlay_widgets/overlay_frame.dart';
import 'package:scuba_sweep/game/helper/colors.dart';
import 'package:scuba_sweep/game/helper/styles.dart';
import 'package:scuba_sweep/screens/widgets/action_button.dart';
import 'package:scuba_sweep/screens/widgets/logout_button.dart';

class GameOverMenu extends ConsumerWidget {
  static const id = 'GameOverMenu';
  final MyGame game;
  const GameOverMenu(this.game, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(scoreNotifierProvider);

    return OverlayFrame(
        child: SizedBox(
      width: MediaQuery.of(context).size.width - 80,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'game_over',
            style: titleTextStyle,
          ).tr(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppColors.white,
                  width: 2,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Score',
                    style: titleTextStyle.copyWith(fontSize: 20),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    '${state.score}',
                    style: titleTextStyle.copyWith(fontSize: 22),
                  ),
                ],
              ),
            ),
          ),
          ActionButton(
            title: 'play_again',
            onPressed: () {
              game.reset();
              game.overlays.remove(GameOverMenu.id);
              game.resumeEngine();
              game.startGame();
            },
          ),
          const SizedBox(height: 20),
          ActionButton(
            title: 'leaderboard',
            customColor: AppColors.green,
            onPressed: () {
              game.overlays.remove(GameOverMenu.id);
              game.overlays.add(LeaderBoardOverlay.id);
            },
          ),
          const SizedBox(height: 40),
          const LogoutButton(),
        ],
      ),
    ));
  }
}
