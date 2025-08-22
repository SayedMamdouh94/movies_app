import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/style/app_colors.dart';
import 'package:movies_app/core/widgets/custom_shimmer.dart';

class PersonDetailsImagesGridLoading extends StatelessWidget {
  const PersonDetailsImagesGridLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PersonDetailsImagesHeaderLoading(),
        SizedBox(height: 16.h),
        PersonDetailsImagesGridLoadingView(),
      ],
    );
  }
}

class PersonDetailsImagesHeaderLoading extends StatelessWidget {
  const PersonDetailsImagesHeaderLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomShimmer(
          width: 24.w,
          height: 24.h,
          shapeBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),
        SizedBox(width: 8.w),
        CustomShimmer(
          width: 80.w,
          height: 20.h,
          shapeBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),
        SizedBox(width: 8.w),
        CustomShimmer(
          width: 30.w,
          height: 16.h,
          shapeBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
      ],
    );
  }
}

class PersonDetailsImagesGridLoadingView extends StatelessWidget {
  const PersonDetailsImagesGridLoadingView({super.key});

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
      itemCount: 6, // Show 6 loading items
      itemBuilder: (context, index) {
        return PersonDetailsImageLoadingItem();
      },
    );
  }
}

class PersonDetailsImageLoadingItem extends StatelessWidget {
  const PersonDetailsImageLoadingItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: AppColors.kGray100,
      ),
      child: CustomShimmer(
        width: double.infinity,
        height: double.infinity,
        shapeBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
    );
  }
}
