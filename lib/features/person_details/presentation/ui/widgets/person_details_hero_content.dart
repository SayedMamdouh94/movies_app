import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/helpers/extensions/context_extenstions.dart';
import 'package:movies_app/core/style/app_colors.dart';
import 'package:movies_app/core/style/app_font_weight.dart';
import 'package:movies_app/core/widgets/custom_text.dart';
import 'package:movies_app/features/person_details/data/models/person_details_response_model.dart';
import 'package:movies_app/features/person_details/presentation/ui/widgets/person_details_popularity_chip.dart';

class PersonDetailsHeroContent extends StatelessWidget {
  const PersonDetailsHeroContent({super.key, required this.personDetails});

  final PersonDetailsResponseModel personDetails;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          personDetails.name,
          style: context.textTheme.titleLarge!.copyWith(
            fontSize: 28.sp,
            color: AppColors.kWhite.withValues(alpha: 0.9),
          ),
        ),

        CustomText(
          personDetails.knownForDepartment,
          style: context.textTheme.bodyMedium!.copyWith(
            fontWeight: AppFontWeight.medium,
            color: AppColors.kWhite.withValues(alpha: 0.9),
          ),
        ),
        PersonDetailsPopularityChip(popularity: personDetails.popularity),
      ],
    );
  }
}
