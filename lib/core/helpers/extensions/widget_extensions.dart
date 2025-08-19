import 'package:flutter/material.dart';

extension PaddingEx on Widget {
  Widget paddingAll(double padding) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: this,
    );
  }

  Widget paddingSymmetric({double vertical = 0, double horizontal = 0}) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: vertical,
        horizontal: horizontal,
      ),
      child: this,
    );
  }

  Widget paddingOnly(
      {double top = 0, double end = 0, double bottom = 0, double start = 0}) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
        top: top,
        end: end,
        bottom: bottom,
        start: start,
      ),
      child: this,
    );
  }

  Widget paddingFromLTRB(double left, double top, double right, double bottom) {
    return Padding(
      padding: EdgeInsets.fromLTRB(left, top, right, bottom),
      child: this,
    );
  }
}
