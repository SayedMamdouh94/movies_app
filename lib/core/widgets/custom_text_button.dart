import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/helpers/extensions/context_extenstions.dart';
import 'package:movies_app/core/widgets/custom_text.dart';

import '../style/app_colors.dart';

class CustomTextButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? text;
  final Color textColor;
  final Widget? child;
  final TextAlign? textAlign;
  final double? fontSize;
  final FontWeight? fontWeight;
  const CustomTextButton({
    super.key,
    required this.onPressed,
    this.text,
    this.textColor = AppColors.kPrimary,
    this.child,
    this.textAlign,
    this.fontSize,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        overlayColor: WidgetStatePropertyAll(
          textColor.withValues(alpha: 0.1),
        ),
        padding: WidgetStatePropertyAll(
          EdgeInsets.symmetric(
            horizontal: 3.w,
            vertical: 3.h,
          ),
        ),
        shape: const WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
      ),
      child: child ??
          CustomText(
            text ?? '',
            color: textColor,
            style: context.textTheme.bodySmall,
            fontWeight: fontWeight ?? FontWeight.bold,
            textAlign: textAlign,
          ),
    );
  }
}
