import 'package:flutter/material.dart';

import 'package:movies_app/core/helpers/extensions/context_extenstions.dart';

class CustomText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final TextDecoration? textDecoration;
  final TextOverflow? overflow;
  final int? maxLines;
  final double? height;
  const CustomText(
    this.text, {
    super.key,
    this.style,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.textAlign,
    this.textDecoration,
    this.overflow,
    this.maxLines,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: (style ?? context.textTheme.bodyMedium)?.copyWith(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        decoration: textDecoration,
        overflow: overflow,
        height: height,
      ),
      maxLines: maxLines,
      textAlign: textAlign,
    );
  }
}
