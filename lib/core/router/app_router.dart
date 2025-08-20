import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/core/router/routes.dart';
import 'package:movies_app/core/style/app_colors.dart';
import 'package:movies_app/features/splash/presentation/ui/splash_screen.dart';
import 'package:movies_app/features/intro/presentation/ui/intro_screen.dart';

class AppRouter {
  PageRoute? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return _getPageRoute(const SplashScreen());

      case Routes.intro:
        return _getPageRoute(const IntroScreen());

      default:
        return null;
    }
  }

  static PageRoute _getPageRoute(Widget screen) {
    if (Platform.isIOS) {
      return CupertinoPageRoute(builder: (_) => _wrapWithBackground(screen));
    } else {
      return MaterialPageRoute(builder: (_) => _wrapWithBackground(screen));
    }
  }

  // Wrapper to ensure consistent background color during transitions
  static Widget _wrapWithBackground(Widget screen) {
    return Container(color: AppColors.kBackground, child: screen);
  }
}
