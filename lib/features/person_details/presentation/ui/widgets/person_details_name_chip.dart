import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/style/app_colors.dart';
import 'package:movies_app/core/style/app_font_weight.dart';

class PersonDetailsNameChip extends StatelessWidget {
  const PersonDetailsNameChip({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AppColors.kGray100,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.kGray300, width: 1),
      ),
      child: Text(
        name,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: AppFontWeight.medium,
          color: AppColors.kGray700,
        ),
      ),
    );
  }
}
