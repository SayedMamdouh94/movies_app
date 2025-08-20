import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/helpers/extensions/context_extenstions.dart';
import 'package:movies_app/core/style/app_colors.dart';
import 'package:movies_app/core/style/app_font_weight.dart';
import 'package:movies_app/core/widgets/custom_text.dart';
import 'package:movies_app/features/person_details/data/models/person_details_response_model.dart';

class PersonDetailsBiographySection extends StatelessWidget {
  const PersonDetailsBiographySection({super.key, required this.personDetails});

  final PersonDetailsResponseModel personDetails;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          'Biography',
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: AppFontWeight.bold,
            color: AppColors.kPrimary,
          ),
        ),
        SizedBox(height: 16.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: AppColors.kGray50,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.kGray200, width: 1),
          ),
          child: CustomText(
            personDetails.biography,
            style: context.textTheme.bodyMedium!.copyWith(
              color: AppColors.kGray800,
              height: 1.6,
            ),
          ),
        ),
      ],
    );
  }
}
