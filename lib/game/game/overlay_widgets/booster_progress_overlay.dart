import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scuba_sweep/game/game/my_game.dart';

class BoosterProgressOverlay extends ConsumerStatefulWidget {
  static const id = 'BoosterProgressOverlay';
  final MyGame game;

  const BoosterProgressOverlay(this.game, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BoosterProgressOverlayState();
}

class _BoosterProgressOverlayState extends ConsumerState<BoosterProgressOverlay>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 3800),
      vsync: this,
    );

    _animation = Tween<double>(
      begin: 1.0, // 100%
      end: 0.0, // 0%
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.game.player.hasShield && !_controller.isAnimating) {
      _controller.forward();
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Container(
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  minHeight: 20,
                  value: _animation.value,
                  backgroundColor: Color.fromARGB(255, 62, 74, 128),
                  valueColor: const AlwaysStoppedAnimation<Color>(
                      Color.fromARGB(255, 92, 182, 255)),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
