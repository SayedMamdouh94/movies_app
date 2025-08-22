import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/style/app_colors.dart';
import 'package:movies_app/core/style/app_font_weight.dart';
import 'package:movies_app/features/person_details/presentation/ui/widgets/person_details_name_chip.dart';

class PersonDetailsKnownAsSection extends StatelessWidget {
  const PersonDetailsKnownAsSection({super.key, required this.alsoKnownAs});

  final List<String> alsoKnownAs;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: AppColors.kSecondary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                Icons.badge_outlined,
                size: 20.sp,
                color: AppColors.kSecondary,
              ),
            ),
            SizedBox(width: 12.w),
            Text(
              'Also Known As',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: AppFontWeight.medium,
                color: AppColors.kGray600,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: alsoKnownAs
              .map((name) => PersonDetailsNameChip(name: name))
              .toList(),
        ),
      ],
    );
  }
}
