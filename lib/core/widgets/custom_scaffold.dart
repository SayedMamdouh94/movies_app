import 'package:flutter/material.dart';
import 'package:movies_app/core/widgets/custom_tap.dart';
import 'package:movies_app/core/helpers/extensions/context_extenstions.dart';

import 'custom_back_button.dart';

class CustomScaffold extends StatelessWidget {
  final Widget? body;
  final Color? backgroundColor;
  final Widget? floatingActionButton;
  final String? title;
  final List<Widget>? actions;
  final bool enableUnFocusTapButton;
  final bool enableSafeArea;
  final Widget? bottomNavBar;
  final bool extendBody;
  final bool resizeToAvoidBottomInset;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final bool enableBackButton;
  final bool centerTitle;
  final VoidCallback? onBackButtonPressed;
  const CustomScaffold({
    super.key,
    required this.body,
    this.backgroundColor,
    this.floatingActionButton,
    this.title,
    this.actions,
    this.enableUnFocusTapButton = true,
    this.enableSafeArea = true,
    this.bottomNavBar,
    this.extendBody = false,
    this.resizeToAvoidBottomInset = true,
    this.floatingActionButtonLocation,
    this.enableBackButton = true,
    this.centerTitle = true,
    this.onBackButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavBar,
      floatingActionButtonLocation: floatingActionButtonLocation,
      extendBody: extendBody,
      appBar: title == null && actions == null && !enableBackButton
          ? null
          : AppBar(
              centerTitle: centerTitle,
              title: Text(title ?? ''),
              actions: actions,
              leading: (enableBackButton && Navigator.canPop(context))
                  ? CustomBackButton(onTap: onBackButtonPressed)
                  : null,
            ),
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      body: SafeArea(
        top: enableSafeArea,
        bottom: enableSafeArea,
        left: enableSafeArea,
        right: enableSafeArea,
        child: CustomTap(
          onTap: () => enableUnFocusTapButton ? context.unfocus() : null,
          child: body ?? Container(),
        ),
      ),
    );
  }
}
