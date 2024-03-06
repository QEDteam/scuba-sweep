import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scuba_sweep/game/game/my_game.dart';
import 'package:scuba_sweep/game/game/overlay_widgets/overlay_frame.dart';
import 'package:scuba_sweep/game/helper/styles.dart';
import 'package:scuba_sweep/screens/widgets/action_button.dart';
import 'package:scuba_sweep/screens/widgets/logout_button.dart';

class PauseMenu extends ConsumerWidget {
  static const id = 'PauseMenu';
  final MyGame game;

  const PauseMenu(this.game, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OverlayFrame(
        child: SizedBox(
      width: MediaQuery.of(context).size.width - 40,
      child: Center(
        child: Column(
          children: [
            Text(
              'game_paused',
              style: titleTextStyle,
            ).tr(),
            const SizedBox(
              height: 60,
            ),
            ActionButton(
              title: 'resume',
              onPressed: () {
                game.resumeGame();
              },
            ),
            const SizedBox(height: 20),
            const LogoutButton()
          ],
        ),
      ),
    ));
  }
}
