import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_flutter_app/data/providers/message_provider.dart';
import 'package:my_flutter_app/game/game/my_game.dart';
import 'package:my_flutter_app/game/game/widgets/game_over_menu.dart';

class EnvMessageOverlay extends ConsumerWidget {
  static const id = 'EnvMessageOverlay';
  final MyGame game;
  const EnvMessageOverlay(this.game, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(aiMessageNotifierProvider);
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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: state.isLoading ? const CircularProgressIndicator()
                      : SizedBox(
                          width: 400,
                          child: Text(
                            textAlign: TextAlign.center,
                            state.message,
                            style: const TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                            ),
                          ),
                        ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      game.overlays.remove(EnvMessageOverlay.id);
                      game.overlays.add(GameOverMenu.id);
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Continue',
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
