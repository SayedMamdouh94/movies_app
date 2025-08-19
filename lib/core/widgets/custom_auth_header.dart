import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/helpers/extensions/context_extenstions.dart';
import 'package:movies_app/core/helpers/extensions/widget_extensions.dart';
import 'package:movies_app/core/style/app_font_weight.dart';
import 'package:movies_app/core/widgets/custom_text.dart';

class CustomAuthHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  const CustomAuthHeader({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10.h,
      children: [
        CustomText(
          title,
          style: context.textTheme.titleLarge,
          color: Colors.white,
          height: 1.2,
        ),
        CustomText(
          subtitle,
          textAlign: TextAlign.center,
          color: Colors.white,
          style: context.textTheme.bodySmall,
          height: 1.4,
          fontWeight: AppFontWeight.medium,
        ),
      ],
    ).paddingOnly(
      top: context.mediaQuery.padding.top + 24.h,
      bottom: 24.h,
      start: 10.w,
      end: 10.w,
    );
  }
}
