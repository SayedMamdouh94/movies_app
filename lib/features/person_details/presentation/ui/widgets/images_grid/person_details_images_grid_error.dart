import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/helpers/extensions/context_extenstions.dart';
import 'package:movies_app/core/style/app_colors.dart';
import 'package:movies_app/core/widgets/custom_text.dart';

class PersonDetailsImagesGridError extends StatelessWidget {
  const PersonDetailsImagesGridError({
    super.key,
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback? onRetry;

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
          PersonDetailsImagesErrorIcon(),
          SizedBox(height: 16.h),
          PersonDetailsImagesErrorMessage(message: message),
          if (onRetry != null) ...[
            SizedBox(height: 16.h),
            PersonDetailsImagesRetryButton(onRetry: onRetry!),
          ],
        ],
      ),
    );
  }
}

class PersonDetailsImagesErrorIcon extends StatelessWidget {
  const PersonDetailsImagesErrorIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60.w,
      height: 60.h,
      decoration: BoxDecoration(
        color: AppColors.kError.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.photo_library_outlined,
        size: 30.sp,
        color: AppColors.kError,
      ),
    );
  }
}

class PersonDetailsImagesErrorMessage extends StatelessWidget {
  const PersonDetailsImagesErrorMessage({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          CustomText(
            'Failed to load photos',
            style: context.textTheme.bodyMedium!.copyWith(
              color: AppColors.kGray900,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4.h),
          CustomText(
            message,
            style: context.textTheme.bodySmall!.copyWith(
              color: AppColors.kGray600,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}

class PersonDetailsImagesRetryButton extends StatelessWidget {
  const PersonDetailsImagesRetryButton({super.key, required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onRetry,
      icon: Icon(Icons.refresh, size: 16.sp, color: AppColors.kSecondary),
      label: CustomText(
        'Try Again',
        style: context.textTheme.bodySmall!.copyWith(
          color: AppColors.kSecondary,
          fontWeight: FontWeight.w600,
        ),
      ),
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      ),
    );
  }
}
