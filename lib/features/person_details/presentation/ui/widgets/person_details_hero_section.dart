import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/networking/tmdb_api_constants.dart';
import 'package:movies_app/core/style/app_colors.dart';
import 'package:movies_app/features/person_details/data/models/person_details_response_model.dart';
import 'package:movies_app/features/person_details/presentation/ui/widgets/person_details_hero_content.dart';

class PersonDetailsHeroSection extends StatelessWidget {
  const PersonDetailsHeroSection({super.key, required this.personDetails});

  final PersonDetailsResponseModel personDetails;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400.h,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.kPrimary.withValues(alpha: 0.8),
            AppColors.kPrimary.withValues(alpha: 0.3),
          ],
        ),
      ),
      child: Stack(
        children: [
          if (personDetails.profilePath != null)
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    TmdbApiConstants.getProfileUrl(personDetails.profilePath),
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, AppColors.kBlack.withValues(alpha: 0.7)],
              ),
            ),
          ),
          Positioned(
            bottom: 24.h,
            left: 16.w,
            right: 16.w,
            child: PersonDetailsHeroContent(personDetails: personDetails),
          ),
        ],
      ),
    );
  }
}
