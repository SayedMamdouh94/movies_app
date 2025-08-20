import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/style/app_colors.dart';

class PersonDetailsLoadingWidget extends StatelessWidget {
  const PersonDetailsLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile section loading
          Container(
            height: 400.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.kGray200,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.kSecondary),
              ),
            ),
          ),
          SizedBox(height: 24.h),

          // Name loading
          _buildShimmerBox(width: 200.w, height: 28.h),
          SizedBox(height: 8.h),

          // Department loading
          _buildShimmerBox(width: 150.w, height: 20.h),
          SizedBox(height: 24.h),

          // Info section loading
          _buildShimmerBox(width: 120.w, height: 24.h),
          SizedBox(height: 16.h),

          // Info items loading
          ...List.generate(
            4,
            (index) => Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: Row(
                children: [
                  _buildShimmerBox(width: 80.w, height: 16.h),
                  SizedBox(width: 12.w),
                  _buildShimmerBox(width: 120.w, height: 16.h),
                ],
              ),
            ),
          ),

          SizedBox(height: 24.h),

          // Biography section loading
          _buildShimmerBox(width: 100.w, height: 24.h),
          SizedBox(height: 16.h),

          // Biography content loading
          ...List.generate(
            6,
            (index) => Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: _buildShimmerBox(width: double.infinity, height: 16.h),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerBox({required double width, required double height}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.kGray200,
        borderRadius: BorderRadius.circular(8.r),
      ),
    );
  }
}
