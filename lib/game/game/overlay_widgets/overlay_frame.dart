import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:scuba_sweep/game/helper/colors.dart';

class OverlayFrame extends StatelessWidget {
  const OverlayFrame({super.key, required this.child, this.bottomWidget});
  final Widget child;
  final Widget? bottomWidget;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.primaryLight, width: 3),
                    color: AppColors.cardColor.withAlpha(180),
                    borderRadius: BorderRadius.circular(20)),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 30),
                    child: child,
                  ),
                ),
              ),
            ),
            if (bottomWidget != null)
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: bottomWidget!,
              ),
          ],
        ),
      ),
    );
  }
}
