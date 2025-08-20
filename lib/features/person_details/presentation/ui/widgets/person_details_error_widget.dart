import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/helpers/extensions/context_extenstions.dart';
import 'package:movies_app/core/style/app_colors.dart';
import 'package:movies_app/core/style/app_font_weight.dart';
import 'package:movies_app/core/widgets/custom_text.dart';

class PersonDetailsErrorWidget extends StatelessWidget {
  const PersonDetailsErrorWidget({
    super.key,
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PersonDetailsErrorIcon(),
          SizedBox(height: 24.h),
          PersonDetailsErrorMessage(message: message),
          if (onRetry != null) ...[
            SizedBox(height: 32.h),
            PersonDetailsRetryButton(onRetry: onRetry!),
          ],
        ],
      ),
    );
  }
}

class PersonDetailsErrorIcon extends StatelessWidget {
  const PersonDetailsErrorIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.w,
      height: 80.h,
      decoration: BoxDecoration(
        color: AppColors.kError.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(Icons.error_outline, size: 40.sp, color: AppColors.kError),
    );
  }
}

class PersonDetailsErrorMessage extends StatelessWidget {
  const PersonDetailsErrorMessage({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomText(
          'Oops! Something went wrong',
          style: context.textTheme.titleSmall!.copyWith(
            color: AppColors.kGray900,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 8.h),
        CustomText(
          message,
          style: context.textTheme.bodyMedium!.copyWith(
            color: AppColors.kGray600,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class PersonDetailsRetryButton extends StatelessWidget {
  const PersonDetailsRetryButton({super.key, required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onRetry,
      icon: Icon(Icons.refresh, size: 20.sp),
      label: CustomText(
        'Try Again',
        style: context.textTheme.bodyMedium!.copyWith(
          fontWeight: AppFontWeight.semiBold,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.kSecondary,
        foregroundColor: AppColors.kWhite,
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
    );
  }
}
