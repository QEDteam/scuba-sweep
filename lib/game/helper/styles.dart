import 'package:flutter/material.dart';
import 'package:scuba_sweep/game/helper/colors.dart';

TextStyle titleTextStyle = const TextStyle(
  shadows: [
    Shadow(
      color: AppColors.primary,
      blurRadius: 3,
    )
  ],
  fontSize: 40,
  color: AppColors.white,
  fontFamily: 'LilitaOne',
);

TextStyle subtitleStyle = const TextStyle(
  fontSize: 18,
  color: AppColors.white,
  fontWeight: FontWeight.bold,
);

TextStyle exitTextstyle = const TextStyle(
  shadows: [
    Shadow(
      color: AppColors.primary,
      blurRadius: 8,
    )
  ],
  color: AppColors.white,
  fontSize: 20,
  fontFamily: "LilitaOne",
);
