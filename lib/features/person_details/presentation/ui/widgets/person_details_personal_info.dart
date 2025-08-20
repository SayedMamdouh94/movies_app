import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/style/app_colors.dart';
import 'package:movies_app/core/style/app_font_weight.dart';
import 'package:movies_app/features/person_details/data/models/person_details_response_model.dart';
import 'package:movies_app/features/person_details/presentation/ui/widgets/person_details_info_row.dart';
import 'package:movies_app/features/person_details/presentation/ui/widgets/person_details_known_as_section.dart';

class PersonDetailsPersonalInfo extends StatelessWidget {
  const PersonDetailsPersonalInfo({super.key, required this.personDetails});

  final PersonDetailsResponseModel personDetails;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Personal Details',
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: AppFontWeight.bold,
            color: AppColors.kPrimary,
          ),
        ),
        SizedBox(height: 16.h),
        if (personDetails.deathday != null)
          PersonDetailsInfoRow(
            label: 'Death Date',
            value: personDetails.deathday!,
            icon: Icons.event_busy_outlined,
          ),
        if (personDetails.homepage != null &&
            personDetails.homepage!.isNotEmpty)
          PersonDetailsInfoRow(
            label: 'Homepage',
            value: personDetails.homepage!,
            icon: Icons.language_outlined,
          ),
        if (personDetails.alsoKnownAs.isNotEmpty)
          PersonDetailsKnownAsSection(alsoKnownAs: personDetails.alsoKnownAs),
      ],
    );
  }
}
