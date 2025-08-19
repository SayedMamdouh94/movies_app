import 'package:flutter/material.dart';
import 'package:movies_app/core/helpers/extensions/number_extensions.dart';

import 'custom_shimmer.dart';

class CustomShimmerList extends StatelessWidget {
  final int itemCount;
  final double? height;
  final Widget? child;
  final bool scrollable;
  const CustomShimmerList({
    super.key,
    this.itemCount = 20,
    this.height,
    this.child,
    this.scrollable = true,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: !scrollable,
      physics: scrollable
          ? const AlwaysScrollableScrollPhysics()
          : const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        return SizedBox(
          width: double.infinity,
          height: height,
          child: child ?? const CustomShimmer(),
        );
      },
      separatorBuilder: (context, index) => 10.hSpace,
      itemCount: itemCount,
    );
  }
}
