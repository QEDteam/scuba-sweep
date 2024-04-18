import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scuba_sweep/game/game/my_game.dart';
import 'package:scuba_sweep/game/helper/colors.dart';
import 'package:scuba_sweep/game/helper/styles.dart';

class SoundToggle extends ConsumerStatefulWidget {
  final MyGame game;
  const SoundToggle(this.game, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SoundToggleState();
}

class _SoundToggleState extends ConsumerState<SoundToggle> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Sound:',
          style: subtitleStyle,
        ),
        const SizedBox(width: 10),
        Switch(
          value: widget.game.audioManager.audioOn,
          onChanged: (value) {
            widget.game.audioManager.toggleAudio();
            setState(() {});
          },
          activeColor: AppColors.buttonTop,
          activeTrackColor: Colors.white.withAlpha(230),
        ),
      ],
    );
  }
}
