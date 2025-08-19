import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies_app/core/helpers/extensions/string_extensions.dart';

class CustomAuthLogo extends StatelessWidget {
  const CustomAuthLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'app_logo'.svg,
      height: 60.h,
      width: 120.w,
      fit: BoxFit.contain,
    );
  }
}
