import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/helpers/extensions/context_extenstions.dart';
import 'package:movies_app/core/style/app_colors.dart';
import 'package:movies_app/core/style/app_font_weight.dart';
import 'package:movies_app/core/widgets/custom_text.dart';

class CustomDropdownOption<T> {
  final T value;
  final String label;
  final IconData? icon;

  const CustomDropdownOption({
    required this.value,
    required this.label,
    this.icon,
  });
}

class CustomDropdown<T> extends StatelessWidget {
  final T? value;
  final List<CustomDropdownOption<T>> options;
  final Function(T?) onChanged;
  final String? label;
  final String? hintText;
  final bool isRequired;
  final String? errorText;
  final bool enabled;

  const CustomDropdown({
    super.key,
    required this.value,
    required this.options,
    required this.onChanged,
    this.label,
    this.hintText,
    this.isRequired = true,
    this.errorText,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8.h,
      children: [
        if (label != null)
          CustomDropdownLabel(label: label!, isRequired: isRequired),
        CustomDropdownField<T>(
          value: value,
          options: options,
          onChanged: enabled ? onChanged : null,
          hintText: hintText ?? 'Select an option',
          errorText: errorText,
          enabled: enabled,
        ),
        if (value == null && errorText != null && errorText!.isNotEmpty)
          CustomDropdownError(errorText: errorText!),
      ],
    );
  }
}

class CustomDropdownLabel extends StatelessWidget {
  final String label;
  final bool isRequired;

  const CustomDropdownLabel({
    super.key,
    required this.label,
    required this.isRequired,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomText(
          label,
          style: context.textTheme.bodySmall,
          fontWeight: AppFontWeight.medium,
        ),
        if (isRequired)
          CustomText(
            '',
            style: context.textTheme.bodySmall,
            fontWeight: AppFontWeight.medium,
            color: context.colorScheme.error,
          ),
      ],
    );
  }
}

class CustomDropdownError extends StatelessWidget {
  final String errorText;

  const CustomDropdownError({
    super.key,
    required this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 4.w),
      child: CustomText(
        errorText,
        style: context.textTheme.labelLarge,
        color: context.colorScheme.error,
        fontWeight: AppFontWeight.medium,
      ),
    );
  }
}

class CustomDropdownField<T> extends StatefulWidget {
  final T? value;
  final List<CustomDropdownOption<T>> options;
  final Function(T?)? onChanged;
  final String hintText;
  final String? errorText;
  final bool enabled;

  const CustomDropdownField({
    super.key,
    required this.value,
    required this.options,
    required this.onChanged,
    required this.hintText,
    this.errorText,
    this.enabled = true,
  });

  @override
  State<CustomDropdownField<T>> createState() => _CustomDropdownFieldState<T>();
}

class _CustomDropdownFieldState<T> extends State<CustomDropdownField<T>>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _animationController;
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );

    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 0.5,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

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
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(CustomDropdownField<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Force a rebuild if the value changed externally
    if (widget.value != oldWidget.value) {
      setState(() {
        // This will trigger a rebuild and update the selected state
      });
    }
  }

  void _toggleDropdown() {
    if (!widget.enabled) return;

    setState(() {
      _isExpanded = !_isExpanded;
    });

    if (_isExpanded) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  String get _displayText {
    if (widget.value == null) return widget.hintText;

    final selectedOption = widget.options.firstWhere(
      (option) => option.value == widget.value,
      orElse: () =>
          CustomDropdownOption(value: widget.value!, label: widget.hintText),
    );

    return selectedOption.label;
  }

  @override
  Widget build(BuildContext context) {
    final hasError = widget.errorText != null;

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: hasError
                    ? context.colorScheme.error
                    : (_isExpanded
                        ? context.colorScheme.primary
                        : AppColors.kGray200),
                width: _isExpanded || hasError ? 2.0 : 1.0,
              ),
              boxShadow: _isExpanded
                  ? [
                      BoxShadow(
                        color: hasError
                            ? context.colorScheme.error.withValues(alpha: 0.1)
                            : context.colorScheme.primary
                                .withValues(alpha: 0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  : null,
            ),
            child: Column(
              children: [
                _buildDropdownHeader(context, hasError),
                if (_isExpanded) _buildDropdownOptions(context),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDropdownHeader(BuildContext context, bool hasError) {
    return InkWell(
      onTap: _toggleDropdown,
      borderRadius: _isExpanded
          ? BorderRadius.only(
              topLeft: Radius.circular(12.r),
              topRight: Radius.circular(12.r),
            )
          : BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: widget.enabled
              ? (hasError
                  ? context.colorScheme.error.withValues(alpha: 0.05)
                  : AppColors.kGray50)
              : AppColors.kGray100,
          borderRadius: _isExpanded
              ? BorderRadius.only(
                  topLeft: Radius.circular(12.r),
                  topRight: Radius.circular(12.r),
                )
              : BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Expanded(
              child: CustomText(
                _displayText,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: widget.value == null
                      ? AppColors.kGray500
                      : (widget.enabled
                          ? AppColors.kGray900
                          : AppColors.kGray500),
                  fontWeight: AppFontWeight.medium,
                  fontSize: 14.sp,
                ),
              ),
            ),
            AnimatedBuilder(
              animation: _rotationAnimation,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _rotationAnimation.value * 3.14159,
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    color: hasError
                        ? context.colorScheme.error
                        : (_isExpanded
                            ? context.colorScheme.primary
                            : AppColors.kGray500),
                    size: 20.h,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownOptions(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(12.r),
            bottomRight: Radius.circular(12.r),
          ),
          border: const Border(
            top: BorderSide(color: AppColors.kGray100),
          ),
        ),
        constraints: BoxConstraints(
          maxHeight: 250.h, // Increased maximum height for better scrolling
        ),
        child: widget.options.length <= 3
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: widget.options.asMap().entries.map((entry) {
                  final index = entry.key;
                  final option = entry.value;

                  return Column(
                    children: [
                      _buildDropdownOption(
                        context: context,
                        option: option,
                      ),
                      if (index < widget.options.length - 1)
                        Container(
                          height: 1,
                          color: AppColors.kGray100,
                          margin: EdgeInsets.symmetric(horizontal: 16.w),
                        ),
                    ],
                  );
                }).toList(),
              )
            : Scrollbar(
                thumbVisibility: true,
                thickness: 4.w,
                radius: Radius.circular(2.r),
                child: ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const BouncingScrollPhysics(),
                  itemCount: widget.options.length,
                  separatorBuilder: (context, index) => Container(
                    height: 1,
                    color: AppColors.kGray100,
                    margin: EdgeInsets.symmetric(horizontal: 16.w),
                  ),
                  itemBuilder: (context, index) {
                    final option = widget.options[index];
                    return _buildDropdownOption(
                      context: context,
                      option: option,
                    );
                  },
                ),
              ),
      ),
    );
  }

  Widget _buildDropdownOption({
    required BuildContext context,
    required CustomDropdownOption<T> option,
  }) {
    final isSelected = widget.value == option.value;

    return InkWell(
      onTap: () {
        widget.onChanged?.call(option.value);
        _toggleDropdown();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Row(
          children: [
            if (option.icon != null) ...[
              Container(
                width: 24.w,
                height: 24.h,
                decoration: BoxDecoration(
                  color: isSelected
                      ? context.colorScheme.primary.withValues(alpha: 0.1)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Icon(
                  option.icon,
                  size: 16.h,
                  color: isSelected
                      ? context.colorScheme.primary
                      : AppColors.kGray500,
                ),
              ),
              SizedBox(width: 12.w),
            ],
            Expanded(
              child: CustomText(
                option.label,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: isSelected
                      ? context.colorScheme.primary
                      : AppColors.kGray700,
                  fontWeight: isSelected
                      ? AppFontWeight.semiBold
                      : AppFontWeight.medium,
                  fontSize: 14.sp,
                ),
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check,
                size: 18.h,
                color: context.colorScheme.primary,
              ),
          ],
        ),
      ),
    );
  }
}
