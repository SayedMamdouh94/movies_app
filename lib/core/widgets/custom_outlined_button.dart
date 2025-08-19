import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/helpers/extensions/context_extenstions.dart';
import 'package:movies_app/core/style/app_colors.dart';
import 'package:movies_app/core/style/app_font_weight.dart';
import 'package:movies_app/core/widgets/custom_text.dart';

class CustomOutlinedButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final String? text;
  final double? height;
  final bool isExpand;
  final Widget? child;
  final double? width;
  final double radius;
  final Color? color;
  final double borderWidth;
  final bool autoDelay;
  final bool isLoading;
  final bool enableElevation;
  final double elevation;
  final Duration animationDuration;
  final bool enableRipple;
  final Color? textColor;
  final double? fontSize;
  final IconData? icon;
  final bool iconTrailing;
  final double iconSpacing;
  final bool enableShimmer;
  final String? loadingText;

  const CustomOutlinedButton({
    super.key,
    required this.onPressed,
    this.text,
    this.height,
    this.isExpand = true,
    this.child,
    this.width,
    this.radius = 12,
    this.color,
    this.borderWidth = 1.5,
    this.autoDelay = true,
    this.isLoading = false,
    this.enableElevation = false,
    this.elevation = 1.0,
    this.animationDuration = const Duration(milliseconds: 200),
    this.enableRipple = true,
    this.textColor,
    this.fontSize,
    this.icon,
    this.iconTrailing = false,
    this.iconSpacing = 8.0,
    this.enableShimmer = false,
    this.loadingText,
  });

  @override
  State<CustomOutlinedButton> createState() => _CustomOutlinedButtonState();
}

class _CustomOutlinedButtonState extends State<CustomOutlinedButton>
    with SingleTickerProviderStateMixin {
  bool isPressed = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _elevationAnimation = Tween<double>(
      begin: widget.elevation,
      end: widget.elevation * 0.5,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handlePress() async {
    if (widget.isLoading || isPressed) return;

    _animationController.forward();

    if (widget.autoDelay) {
      setState(() {
        isPressed = true;
      });

      FocusManager.instance.primaryFocus?.unfocus();
      widget.onPressed?.call();

      await Future.delayed(const Duration(milliseconds: 300));

      if (mounted) {
        setState(() {
          isPressed = false;
        });
      }
    } else {
      FocusManager.instance.primaryFocus?.unfocus();
      widget.onPressed?.call();
    }
    if (mounted) {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            width: widget.isExpand ? double.infinity : widget.width,
            height: widget.height ?? 45.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.radius),
              color: _getBackgroundColor(),
              border: _getBorder(),
              boxShadow: _getBoxShadow(),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: widget.isLoading || isPressed ? null : _handlePress,
                borderRadius: BorderRadius.circular(widget.radius),
                splashColor: widget.enableRipple
                    ? _getSplashColor()
                    : Colors.transparent,
                highlightColor: widget.enableRipple
                    ? _getHighlightColor()
                    : Colors.transparent,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: _buildContent(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildContent() {
    if (widget.isLoading) {
      return _buildLoadingContent();
    }

    if (widget.child != null) {
      return widget.child!;
    }

    if (widget.text != null) {
      return _buildTextContent();
    }

    return const SizedBox.shrink();
  }

  Widget _buildLoadingContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 16.h,
          height: 16.h,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(_getTextColor()),
          ),
        ),
        if (widget.loadingText != null) ...[
          SizedBox(width: widget.iconSpacing.w),
          Flexible(
            child: CustomText(
              widget.loadingText!,
              color: _getTextColor(),
              fontWeight: AppFontWeight.semiBold,
              fontSize: widget.fontSize ?? 14.sp,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildTextContent() {
    final hasIcon = widget.icon != null;

    if (!hasIcon) {
      return Center(
        child: CustomText(
          widget.text!,
          color: _getTextColor(),
          fontWeight: AppFontWeight.semiBold,
          fontSize: widget.fontSize ?? 14.sp,
        ),
      );
    }

    final iconWidget = Icon(
      widget.icon,
      color: _getTextColor(),
      size: 18.h,
    );

    final textWidget = CustomText(
      widget.text!,
      color: _getTextColor(),
      fontWeight: AppFontWeight.semiBold,
      fontSize: widget.fontSize ?? 14.sp,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.iconTrailing) ...[
          textWidget,
          SizedBox(width: widget.iconSpacing.w),
          iconWidget,
        ] else ...[
          iconWidget,
          SizedBox(width: widget.iconSpacing.w),
          textWidget,
        ],
      ],
    );
  }

  Color _getBackgroundColor() {
    if (widget.isLoading) {
      return AppColors.kGray100;
    }

    return Colors.transparent;
  }

  Border _getBorder() {
    return Border.all(
      color: widget.isLoading
          ? AppColors.kGray400
          : widget.color ?? context.colorScheme.primary,
      width: widget.borderWidth,
    );
  }

  List<BoxShadow>? _getBoxShadow() {
    if (!widget.enableElevation) return null;

    return [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.1),
        blurRadius: _elevationAnimation.value * 2,
        offset: Offset(0, _elevationAnimation.value),
      ),
    ];
  }

  Color _getTextColor() {
    if (widget.textColor != null) return widget.textColor!;

    if (widget.isLoading) {
      return AppColors.kGray600;
    }

    return widget.color ?? context.colorScheme.primary;
  }

  Color _getSplashColor() {
    return (widget.color ?? context.colorScheme.primary).withValues(alpha: 0.1);
  }

  Color _getHighlightColor() {
    return (widget.color ?? context.colorScheme.primary)
        .withValues(alpha: 0.05);
  }
}
