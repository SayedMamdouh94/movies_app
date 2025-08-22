import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/helpers/extensions/context_extenstions.dart';
import 'package:movies_app/core/networking/tmdb_api_constants.dart';
import 'package:movies_app/core/services/image_save_service.dart';
import 'package:movies_app/core/style/app_colors.dart';
import 'package:movies_app/core/widgets/custom_text.dart';
import 'package:movies_app/features/person_details/data/models/person_images_response_model.dart';

class PersonDetailsImageOverlay extends StatelessWidget {
  const PersonDetailsImageOverlay({super.key, required this.image});

  final PersonImageModel image;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              AppColors.kBlack.withValues(alpha: 0.7),
            ],
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PersonDetailsImageResolution(image: image),
            Row(
              children: [
                if (image.voteCount > 0) PersonDetailsImageRating(image: image),
                SizedBox(width: 8.w),
                IconButton(
                  onPressed: () => _saveImage(context),
                  icon: Icon(
                    Icons.download,
                    color: AppColors.kWhite,
                    size: 20.sp,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(minWidth: 24.w, minHeight: 24.h),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _saveImage(BuildContext context) {
    final imageUrl = TmdbApiConstants.getImageUrl(
      image.filePath,
      size: 'original',
    );

    ImageSaveService.saveImageFromUrl(imageUrl: imageUrl, context: context);
  }
}

class PersonDetailsImageResolution extends StatelessWidget {
  const PersonDetailsImageResolution({super.key, required this.image});

  final PersonImageModel image;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: AppColors.kBlack.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: CustomText(
        '${image.width}×${image.height}',
        style: context.textTheme.bodySmall!.copyWith(
          color: AppColors.kWhite,
          fontSize: 10.sp,
        ),
      ),
    );
  }
}

class PersonDetailsImageRating extends StatelessWidget {
  const PersonDetailsImageRating({super.key, required this.image});

  final PersonImageModel image;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: AppColors.kSecondary.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.star, size: 10.sp, color: AppColors.kWhite),
          SizedBox(width: 2.w),
          CustomText(
            image.voteAverage.toStringAsFixed(1),
            style: context.textTheme.bodySmall!.copyWith(
              color: AppColors.kWhite,
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
