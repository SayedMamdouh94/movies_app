import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/style/app_colors.dart';
import 'package:movies_app/core/style/app_font_weight.dart';

class PersonDetailsPopularityChip extends StatelessWidget {
  const PersonDetailsPopularityChip({super.key, required this.popularity});

  final double popularity;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AppColors.kSecondary,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.star, size: 16.sp, color: AppColors.kWhite),
          SizedBox(width: 4.w),
          Text(
            '${popularity.toStringAsFixed(1)} Popularity',
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: AppFontWeight.semiBold,
              color: AppColors.kWhite,
            ),
          ),
        ],
      ),
    );
  }
}
