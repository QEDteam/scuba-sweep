import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_flutter_app/data/providers/auth_provider.dart';
import 'package:my_flutter_app/game/game/my_game.dart';

class MainMenu extends ConsumerWidget {
  static const id = 'MainMenu';
  final MyGame game;

  const MainMenu(this.game, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                  const Text(
                    'SqubaSweep ',
                    style: TextStyle(
                      fontSize: 50,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      game.overlays.remove(MainMenu.id);
                      game.startGame();
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Play',
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () => ref.read(signInProvider.notifier).signOut(),
                    child: const Text(
                      'Sign out',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
