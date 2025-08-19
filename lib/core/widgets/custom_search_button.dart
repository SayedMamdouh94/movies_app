import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies_app/core/helpers/extensions/string_extensions.dart';
import 'package:movies_app/core/helpers/extensions/context_extenstions.dart';

class CustomSearchButton extends StatelessWidget {
  final VoidCallback onPressed;
  const CustomSearchButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      onPressed: () {
        context.unfocus();
        onPressed();
      },
      padding: const EdgeInsets.all(14),
      icon: SvgPicture.asset(
        'search'.svg,
      ),
      style: IconButton.styleFrom(
        backgroundColor: context.colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}
