import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movies_app/core/helpers/extensions/context_extenstions.dart';

class CustomLoadingIndicator extends StatelessWidget {
  final Color? color;
  final double size;
  const CustomLoadingIndicator({super.key, this.color, this.size = 50});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitDoubleBounce(
        size: size,
        color: color ?? context.colorScheme.primary,
      ),
    );
  }
}
