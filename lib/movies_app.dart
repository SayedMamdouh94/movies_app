import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/local_secure_storage/local_storage.dart';
import 'package:movies_app/core/router/app_navigator.dart';
import 'package:movies_app/core/router/app_router.dart';
import 'package:movies_app/core/router/routes.dart';

import 'core/localization/generated/l10n.dart';
import 'core/style/app_themes.dart';

class MoviesApp extends StatelessWidget {
  const MoviesApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: navigator,
          locale: LocalStorage.getLanguage == 'ar'
              ? const Locale('ar', 'EG')
              : const Locale('en', 'US'),
          supportedLocales: const [Locale('ar', 'EG'), Locale('en', 'US')],
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          theme: AppThemes.lightTheme,
          initialRoute: Routes.splash,
          onGenerateRoute: (settings) => AppRouter().onGenerateRoute(settings),
        );
      },
    );
  }
}
