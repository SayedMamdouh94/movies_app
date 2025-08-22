import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/helpers/extensions/context_extenstions.dart';
import 'package:movies_app/core/style/app_colors.dart';
import 'package:movies_app/core/widgets/custom_text.dart';
import 'package:movies_app/features/person_details/data/models/person_images_response_model.dart';
import 'package:movies_app/features/person_details/presentation/ui/widgets/images_grid/person_details_images_grid_view.dart';

class PersonDetailsImagesGrid extends StatelessWidget {
  const PersonDetailsImagesGrid({super.key, required this.personImages});

  final PersonImagesResponseModel personImages;

  @override
  Widget build(BuildContext context) {
    if (personImages.profiles.isEmpty) {
      return PersonDetailsImagesEmptyState();
    }

    return Column(
      spacing: 16.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PersonDetailsImagesHeader(imageCount: personImages.profiles.length),
        PersonDetailsImagesGridView(images: personImages.profiles),
      ],
    );
  }
}

class PersonDetailsImagesHeader extends StatelessWidget {
  const PersonDetailsImagesHeader({super.key, required this.imageCount});

  final int imageCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8.w,
      children: [
        Icon(
          Icons.photo_library_outlined,
          size: 24.sp,
          color: AppColors.kPrimary,
        ),
        CustomText(
          'Photos',
          style: context.textTheme.titleMedium!.copyWith(
            color: AppColors.kPrimary,
          ),
        ),
        PersonDetailsImagesCountChip(count: imageCount),
      ],
    );
  }
}

class PersonDetailsImagesCountChip extends StatelessWidget {
  const PersonDetailsImagesCountChip({super.key, required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColors.kSecondary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: CustomText(
        count.toString(),
        style: context.textTheme.bodySmall!.copyWith(
          color: AppColors.kSecondary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class PersonDetailsImagesEmptyState extends StatelessWidget {
  const PersonDetailsImagesEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.kGray50,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.kGray200),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.photo_outlined, size: 48.sp, color: AppColors.kGray400),
          SizedBox(height: 16.h),
          CustomText(
            'No photos available',
            style: context.textTheme.bodyMedium!.copyWith(
              color: AppColors.kGray600,
            ),
          ),
        ],
      ),
    );
  }
}
