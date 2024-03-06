import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:scuba_sweep/game/helper/colors.dart';

class TextInputField extends StatelessWidget {
  const TextInputField({
    super.key,
    required this.controller,
  });
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5.0, left: 5),
          child: const Text(
            "login.choose",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ).tr(),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              controller: controller,
              style: const TextStyle(
                  color: AppColors.primary,
                  fontFamily: 'LilitaOne',
                  fontSize: 20),
              decoration: InputDecoration(
                border: InputBorder.none,
                focusColor: AppColors.primary,
                hintText: "login.nickname".tr(),
                hintStyle: const TextStyle(
                  color: AppColors.background,
                  fontFamily: 'LilitaOne',
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
