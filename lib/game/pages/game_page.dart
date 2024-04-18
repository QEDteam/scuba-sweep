import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scuba_sweep/game/game/my_game.dart';
import 'package:scuba_sweep/game/game/overlay_widgets/booster_progress_overlay.dart';
import 'package:scuba_sweep/game/game/overlay_widgets/env_message_overlay.dart';
import 'package:scuba_sweep/game/game/overlay_widgets/game_header.dart';
import 'package:scuba_sweep/game/game/overlay_widgets/game_over_menu.dart';
import 'package:scuba_sweep/game/game/overlay_widgets/instructions_overlay.dart';
import 'package:scuba_sweep/game/game/overlay_widgets/leaderboard_overlay.dart';
import 'package:scuba_sweep/game/game/overlay_widgets/main_menu.dart';
import 'package:scuba_sweep/game/game/overlay_widgets/pause_menu.dart';

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
        EnvMessageOverlay.id: (_, MyGame game) => EnvMessageOverlay(game),
        LeaderBoardOverlay.id: (_, MyGame game) => LeaderBoardOverlay(game),
        InstructionsOverlay.id: (_, MyGame game) => InstructionsOverlay(game),
        BoosterProgressOverlay.id: (_, MyGame game) => BoosterProgressOverlay(game),
      },
      initialActiveOverlays: const [MainMenu.id],
    );
  }
}
