import 'package:flutter/material.dart';
import 'package:movies_app/core/widgets/custom_text.dart';

class PopularPeopleLoadingWidget extends StatelessWidget {
  const PopularPeopleLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          CustomText(
            'Loading popular people...',
            fontSize: 16,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}

class PopularPeopleLoadMoreWidget extends StatelessWidget {
  const PopularPeopleLoadMoreWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}

class PopularPeopleEmptyWidget extends StatelessWidget {
  final VoidCallback? onRetry;

  const PopularPeopleEmptyWidget({super.key, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.people_outline, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          const CustomText(
            'No popular people found',
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
          const SizedBox(height: 8),
          const CustomText(
            'Try refreshing to load data',
            fontSize: 14,
            color: Colors.grey,
          ),
          if (onRetry != null) ...[
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onRetry,
              child: const CustomText(
                'Retry',
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
