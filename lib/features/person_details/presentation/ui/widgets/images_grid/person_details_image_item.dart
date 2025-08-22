import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/networking/tmdb_api_constants.dart';
import 'package:movies_app/core/style/app_colors.dart';
import 'package:movies_app/core/widgets/custom_image.dart';
import 'package:movies_app/core/widgets/custom_tap.dart';
import 'package:movies_app/features/person_details/data/models/person_images_response_model.dart';
import 'package:movies_app/features/person_details/presentation/ui/widgets/images_grid/person_details_image_overlay.dart';
import 'package:movies_app/features/person_details/presentation/ui/widgets/images_grid/person_details_photo_gallery.dart';

class PersonDetailsImageItem extends StatelessWidget {
  const PersonDetailsImageItem({
    super.key,
    required this.image,
    required this.index,
    required this.allImages,
  });

  final PersonImageModel image;
  final int index;
  final List<PersonImageModel> allImages;

  @override
  Widget build(BuildContext context) {
    return CustomTap(
      onTap: () => _onImageTap(context),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.kBlack.withValues(alpha: 0.1),
              offset: Offset(0, 2.h),
              blurRadius: 8.r,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: Stack(
            children: [
              PersonDetailsImageContent(image: image),
              PersonDetailsImageOverlay(image: image),
            ],
          ),
        ),
      ),
    );
  }

  void _onImageTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            PersonDetailsPhotoGallery(images: allImages, initialIndex: index),
      ),
    );
  }
}

class PersonDetailsImageContent extends StatelessWidget {
  const PersonDetailsImageContent({super.key, required this.image});

  final PersonImageModel image;

  @override
  Widget build(BuildContext context) {
    return CustomImage(
      imageUrl: TmdbApiConstants.getImageUrl(image.filePath),
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
      radius: 0,
    );
  }
}
