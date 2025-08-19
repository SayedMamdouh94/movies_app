import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../style/app_colors.dart';

enum ShimmerType {
  text,
  avatar,
  card,
  button,
  custom,
}

class CustomShimmer extends StatelessWidget {
  final double width;
  final double height;
  final ShapeBorder shapeBorder;
  final ShimmerType type;
  final Color? baseColor;
  final Color? highlightColor;
  final Duration? duration;
  final bool enabled;
  final Widget? child;

  const CustomShimmer({
    super.key,
    this.width = double.infinity,
    this.height = double.infinity,
    this.shapeBorder = const RoundedRectangleBorder(),
    this.type = ShimmerType.custom,
    this.baseColor,
    this.highlightColor,
    this.duration,
    this.enabled = true,
    this.child,
  });

  // Factory constructors for common use cases
  factory CustomShimmer.text({
    Key? key,
    double? width,
    double height = 16,
    bool enabled = true,
  }) {
    return CustomShimmer(
      key: key,
      width: width ?? double.infinity,
      height: height,
      type: ShimmerType.text,
      shapeBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      enabled: enabled,
    );
  }

  factory CustomShimmer.avatar({
    Key? key,
    double size = 50,
    bool enabled = true,
  }) {
    return CustomShimmer(
      key: key,
      width: size,
      height: size,
      type: ShimmerType.avatar,
      shapeBorder: const CircleBorder(),
      enabled: enabled,
    );
  }

  factory CustomShimmer.card({
    Key? key,
    double? width,
    double height = 100,
    bool enabled = true,
  }) {
    return CustomShimmer(
      key: key,
      width: width ?? double.infinity,
      height: height,
      type: ShimmerType.card,
      shapeBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      enabled: enabled,
    );
  }

  factory CustomShimmer.button({
    Key? key,
    double? width,
    double height = 48,
    bool enabled = true,
  }) {
    return CustomShimmer(
      key: key,
      width: width ?? double.infinity,
      height: height,
      type: ShimmerType.button,
      shapeBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      enabled: enabled,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!enabled) {
      return child ?? const SizedBox.shrink();
    }

    return Shimmer.fromColors(
      baseColor: baseColor ?? _getBaseColor(),
      highlightColor: highlightColor ?? _getHighlightColor(),
      period: duration ?? const Duration(milliseconds: 1500),
      child: child ??
          Container(
            width: width,
            height: height,
            decoration: ShapeDecoration(
              color: _getContainerColor(),
              shape: shapeBorder,
            ),
          ),
    );
  }

  Color _getBaseColor() {
    switch (type) {
      case ShimmerType.text:
        return AppColors.kGray200;
      case ShimmerType.avatar:
        return AppColors.kGray100;
      case ShimmerType.card:
        return AppColors.kGray50;
      case ShimmerType.button:
        return AppColors.kGray200;
      case ShimmerType.custom:
        return AppColors.kGray200;
    }
  }

  Color _getHighlightColor() {
    switch (type) {
      case ShimmerType.text:
        return AppColors.kWhite;
      case ShimmerType.avatar:
        return AppColors.kGray50;
      case ShimmerType.card:
        return AppColors.kWhite;
      case ShimmerType.button:
        return AppColors.kWhite;
      case ShimmerType.custom:
        return AppColors.kWhite;
    }
  }

  Color _getContainerColor() {
    switch (type) {
      case ShimmerType.text:
        return AppColors.kGray300;
      case ShimmerType.avatar:
        return AppColors.kGray200;
      case ShimmerType.card:
        return AppColors.kGray100;
      case ShimmerType.button:
        return AppColors.kGray300;
      case ShimmerType.custom:
        return AppColors.kGray300;
    }
  }
}

// Specialized shimmer widgets for common patterns
class ShimmerText extends StatelessWidget {
  final double? width;
  final double height;
  final bool enabled;

  const ShimmerText({
    super.key,
    this.width,
    this.height = 16,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return CustomShimmer.text(
      width: width,
      height: height,
      enabled: enabled,
    );
  }
}

class ShimmerAvatar extends StatelessWidget {
  final double size;
  final bool enabled;

  const ShimmerAvatar({
    super.key,
    this.size = 50,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return CustomShimmer.avatar(
      size: size,
      enabled: enabled,
    );
  }
}

class ShimmerCard extends StatelessWidget {
  final double? width;
  final double height;
  final bool enabled;

  const ShimmerCard({
    super.key,
    this.width,
    this.height = 100,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return CustomShimmer.card(
      width: width,
      height: height,
      enabled: enabled,
    );
  }
}

class ShimmerButton extends StatelessWidget {
  final double? width;
  final double height;
  final bool enabled;

  const ShimmerButton({
    super.key,
    this.width,
    this.height = 48,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return CustomShimmer.button(
      width: width,
      height: height,
      enabled: enabled,
    );
  }
}

// Profile header specific shimmer
class ProfileHeaderShimmer extends StatelessWidget {
  final bool enabled;

  const ProfileHeaderShimmer({
    super.key,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    if (!enabled) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      decoration: BoxDecoration(
        color: AppColors.kWhite,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // Avatar shimmer
          ShimmerAvatar(size: 80, enabled: enabled),
          const SizedBox(width: 16),
          // Text content shimmer
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerText(
                  width: 150,
                  height: 20,
                  enabled: enabled,
                ),
                const SizedBox(height: 8),
                ShimmerText(
                  width: 200,
                  height: 16,
                  enabled: enabled,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
