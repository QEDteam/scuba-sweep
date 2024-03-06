import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scuba_sweep/data/providers/auth_provider.dart';
import 'package:scuba_sweep/game/helper/colors.dart';

class LogoutButton extends ConsumerWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: AppColors.buttonBottom,
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.white,
              width: 1,
            ),
          ),
          child: const Icon(
            Icons.arrow_back_rounded,
            color: AppColors.white,
            size: 15,
          ),
        ),
        TextButton(
            onPressed: () => ref.read(signInProvider.notifier).signOut(),
            child: const Text(
              'logout',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 18,
                fontFamily: "LilitaOne",
              ),
            ).tr()),
      ],
    );
  }
}