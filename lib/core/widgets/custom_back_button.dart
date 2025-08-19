import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/helpers/extensions/context_extenstions.dart';
import 'package:movies_app/core/helpers/extensions/widget_extensions.dart';

import '../style/app_colors.dart';
import 'custom_tap.dart';

class CustomBackButton extends StatelessWidget {
  final double radius;
  final VoidCallback? onTap;
  const CustomBackButton({
    super.key,
    this.radius = 22,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTap(
      onTap: () {
        if (onTap != null) {
          onTap!();
        } else {
          context.pop();
        }
      },
      child: CircleAvatar(
        radius: radius,
        backgroundColor: AppColors.kGray500,
        child: const Icon(
          CupertinoIcons.back,
          color: AppColors.kWhite,
          size: 20,
        ),
      ).paddingSymmetric(
        horizontal: 8.w,
      ),
    );
  }
}
