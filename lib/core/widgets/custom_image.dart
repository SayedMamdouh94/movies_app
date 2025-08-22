import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/style/app_colors.dart';
import 'package:movies_app/core/widgets/custom_loading_indicator.dart';

import 'custom_shimmer.dart';

class CustomImage extends StatelessWidget {
  final String? imageUrl;
  final double width;
  final double height;
  final double radius;
  final bool isCircle;
  final bool displayError;
  final BoxFit fit;
  final Color? backgroundColor;
  final bool isLoading;
  final bool hasBorder;
  final Color? borderColor;
  const CustomImage({
    super.key,
    required this.imageUrl,
    this.radius = 12,
    this.width = 100,
    this.height = 100,
    this.isCircle = false,
    this.fit = BoxFit.cover,
    this.displayError = true,
    this.backgroundColor,
    this.isLoading = false,
    this.hasBorder = true,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.kPrimary.withAlpha(26),
            blurRadius: 8,
            spreadRadius: 0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: isCircle
          ? CircleAvatar(
              radius: radius,
              backgroundColor: backgroundColor ?? AppColors.kGray100,
              child: Stack(
                children: [
                  Opacity(
                    opacity: isLoading ? 0.5 : 1,
                    child: _buildImageWidget(),
                  ),
                  if (isLoading) const Center(child: CustomLoadingIndicator()),
                ],
              ),
            )
          : Stack(
              clipBehavior: Clip.none,
              alignment: AlignmentDirectional.center,
              children: [
                Opacity(
                  opacity: isLoading ? 0.5 : 1,
                  child: _buildImageWidget(),
                ),
                if (isLoading) const Center(child: CustomLoadingIndicator()),
              ],
            ),
    );
  }

  Widget _buildImageWidget() => Container(
    width: width.w,
    height: height.h,
    decoration: BoxDecoration(
      color: backgroundColor ?? AppColors.kGray100,
      borderRadius: BorderRadius.circular(radius),
      border: hasBorder
          ? Border.all(color: borderColor ?? AppColors.kGray200, width: 1)
          : null,
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: CachedNetworkImage(
        imageUrl: _buildImageUrl(),
        fit: fit,
        width: width,
        height: height,
        placeholder: (context, url) => const CustomShimmer(),
        errorWidget: (context, url, error) =>
            displayError ? const Icon(Icons.error) : const CustomShimmer(),
      ),
    ),
  );

  String _buildImageUrl() {
    if (imageUrl == null || imageUrl!.isEmpty) return '';

    // If the URL already starts with http or https, use it as is
    if (imageUrl!.startsWith('http://') || imageUrl!.startsWith('https://')) {
      return imageUrl!;
    }

    // For relative URLs, you might want to add a base URL
    // For now, returning as is for compatibility
    return imageUrl!;
  }
}
