import 'package:flutter/material.dart';
import 'package:movies_app/core/widgets/custom_text.dart';
import 'package:movies_app/core/helpers/snackbar.dart';

class PopularPeopleErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;
  final bool hasData;

  const PopularPeopleErrorWidget({
    super.key,
    required this.message,
    this.onRetry,
    this.hasData = false,
  });

  @override
  Widget build(BuildContext context) {
    if (hasData) {
      return PopularPeopleErrorSnackBar(message: message, onRetry: onRetry);
    }

    return PopularPeopleErrorScreen(message: message, onRetry: onRetry);
  }
}

class PopularPeopleErrorScreen extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const PopularPeopleErrorScreen({
    super.key,
    required this.message,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.red[400]),
            const SizedBox(height: 16),
            const CustomText(
              'Oops! Something went wrong',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            CustomText(
              message,
              fontSize: 14,
              color: Colors.grey[600],
              textAlign: TextAlign.center,
              maxLines: 3,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const CustomText(
                  'Try Again',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class PopularPeopleErrorSnackBar extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const PopularPeopleErrorSnackBar({
    super.key,
    required this.message,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final displayMessage = onRetry != null
          ? '$message. Pull down to refresh.'
          : message;
      showSnackBar(displayMessage, isError: true);
    });

    return const SizedBox.shrink();
  }
}
