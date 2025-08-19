import 'package:flutter/material.dart';
import 'package:movies_app/core/helpers/extensions/context_extenstions.dart';
import 'package:movies_app/core/widgets/custom_text.dart';
import 'package:movies_app/core/widgets/custom_text_button.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String content;
  final String approveAction;
  final ShapeBorder? shape;
  final String? cancelAction;
  final VoidCallback onApproveClick;
  final VoidCallback? onCancelClick;

  const CustomDialog({
    super.key,
    required this.title,
    required this.content,
    this.shape,
    required this.approveAction,
    this.cancelAction = 'إلغاء',
    required this.onApproveClick,
    this.onCancelClick,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: shape ??
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
      title: CustomText(
        title,
        style: context.textTheme.titleSmall,
      ),
      content: CustomText(
        content,
        style: context.textTheme.bodyMedium,
      ),
      actions: [
        CustomTextButton(
          onPressed: onApproveClick,
          text: approveAction,
        ),
        CustomTextButton(
          onPressed: onCancelClick ?? () => context.pop(),
          text: cancelAction ?? '',
          textColor: context.colorScheme.error,
        )
      ],
    );
  }
}
