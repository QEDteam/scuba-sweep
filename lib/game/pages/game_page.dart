
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_flutter_app/game/game/my_game.dart';
import 'package:my_flutter_app/game/game/widgets/game_header.dart';
import 'package:my_flutter_app/game/game/widgets/game_over_menu.dart';
import 'package:my_flutter_app/game/game/widgets/main_menu.dart';
import 'package:my_flutter_app/game/game/widgets/pause_menu.dart';

class GamePage extends ConsumerWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GameWidget.controlled(
      loadingBuilder: (conetxt) => const Center(
        child: SizedBox(
          width: 200,
          child: LinearProgressIndicator(),
        ),
      ),
      gameFactory: () => MyGame(context, ref),
      overlayBuilderMap: {
        MainMenu.id: (_, MyGame game) => MainMenu(game),
        PauseMenu.id: (_, MyGame game) => PauseMenu(game),
        GameOverMenu.id: (_, MyGame game) => GameOverMenu(game),
        GameHeader.id: (_, MyGame game) => GameHeader(game),
      },
      initialActiveOverlays: const [MainMenu.id],
    );
  }
}
