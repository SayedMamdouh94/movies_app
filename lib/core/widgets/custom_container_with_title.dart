import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/helpers/extensions/context_extenstions.dart';
import 'package:movies_app/core/style/app_font_weight.dart';
import 'package:movies_app/core/widgets/custom_tap.dart';
import 'package:movies_app/core/widgets/custom_text.dart';

class CustomContainerWithTitle extends StatelessWidget {
  final String title;
  final bool isExpanded;
  final VoidCallback? onToggle;
  final List<Widget>? children;
  final String? summary;
  final bool showExpandIcon;
  final IconData? icon;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? borderRadius;
  final bool showBorder;

  const CustomContainerWithTitle({
    super.key,
    required this.title,
    this.isExpanded = false,
    this.onToggle,
    this.children,
    this.summary,
    this.showExpandIcon = true,
    this.icon,
    this.backgroundColor,
    this.padding,
    this.margin,
    this.borderRadius,
    this.showBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: backgroundColor ?? context.colorScheme.surface,
        borderRadius: BorderRadius.circular(borderRadius ?? 16.r),
        border: showBorder
            ? Border.all(
                color: context.colorScheme.outline.withValues(alpha: 0.1),
              )
            : null,
        boxShadow: [
          BoxShadow(
            color: context.colorScheme.shadow.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          _buildHeader(context),

          // Content
          if (_hasExpandableContent) _buildExpandableContent(context),
        ],
      ),
    );
  }

  // Check if the card has expandable content
  bool get _hasExpandableContent => children != null && children!.isNotEmpty;

  // Check if the card should be expandable (has content and onToggle callback)
  bool get _isExpandable => _hasExpandableContent && onToggle != null;

  Widget _buildHeader(BuildContext context) {
    final headerContent = Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: context.colorScheme.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(borderRadius ?? 16.r),
          topRight: Radius.circular(borderRadius ?? 16.r),
          bottomLeft: (_hasExpandableContent && isExpanded)
              ? Radius.zero
              : Radius.circular(borderRadius ?? 16.r),
          bottomRight: (_hasExpandableContent && isExpanded)
              ? Radius.zero
              : Radius.circular(borderRadius ?? 16.r),
        ),
      ),
      child: Row(
        children: [
          if (icon != null) ...[
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: context.colorScheme.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                icon,
                size: 20.sp,
                color: context.colorScheme.primary,
              ),
            ),
            SizedBox(width: 12.w),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4.h,
              children: [
                CustomText(
                  title,
                  color: context.colorScheme.primary,
                  fontWeight: AppFontWeight.bold,
                ),
                if ((!isExpanded || !_hasExpandableContent) && summary != null)
                  CustomText(
                    summary!,
                    style: context.textTheme.bodySmall,
                    color: context.colorScheme.onSurface.withValues(alpha: 0.6),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
          if (showExpandIcon && _isExpandable)
            AnimatedRotation(
              duration: const Duration(milliseconds: 200),
              turns: isExpanded ? 0.5 : 0,
              child: Icon(
                Icons.keyboard_arrow_down,
                color: context.colorScheme.primary,
                size: 24.sp,
              ),
            ),
        ],
      ),
    );

    // Wrap with CustomTap only if expandable
    if (_isExpandable) {
      return CustomTap(
        onTap: onToggle!,
        child: headerContent,
      );
    }

    return headerContent;
  }

  Widget _buildExpandableContent(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      height: isExpanded ? null : 0,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: isExpanded ? 1.0 : 0.0,
        child: isExpanded
            ? Padding(
                padding: padding ?? EdgeInsets.all(16.w),
                child: Column(
                  spacing: 12.h,
                  children: children!,
                ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
