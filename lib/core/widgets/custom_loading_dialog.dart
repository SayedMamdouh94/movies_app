import 'package:flutter/material.dart';
import 'package:movies_app/core/widgets/custom_loading_indicator.dart';

class CustomLoadingDialog extends StatelessWidget {
  const CustomLoadingDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Dialog(
        backgroundColor: Colors.transparent,
        alignment: Alignment.center,
        child: UnconstrainedBox(
          child: IntrinsicWidth(
            child: IntrinsicHeight(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const CustomLoadingIndicator(
                  size: 50,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
