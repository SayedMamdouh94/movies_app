import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/features/person_details/data/models/person_details_response_model.dart';
import 'package:movies_app/features/person_details/presentation/ui/widgets/person_details_hero_section.dart';
import 'package:movies_app/features/person_details/presentation/ui/widgets/person_details_basic_info.dart';
import 'package:movies_app/features/person_details/presentation/ui/widgets/person_details_personal_info.dart';
import 'package:movies_app/features/person_details/presentation/ui/widgets/person_details_biography_section.dart';
import 'package:movies_app/features/person_details/presentation/ui/widgets/images_grid/person_details_images_section.dart';

class PersonDetailsContent extends StatelessWidget {
  const PersonDetailsContent({
    super.key,
    required this.personDetails,
    required this.personId,
  });

  final PersonDetailsResponseModel personDetails;
  final int personId;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PersonDetailsHeroSection(personDetails: personDetails),
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              spacing: 24.h,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PersonDetailsBasicInfo(personDetails: personDetails),
                PersonDetailsPersonalInfo(personDetails: personDetails),
                if (personDetails.biography.isNotEmpty) ...[
                  PersonDetailsBiographySection(personDetails: personDetails),
                ],
                PersonDetailsImagesSection(personId: personId),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
