import 'package:flutter/material.dart';
import 'package:movies_app/core/router/app_navigator.dart';
import 'package:movies_app/core/style/app_colors.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../style/app_font_weight.dart';

void showSnackBar(String message, {bool isError = false}) {
  final overlayState =
      Navigator.of(navigator.currentContext!, rootNavigator: true).overlay;

  showTopSnackBar(
    overlayState!,
    isError
        ? CustomSnackBar.error(
            message: message,
            backgroundColor: AppColors.kError,
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: AppFontWeight.semiBold,
            ),
          )
        : CustomSnackBar.success(
            message: message,
            backgroundColor: AppColors.kSuccess,
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: AppFontWeight.semiBold,
            ),
          ),
    displayDuration: const Duration(seconds: 3),
    animationDuration: const Duration(milliseconds: 1200),
    reverseAnimationDuration: const Duration(milliseconds: 1200),
    dismissType: DismissType.onSwipe,
  );
}
