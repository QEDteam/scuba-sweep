import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scuba_sweep/game/game/my_game.dart';
import 'package:scuba_sweep/game/game/overlay_widgets/main_menu.dart';
import 'package:scuba_sweep/game/game/overlay_widgets/overlay_frame.dart';
import 'package:scuba_sweep/game/helper/enums.dart';
import 'package:scuba_sweep/game/helper/styles.dart';
import 'package:scuba_sweep/screens/widgets/action_button.dart';

class InstructionsOverlay extends StatelessWidget {
  static const id = 'InstructionsOverlay';
  final MyGame game;
  const InstructionsOverlay(this.game, {super.key});

  @override
  Widget build(BuildContext context) {
    return OverlayFrame(
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 80,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'instructions.title',
              style: titleTextStyle,
            ).tr(),
            const SizedBox(height: 40),
            Text(
              'instructions.drag',
              style: titleTextStyle.copyWith(fontSize: 24),
            ).tr(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    'assets/images/player.png',
                    height: 80,
                  ),
                  SvgPicture.asset(
                    'assets/images/path.svg',
                    width: 120,
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: SvgPicture.asset(
                      'assets/images/hand.svg',
                      height: 40,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              'instructions.avoid',
              style: titleTextStyle.copyWith(fontSize: 24),
            ).tr(),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: Enemy.values
                  .map((e) => Image.asset(
                        'assets/images/${e.imagePath}',
                        height: 65,
                      ))
                  .toList(),
            ),
            const SizedBox(height: 30),
            Text(
              'instructions.collect',
              style: titleTextStyle.copyWith(fontSize: 24),
            ).tr(),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.asset(
                'assets/images/pearl.png',
                width: 70,
              ),
            ),
            ActionButton(
                title: 'dive_in',
                onPressed: () {
                  game.overlays.remove(InstructionsOverlay.id);
                  game.overlays.add(MainMenu.id);
                }),
          ],
        ),
      ),
    );
  }
}
