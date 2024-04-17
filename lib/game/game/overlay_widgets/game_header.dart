import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scuba_sweep/data/providers/score_provider.dart';
import 'package:scuba_sweep/game/game/my_game.dart';
import 'package:scuba_sweep/game/helper/styles.dart';

class GameHeader extends ConsumerStatefulWidget {
  static const id = 'GameHeader';
  final MyGame game;

  const GameHeader(this.game, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GameHeaderState();
}

class _GameHeaderState extends ConsumerState<GameHeader>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      lowerBound: 18,
      upperBound: 28,
      vsync: this,
      duration: const Duration(
        milliseconds: 300,
      ),
    );
    _controller.addListener(() {
      try {
        setState(() {});
      } catch (_) {}
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(scoreNotifierProvider, (previous, next) {
      if (previous?.score != next.score) {
        _controller
            .forward(from: 16.0)
            .whenComplete(() => _controller.reverse());
      }
    });

    final currentScore = ref.watch(scoreNotifierProvider).score;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
      child: Align(
        alignment: Alignment.topCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  'Score:',
                  style: subtitleStyle,
                ),
                const SizedBox(width: 5),
                Text(
                  currentScore.toString(),
                  style: subtitleStyle.copyWith(fontSize: _controller.value),
                )
              ],
            ),
            Material(
              color: Colors.transparent,
              child: IconButton(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                onPressed: () {
                  widget.game.pauseEngine();
                },
                icon: const Icon(
                  Icons.pause,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
