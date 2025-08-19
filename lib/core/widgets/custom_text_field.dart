import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/helpers/extensions/context_extenstions.dart';
import 'package:movies_app/core/style/app_colors.dart';

import '../style/app_font_weight.dart';
import 'custom_text.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData? suffixIcon;
  final IconData? prefixIcon;
  final VoidCallback? onSuffixIcon;
  final Function(String?)? onSubmit;
  final Function(String?)? onChange;
  final bool? obscureText;
  final String errorMsg;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final Function()? onTap;
  final bool readOnly;
  final Color? suffixIconColor;
  final int? maxLines;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final int? minValue;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final bool hasHeight;
  final bool isPassword;
  final Color? fillColor;
  final Color? cursorColor;
  final Widget? prefixWidget;
  final bool isRequired;
  final double height;
  final bool isLoading;
  final bool showCharacterCount;
  final bool enableFloatingLabel;
  final String? helperText;
  final Duration animationDuration;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.obscureText,
    required this.errorMsg,
    required this.keyboardType,
    this.onSuffixIcon,
    this.suffixIcon,
    this.onChange,
    this.onSubmit,
    required this.textInputAction,
    this.prefixIcon,
    this.onTap,
    this.readOnly = false,
    this.suffixIconColor,
    this.maxLines = 1,
    this.validator,
    this.focusNode,
    this.minValue,
    this.inputFormatters,
    this.maxLength,
    this.hasHeight = false,
    this.isPassword = false,
    this.fillColor,
    this.cursorColor,
    this.prefixWidget,
    this.isRequired = true,
    this.height = 40,
    this.isLoading = false,
    this.showCharacterCount = false,
    this.enableFloatingLabel = true,
    this.helperText,
    this.animationDuration = const Duration(milliseconds: 200),
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField>
    with SingleTickerProviderStateMixin {
  bool _obscureText = true;
  bool _isFocused = false;
  bool _hasError = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.02,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _focusNode.addListener(_onFocusChange);
    widget.controller.addListener(_onTextChange);
  }

  @override
  void dispose() {
    _animationController.dispose();
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    widget.controller.removeListener(_onTextChange);
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });

    if (_isFocused) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  void _onTextChange() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8.h,
            children: [
              _buildTextField(),
              if (widget.helperText != null && !_hasError) _buildHelperText(),
              if (widget.showCharacterCount && widget.maxLength != null)
                _buildCharacterCount(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTextField() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: _isFocused
            ? [
                BoxShadow(
                  color: context.colorScheme.primary.withValues(alpha: 0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: TextFormField(
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        focusNode: _focusNode,
        onFieldSubmitted: widget.onSubmit ??
            (_) {
              if (widget.textInputAction == TextInputAction.done) {
                context.unfocus();
              } else {
                context.nextFocus();
              }
            },
        onTap: widget.onTap,
        readOnly: widget.readOnly || widget.isLoading,
        cursorColor: widget.cursorColor ?? context.colorScheme.primary,
        textInputAction: widget.textInputAction,
        maxLength: widget.maxLength,
        inputFormatters: widget.inputFormatters,
        decoration: InputDecoration(
          counterText: '',
          hintText: widget.enableFloatingLabel ? null : widget.hintText,
          labelText: widget.enableFloatingLabel ? widget.hintText : null,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          errorMaxLines: 3,
          errorStyle: TextStyle(
            fontSize: 12.sp,
            color: context.colorScheme.error,
            fontWeight: AppFontWeight.medium,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: context.colorScheme.error,
              width: 1.5,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: context.colorScheme.error,
              width: 2.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: context.colorScheme.primary,
              width: 2.0,
            ),
          ),
          prefixIcon: _buildPrefixIcon(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(
              color: AppColors.kGray200,
              width: 1.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(
              color: AppColors.kGray200,
              width: 1.0,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(
              color: AppColors.kGray100,
              width: 1.0,
            ),
          ),
          suffixIcon: _buildSuffixIcon(),
          fillColor: _getFillColor(),
          filled: true,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: widget.hasHeight ? widget.height.h : 12.h,
          ),
          labelStyle: TextStyle(
            fontSize: 14.sp,
            color: _hasError
                ? context.colorScheme.error
                : (_isFocused
                    ? context.colorScheme.primary
                    : AppColors.kGray600),
            fontWeight: AppFontWeight.medium,
          ),
          hintStyle: TextStyle(
            fontSize: 14.sp,
            color: AppColors.kGray500,
            fontWeight: AppFontWeight.regular,
          ),
        ),
        style: TextStyle(
          fontSize: 14.sp,
          color: AppColors.kGray900,
          fontWeight: AppFontWeight.medium,
        ),
        maxLines: widget.maxLines,
        textAlign: TextAlign.start,
        textAlignVertical: widget.hasHeight ? TextAlignVertical.top : null,
        obscureText: widget.isPassword ? _obscureText : false,
        validator: (value) {
          final error = widget.validator?.call(value) ??
              (widget.errorMsg.isNotEmpty && (value == null || value.isEmpty)
                  ? widget.errorMsg
                  : null);

          setState(() {
            _hasError = error != null;
          });

          return error;
        },
        onChanged: (value) {
          setState(() {
            _hasError = false;
          });
          widget.onChange?.call(value);
        },
      ),
    );
  }

  Widget? _buildPrefixIcon() {
    if (widget.prefixWidget != null) return widget.prefixWidget;
    if (widget.prefixIcon == null) return null;

    return Icon(
      widget.prefixIcon,
      color: _getIconColor(),
      size: 20.h,
    );
  }

  Widget? _buildSuffixIcon() {
    if (widget.isLoading) {
      return SizedBox(
        width: 16.h,
        height: 16.h,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            context.colorScheme.primary,
          ),
        ),
      );
    }

    if (widget.suffixIcon != null || widget.isPassword) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: widget.onSuffixIcon ??
            (widget.isPassword
                ? () => setState(() => _obscureText = !_obscureText)
                : null),
        child: widget.isPassword
            ? Icon(
                _obscureText
                    ? CupertinoIcons.eye_fill
                    : CupertinoIcons.eye_slash_fill,
                color: _getIconColor(),
                size: 20.h,
              )
            : Icon(
                widget.suffixIcon,
                color: _getIconColor(),
                size: 20.h,
              ),
      );
    }

    return null;
  }

  Widget _buildHelperText() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Padding(
        padding: EdgeInsets.only(left: 4.w),
        child: CustomText(
          widget.helperText!,
          style: context.textTheme.labelSmall,
          color: AppColors.kGray600,
        ),
      ),
    );
  }

  Widget _buildCharacterCount() {
    final currentLength = widget.controller.text.length;
    final maxLength = widget.maxLength!;
    final isNearLimit = currentLength > maxLength * 0.8;

    return Padding(
      padding: EdgeInsets.only(left: 4.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            '${currentLength}/${maxLength}',
            style: context.textTheme.labelSmall,
            color: isNearLimit
                ? (currentLength >= maxLength
                    ? context.colorScheme.error
                    : AppColors.kSecondary)
                : AppColors.kGray500,
          ),
          if (isNearLimit)
            LinearProgressIndicator(
              value: currentLength / maxLength,
              backgroundColor: AppColors.kGray200,
              valueColor: AlwaysStoppedAnimation<Color>(
                currentLength >= maxLength
                    ? context.colorScheme.error
                    : AppColors.kSecondary,
              ),
            ),
        ],
      ),
    );
  }

  Color _getFillColor() {
    if (widget.readOnly) return AppColors.kGray50;
    if (_hasError) return context.colorScheme.error.withValues(alpha: 0.05);
    if (_isFocused) return context.colorScheme.primary.withValues(alpha: 0.02);
    return widget.fillColor ?? Colors.white;
  }

  Color _getIconColor() {
    if (_hasError) return context.colorScheme.error;
    if (_isFocused) return context.colorScheme.primary;
    return AppColors.kGray500;
  }
}
