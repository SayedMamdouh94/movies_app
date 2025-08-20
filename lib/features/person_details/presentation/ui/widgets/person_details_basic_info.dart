import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/style/app_colors.dart';
import 'package:movies_app/core/style/app_font_weight.dart';
import 'package:movies_app/features/person_details/data/models/person_details_response_model.dart';
import 'package:movies_app/features/person_details/presentation/ui/widgets/person_details_info_row.dart';

class PersonDetailsBasicInfo extends StatelessWidget {
  const PersonDetailsBasicInfo({super.key, required this.personDetails});

  final PersonDetailsResponseModel personDetails;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Basic Information',
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: AppFontWeight.bold,
            color: AppColors.kPrimary,
          ),
        ),
        SizedBox(height: 16.h),
        PersonDetailsInfoRow(
          label: 'Known For',
          value: personDetails.knownForDepartment,
          icon: Icons.work_outline,
        ),
        PersonDetailsInfoRow(
          label: 'Gender',
          value: personDetails.gender == 1 ? 'Female' : 'Male',
          icon: Icons.person_outline,
        ),
        if (personDetails.birthday != null)
          PersonDetailsInfoRow(
            label: 'Birthday',
            value: personDetails.birthday!,
            icon: Icons.cake_outlined,
          ),
        if (personDetails.placeOfBirth != null)
          PersonDetailsInfoRow(
            label: 'Place of Birth',
            value: personDetails.placeOfBirth!,
            icon: Icons.location_on_outlined,
          ),
      ],
    );
  }
}
