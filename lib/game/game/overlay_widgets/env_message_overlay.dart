import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scuba_sweep/data/providers/message_provider.dart';
import 'package:scuba_sweep/game/game/my_game.dart';
import 'package:scuba_sweep/game/game/overlay_widgets/game_over_menu.dart';
import 'package:scuba_sweep/game/game/overlay_widgets/overlay_frame.dart';
import 'package:scuba_sweep/game/helper/colors.dart';
import 'package:scuba_sweep/game/helper/styles.dart';
import 'package:scuba_sweep/screens/widgets/action_button.dart';

class EnvMessageOverlay extends ConsumerWidget {
  static const id = 'EnvMessageOverlay';
  final MyGame game;
  const EnvMessageOverlay(this.game, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(aiMessageNotifierProvider);
    return OverlayFrame(
        child: SizedBox(
      width: MediaQuery.of(context).size.width - 40,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'dive_deeper',
            style: titleTextStyle,
          ).tr(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: state.isLoading
                ? const CircularProgressIndicator(
                    color: AppColors.white,
                  )
                : SizedBox(
                    width: 450,
                    child: Text(
                      textAlign: TextAlign.start,
                      (state.message == '' ? defaultMessage : state.message)
                          .replaceAll('. ', '.\n\n'),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            color: AppColors.primary,
                            blurRadius: 8,
                          )
                        ],
                      ),
                    ),
                  ),
          ),
          ActionButton(
            title: 'continue',
            onPressed: () {
              game.overlays.remove(EnvMessageOverlay.id);
              game.overlays.add(GameOverMenu.id);
            },
          )
        ],
      ),
    ));
  }
}

const String defaultMessage =
    "Let's keep our oceans blue and our planet green. Reduce plastic waste, recycle responsibly, and respect marine habitats. Together, we can preserve the beauty and diversity of marine life for generations to come.";
