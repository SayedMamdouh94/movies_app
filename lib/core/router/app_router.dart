import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/di/dependency_injection.dart';
import 'package:movies_app/core/router/routes.dart';
import 'package:movies_app/core/style/app_colors.dart';
import 'package:movies_app/features/person_details/presentation/cubit/person_details_cubit.dart';
import 'package:movies_app/features/person_details/presentation/ui/screens/person_details_screen.dart';
import 'package:movies_app/features/splash/presentation/ui/splash_screen.dart';
import 'package:movies_app/features/popular_people/presentation/cubit/popular_people_cubit.dart';
import 'package:movies_app/features/popular_people/presentation/ui/screens/popular_people_screen.dart';

class AppRouter {
  PageRoute? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return _getPageRoute(const SplashScreen());

      case Routes.popularPeople:
        return _getPageRoute(
          BlocProvider(
            create: (context) =>
                PopularPeopleCubit(getIt())..loadPopularPeople(),
            child: const PopularPeopleScreen(),
          ),
        );
      case Routes.personDetails:
        final personId = settings.arguments as int;
        return _getPageRoute(
          BlocProvider(
            create: (context) =>
                PersonDetailsCubit(getIt())..loadPersonDetails(personId),
            child: PersonDetailsScreen(personId: personId),
          ),
        );

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
