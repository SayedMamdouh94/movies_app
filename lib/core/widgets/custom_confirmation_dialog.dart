import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/helpers/extensions/context_extenstions.dart';
import 'package:movies_app/core/style/app_colors.dart';
import 'package:movies_app/core/widgets/custom_button.dart';
import 'package:movies_app/core/widgets/custom_outlined_button.dart';
import 'package:movies_app/core/widgets/custom_text.dart';

class CustomConfirmationDialog extends StatefulWidget {
  final String title;
  final String content;
  final VoidCallback onConfirm;
  final String? confirmText;
  final String? cancelText;
  final IconData? icon;
  final Color? iconColor;
  final Color? confirmButtonColor;
  final String? subtitle;

  const CustomConfirmationDialog({
    super.key,
    required this.title,
    required this.content,
    required this.onConfirm,
    this.confirmText,
    this.cancelText,
    this.icon,
    this.iconColor,
    this.confirmButtonColor,
    this.subtitle,
  });

  @override
  State<CustomConfirmationDialog> createState() =>
      _CustomConfirmationDialogState();
}

class _CustomConfirmationDialogState extends State<CustomConfirmationDialog>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _iconAnimationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;
  late Animation<double> _iconScaleAnimation;
  late Animation<double> _iconRotationAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _iconAnimationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<double>(
      begin: 50.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _iconScaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _iconAnimationController,
      curve: Curves.elasticOut,
    ));

    _iconRotationAnimation = Tween<double>(
      begin: -0.5,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _iconAnimationController,
      curve: Curves.easeOutCubic,
    ));

    _animationController.forward();
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) {
        _iconAnimationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _iconAnimationController.dispose();
    super.dispose();
  }

  void _closeDialog() {
    _iconAnimationController.reverse();
    _animationController.reverse().then((_) {
      if (mounted) {
        context.pop();
      }
    });
  }

  void _confirmAction() {
    _iconAnimationController.reverse();
    _animationController.reverse().then((_) {
      if (mounted) {
        context.pop();
        widget.onConfirm();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return FadeTransition(
          opacity: _fadeAnimation,
          child: Transform.translate(
            offset: Offset(0, _slideAnimation.value),
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Dialog(
                backgroundColor: Colors.transparent,
                elevation: 0,
                insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.kWhite,
                    borderRadius: BorderRadius.circular(20.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.25),
                        blurRadius: 40,
                        offset: const Offset(0, 20),
                        spreadRadius: 0,
                      ),
                      BoxShadow(
                        color: (widget.iconColor ?? context.colorScheme.primary)
                            .withValues(alpha: 0.1),
                        blurRadius: 60,
                        offset: const Offset(0, 30),
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Compact icon section
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 20.h),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              (widget.iconColor ?? context.colorScheme.primary)
                                  .withValues(alpha: 0.15),
                              (widget.iconColor ?? context.colorScheme.primary)
                                  .withValues(alpha: 0.05),
                              AppColors.kWhite,
                            ],
                            stops: const [0.0, 0.7, 1.0],
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.r),
                            topRight: Radius.circular(20.r),
                          ),
                        ),
                        child: AnimatedBuilder(
                          animation: _iconAnimationController,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: _iconScaleAnimation.value,
                              child: Transform.rotate(
                                angle: _iconRotationAnimation.value,
                                child: Container(
                                  width: 80.w,
                                  height: 80.h,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        widget.iconColor ??
                                            context.colorScheme.primary,
                                        (widget.iconColor ??
                                                context.colorScheme.primary)
                                            .withValues(alpha: 0.8),
                                        (widget.iconColor ??
                                                context.colorScheme.primary)
                                            .withValues(alpha: 0.9),
                                      ],
                                    ),
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: (widget.iconColor ??
                                                context.colorScheme.primary)
                                            .withValues(alpha: 0.4),
                                        blurRadius: 20,
                                        offset: const Offset(0, 8),
                                      ),
                                      BoxShadow(
                                        color: (widget.iconColor ??
                                                context.colorScheme.primary)
                                            .withValues(alpha: 0.2),
                                        blurRadius: 40,
                                        offset: const Offset(0, 16),
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    widget.icon ?? Icons.help_outline_rounded,
                                    color: AppColors.kWhite,
                                    size: 50.sp,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      // Compact content section
                      Padding(
                        padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 20.h),
                        child: Column(
                          children: [
                            // Title with compact typography
                            CustomText(
                              widget.title,
                              style: context.textTheme.titleLarge?.copyWith(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700,
                                height: 1.2,
                              ),
                              color: AppColors.kGray900,
                              textAlign: TextAlign.center,
                            ),

                            if (widget.subtitle != null) ...[
                              SizedBox(height: 6.h),
                              CustomText(
                                widget.subtitle!,
                                style: context.textTheme.bodySmall?.copyWith(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                  color: (widget.iconColor ??
                                          context.colorScheme.primary)
                                      .withValues(alpha: 0.8),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],

                            SizedBox(height: 12.h),

                            // Compact content container
                            Container(
                              padding: EdgeInsets.all(12.w),
                              decoration: BoxDecoration(
                                color: AppColors.kGray50,
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                  color: AppColors.kGray100,
                                  width: 1,
                                ),
                              ),
                              child: CustomText(
                                widget.content,
                                style: context.textTheme.bodyMedium?.copyWith(
                                  fontSize: 15.sp,
                                  height: 1.5,
                                  fontWeight: FontWeight.w400,
                                ),
                                color: AppColors.kGray700,
                                textAlign: TextAlign.center,
                              ),
                            ),

                            SizedBox(height: 20.h),

                            // Compact buttons
                            Row(
                              children: [
                                Expanded(
                                  child: CustomOutlinedButton(
                                    onPressed: _closeDialog,
                                    text: widget.cancelText ??
                                        context.locale.cancel,
                                    height: 48.h,
                                    color: AppColors.kGray500,
                                    radius: 12.r,
                                    borderWidth: 2,
                                    fontSize: 15.sp,
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: CustomButton(
                                    onPressed: _confirmAction,
                                    text: widget.confirmText ??
                                        context.locale.confirm,
                                    height: 48.h,
                                    color: widget.confirmButtonColor ??
                                        context.colorScheme.primary,
                                    radius: 12.r,
                                    enableElevation: true,
                                    elevation: 4,
                                    fontSize: 15.sp,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class DeleteConfirmationDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onConfirm;
  final String? subtitle;

  const DeleteConfirmationDialog({
    super.key,
    this.title = 'Delete Confirmation',
    required this.content,
    required this.onConfirm,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return CustomConfirmationDialog(
      title: title,
      content: content,
      onConfirm: onConfirm,
      subtitle: subtitle ?? 'This action cannot be undone',
      confirmText: 'Delete',
      cancelText: 'Cancel',
      icon: Icons.delete_forever_rounded,
      iconColor: context.colorScheme.error,
      confirmButtonColor: context.colorScheme.error,
    );
  }
}

class WarningConfirmationDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onConfirm;
  final String? subtitle;

  const WarningConfirmationDialog({
    super.key,
    this.title = 'Warning',
    required this.content,
    required this.onConfirm,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return CustomConfirmationDialog(
      title: title,
      content: content,
      onConfirm: onConfirm,
      subtitle: subtitle ?? 'Please review before proceeding',
      confirmText: 'Continue',
      cancelText: 'Cancel',
      icon: Icons.warning_amber_rounded,
      iconColor: Colors.orange.shade600,
      confirmButtonColor: Colors.orange.shade600,
    );
  }
}

class SuccessConfirmationDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onConfirm;
  final String? subtitle;

  const SuccessConfirmationDialog({
    super.key,
    this.title = 'Success',
    required this.content,
    required this.onConfirm,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return CustomConfirmationDialog(
      title: title,
      content: content,
      onConfirm: onConfirm,
      subtitle: subtitle ?? 'Action completed successfully',
      confirmText: 'OK',
      cancelText: 'Cancel',
      icon: Icons.check_circle_rounded,
      iconColor: Colors.green.shade600,
      confirmButtonColor: Colors.green.shade600,
    );
  }
}
