import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/networking/tmdb_api_constants.dart';
import 'package:movies_app/core/widgets/custom_image.dart';
import 'package:movies_app/core/widgets/custom_text.dart';
import 'package:movies_app/features/popular_people/data/models/popular_people_response_model.dart';

class PopularPeoplePersonCard extends StatelessWidget {
  final PopularPersonModel person;
  final VoidCallback? onTap;

  const PopularPeoplePersonCard({super.key, required this.person, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            spacing: 12.w,
            children: [
              PopularPeoplePersonAvatar(person: person),
              Expanded(child: PopularPeoplePersonInfo(person: person)),
              PopularPeoplePersonRating(person: person),
            ],
          ),
        ),
      ),
    );
  }
}

class PopularPeoplePersonAvatar extends StatelessWidget {
  final PopularPersonModel person;

  const PopularPeoplePersonAvatar({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    return CustomImage(
      imageUrl: TmdbApiConstants.getProfileUrl(person.profilePath),
      width: 60,
      height: 60,
      radius: 30,
      isCircle: true,
      fit: BoxFit.cover,
    );
  }
}

class PopularPeoplePersonInfo extends StatelessWidget {
  final PopularPersonModel person;

  const PopularPeoplePersonInfo({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 4.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(person.name, maxLines: 1, overflow: TextOverflow.ellipsis),
      
        CustomText(
          person.knownForDepartment,
          fontSize: 14,
          color: Colors.grey[600],
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        PopularPeoplePersonKnownFor(person: person),
      ],
    );
  }
}

class PopularPeoplePersonKnownFor extends StatelessWidget {
  final PopularPersonModel person;

  const PopularPeoplePersonKnownFor({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    if (person.knownFor.isEmpty) {
      return const SizedBox.shrink();
    }

    final knownForTitles = person.knownFor
        .take(2)
        .map((item) => item.title ?? item.name ?? '')
        .where((title) => title.isNotEmpty)
        .join(', ');

    if (knownForTitles.isEmpty) {
      return const SizedBox.shrink();
    }

    return CustomText(
      'Known for: $knownForTitles',
      fontSize: 12,
      color: Colors.grey[500],
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class PopularPeoplePersonRating extends StatelessWidget {
  final PopularPersonModel person;

  const PopularPeoplePersonRating({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _getRatingColor(person.popularity),
        borderRadius: BorderRadius.circular(8),
      ),
      child: CustomText(
        person.popularity.toStringAsFixed(1),
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    );
  }

  Color _getRatingColor(double popularity) {
    if (popularity >= 100) return Colors.green;
    if (popularity >= 50) return Colors.orange;
    return Colors.red;
  }
}
