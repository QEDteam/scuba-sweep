import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scuba_sweep/data/providers/score_provider.dart';
import 'package:scuba_sweep/game/game/my_game.dart';
import 'package:scuba_sweep/game/game/overlay_widgets/instructions_overlay.dart';
import 'package:scuba_sweep/game/helper/colors.dart';
import 'package:scuba_sweep/screens/widgets/action_button.dart';
import 'package:scuba_sweep/screens/widgets/logout_button.dart';

class MainMenu extends ConsumerWidget {
  static const id = 'MainMenu';
  final MyGame game;

  const MainMenu(this.game, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(scoreNotifierProvider);
    return Scaffold(
        backgroundColor: AppColors.primaryDark,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/back.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  "assets/images/logo.png",
                  width: 230,
                ),
                const SizedBox(height: 40),
                Text(
                  state.nickname,
                  style: const TextStyle(
                    fontSize: 30,
                    color: AppColors.white,
                    fontFamily: 'LilitaOne',
                  ),
                ),
                const SizedBox(height: 40),
                ActionButton(
                  title: 'play',
                  onPressed: () => {
                    game.overlays.remove(MainMenu.id),
                    game.startGame(),
                  },
                ),
                const SizedBox(height: 10),
                ActionButton(
                  title: 'INSTRUCTIONS',
                  customColor: AppColors.green,
                  onPressed: () {
                    game.overlays.remove(MainMenu.id);
                    game.overlays.add(InstructionsOverlay.id);
                  },
                ),
                const SizedBox(height: 30),
                const LogoutButton(),
              ],
            ),
          ),
        ));
  }
}
