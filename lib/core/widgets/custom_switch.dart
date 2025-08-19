import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/helpers/extensions/context_extenstions.dart';
import 'package:movies_app/core/local_secure_storage/local_storage.dart';
import 'package:movies_app/core/style/app_colors.dart';

import '../style/app_font_weight.dart';
import 'custom_text.dart';

class CustomSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? thumbColor;
  final double width;
  final double height;
  final double thumbSize;
  final Duration animationDuration;
  final bool enabled;
  final String? label;
  final String? description;
  final bool showLabel;
  final bool showDescription;
  final CrossAxisAlignment labelAlignment;
  final double labelSpacing;
  final bool enableHapticFeedback;
  final bool enableRipple;

  const CustomSwitch({
    super.key,
    required this.value,
    this.onChanged,
    this.activeColor,
    this.inactiveColor,
    this.thumbColor,
    this.width = 50,
    this.height = 28,
    this.thumbSize = 20,
    this.animationDuration = const Duration(milliseconds: 200),
    this.enabled = true,
    this.label,
    this.description,
    this.showLabel = false,
    this.showDescription = false,
    this.labelAlignment = CrossAxisAlignment.start,
    this.labelSpacing = 12,
    this.enableHapticFeedback = true,
    this.enableRipple = true,
  });

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _thumbAnimation;
  late Animation<double> _scaleAnimation;
  Animation<Color?>? _trackColorAnimation;
  Animation<Color?>? _thumbColorAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _thumbAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    // Set initial animation value
    if (widget.value) {
      _animationController.value = 1.0;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Initialize color animations here after context is available
    _trackColorAnimation = ColorTween(
      begin: _getInactiveColor(),
      end: _getActiveColor(),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _thumbColorAnimation = ColorTween(
      begin: _getThumbInactiveColor(),
      end: _getThumbActiveColor(),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void didUpdateWidget(CustomSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      if (widget.value) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTap() async {
    if (!widget.enabled || widget.onChanged == null) return;

    // Haptic feedback
    if (widget.enableHapticFeedback) {
      HapticFeedback.lightImpact();
    }

    // Scale animation
    _animationController.forward();
    await Future.delayed(const Duration(milliseconds: 100));
    _animationController.reverse();

    // Toggle value
    widget.onChanged!(!widget.value);
  }

  Color _getActiveColor() {
    if (!widget.enabled) return AppColors.kGray300;
    return widget.activeColor ?? context.colorScheme.primary;
  }

  Color _getInactiveColor() {
    if (!widget.enabled) return AppColors.kGray200;
    return widget.inactiveColor ?? AppColors.kGray300;
  }

  Color _getThumbActiveColor() {
    if (!widget.enabled) return AppColors.kGray400;
    return widget.thumbColor ?? AppColors.kWhite;
  }

  Color _getThumbInactiveColor() {
    if (!widget.enabled) return AppColors.kGray400;
    return widget.thumbColor ?? AppColors.kWhite;
  }

  // Check if current language is Arabic from LocalStorage
  bool get _isArabic => LocalStorage.getLanguage == 'ar';

  @override
  Widget build(BuildContext context) {
    // Ensure color animations are initialized
    if (_trackColorAnimation == null || _thumbColorAnimation == null) {
      _trackColorAnimation = ColorTween(
        begin: _getInactiveColor(),
        end: _getActiveColor(),
      ).animate(CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ));

      _thumbColorAnimation = ColorTween(
        begin: _getThumbInactiveColor(),
        end: _getThumbActiveColor(),
      ).animate(CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ));
    }

    final switchWidget = AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: GestureDetector(
            onTap: _handleTap,
            child: Container(
              width: widget.width.w,
              height: widget.height.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(widget.height.h / 2),
                color: _trackColorAnimation!.value,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  // Thumb - positioned based on language direction
                  AnimatedPositioned(
                    duration: widget.animationDuration,
                    left: _isArabic
                        ? (widget.width.w - widget.thumbSize.w - 4.w) -
                            (_thumbAnimation.value *
                                (widget.width.w -
                                    widget.thumbSize.w -
                                    4.w)) // RTL movement in Arabic
                        : _thumbAnimation.value *
                            (widget.width.w -
                                widget.thumbSize.w -
                                4.w), // LTR movement in English
                    top: (widget.height.h - widget.thumbSize.h) / 2,
                    child: Container(
                      width: widget.thumbSize.w,
                      height: widget.thumbSize.h,
                      decoration: BoxDecoration(
                        color: _thumbColorAnimation!.value,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Ripple effect
                  if (widget.enableRipple && widget.enabled)
                    Positioned.fill(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: _handleTap,
                          borderRadius:
                              BorderRadius.circular(widget.height.h / 2),
                          splashColor: _getActiveColor().withValues(alpha: 0.2),
                          highlightColor:
                              _getActiveColor().withValues(alpha: 0.1),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );

    // If no label, return just the switch
    if (!widget.showLabel && widget.label == null) {
      return switchWidget;
    }

    // Return switch with label
    return Row(
      crossAxisAlignment: widget.labelAlignment,
      children: [
        switchWidget,
        SizedBox(width: widget.labelSpacing.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.label != null)
                CustomText(
                  widget.label!,
                  style: context.textTheme.bodySmall,
                  color:
                      widget.enabled ? AppColors.kGray900 : AppColors.kGray500,
                  fontWeight: AppFontWeight.semiBold,
                ),
              if (widget.description != null && widget.showDescription) ...[
                SizedBox(height: 4.h),
                CustomText(
                  widget.description!,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: widget.enabled
                        ? AppColors.kGray600
                        : AppColors.kGray400,
                    fontWeight: AppFontWeight.regular,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

// Convenience widget for simple switches
class SimpleSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final Color? activeColor;
  final Color? inactiveColor;
  final bool enabled;

  const SimpleSwitch({
    super.key,
    required this.value,
    this.onChanged,
    this.activeColor,
    this.inactiveColor,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return CustomSwitch(
      value: value,
      onChanged: onChanged,
      activeColor: activeColor,
      inactiveColor: inactiveColor,
      enabled: enabled,
    );
  }
}

// Switch with label
class LabeledSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final String label;
  final String? description;
  final Color? activeColor;
  final Color? inactiveColor;
  final bool enabled;
  final CrossAxisAlignment labelAlignment;

  const LabeledSwitch({
    super.key,
    required this.value,
    required this.label,
    this.onChanged,
    this.description,
    this.activeColor,
    this.inactiveColor,
    this.enabled = true,
    this.labelAlignment = CrossAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return CustomSwitch(
      value: value,
      onChanged: onChanged,
      label: label,
      description: description,
      showLabel: true,
      showDescription: description != null,
      activeColor: activeColor,
      inactiveColor: inactiveColor,
      enabled: enabled,
      labelAlignment: labelAlignment,
    );
  }
}
