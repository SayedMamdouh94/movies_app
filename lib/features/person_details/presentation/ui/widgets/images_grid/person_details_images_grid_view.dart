import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/features/person_details/data/models/person_images_response_model.dart';
import 'package:movies_app/features/person_details/presentation/ui/widgets/images_grid/person_details_image_item.dart';

class PersonDetailsImagesGridView extends StatelessWidget {
  const PersonDetailsImagesGridView({super.key, required this.images});

  final List<PersonImageModel> images;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
        childAspectRatio: 0.75,
      ),
      itemCount: images.length,
      itemBuilder: (context, index) {
        return PersonDetailsImageItem(
          image: images[index],
          index: index,
          allImages: images,
        );
      },
    );
  }
}
