import 'package:flutter/material.dart';
import 'package:movies_app/core/widgets/custom_confirmation_dialog.dart';
import 'package:movies_app/core/widgets/custom_loading_dialog.dart';
import 'package:movies_app/core/widgets/custom_text_field_dialog.dart';

import '../../localization/generated/l10n.dart';

extension NavigationEx on BuildContext {
  Future<Object?> pushNamed(String routeName, {Object? arguments}) async {
    return Navigator.pushNamed(this, routeName, arguments: arguments);
  }

  Future<Object?> pushReplacementNamed(String routeName,
      {Object? arguments}) async {
    return Navigator.pushReplacementNamed(
      this,
      routeName,
      arguments: arguments,
    );
  }

  void pop({Object? data}) {
    Navigator.pop(this, data);
  }

  Future<Object?> pushNamedAndRemoveUntil(String routeName,
          {Object? arguments, String? initialRoute}) =>
      Navigator.pushNamedAndRemoveUntil(
        this,
        routeName,
        (route) => false,
        arguments: arguments,
      );
}

extension FocusEx on BuildContext {
  void requestFocus(FocusNode focusNode) {
    FocusScope.of(this).requestFocus(focusNode);
  }

  void unfocus() {
    FocusScope.of(this).unfocus();
  }

  void nextFocus() {
    FocusScope.of(this).nextFocus();
  }
}

extension LocaleEx on BuildContext {
  AppLocalizations get locale => AppLocalizations.of(this);
}

extension ThemeEx on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;
}

extension MediaQueryEx on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  double get height => mediaQuery.size.height;

  double get width => mediaQuery.size.width;
}

extension DialogsEx on BuildContext {
  Future<void> showLoadingDialog() {
    return showDialog(
      context: this,
      barrierDismissible: false,
      builder: (context) => const CustomLoadingDialog(),
    );
  }

  Future<void> showConfirmationDialog({
    required String title,
    required String content,
    required VoidCallback onConfirm,
  }) {
    return showDialog(
      context: this,
      barrierDismissible: true,
      builder: (context) => CustomConfirmationDialog(
        title: title,
        content: content,
        onConfirm: onConfirm,
      ),
    );
  }

  Future<void> showTextFieldDialog({
    required String title,
    required String hintText,
    required String Function(String) onConfirm,
    IconData? icon,
    String? content,
  }) {
    return showDialog(
        context: this,
        builder: (context) => CustomTextFieldDialog(
              title: title,
              hintText: hintText,
              onConfirm: onConfirm,
              icon: icon,
              content: content,
            ));
  }
}
