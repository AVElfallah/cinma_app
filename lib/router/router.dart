import 'package:cinma_app/screens/landing_page/landing_page.dart';
import 'package:cinma_app/screens/login/login_page.dart';
import 'package:cinma_app/screens/view_movie.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../screens/signup/signup_page.dart';

class AppRouter {
  AppRouter._();
  static final AppRouter _appRouter = AppRouter._();
  static AppRouter get i => _appRouter;

  static const String landingPage = '/landing_page';
  static const String viewMovie = '/view_movie';
  static const String loginPage = '/';
  static const String signupPage = '/signup_page';

  Route<dynamic>? routes(RouteSettings settings) {
    var xuser = FirebaseAuth.instance.currentUser;
    switch (settings.name) {
      case '/':
        if (xuser == null) {
          return MaterialPageRoute(
            builder: (context) => const LoginPage(),
            settings: settings,
          );
        } else {
          return MaterialPageRoute(
            builder: (context) => const LandingPage(),
            settings: settings,
          );
        }
      case '/signup_page':
        return MaterialPageRoute(
          builder: (context) => const SignupPage(),
          settings: settings,
        );
      case '/landing_page':
        return MaterialPageRoute(
          builder: (context) => const LandingPage(),
          settings: settings,
        );

      case '/view_movie':
        return MaterialPageRoute(
          builder: (context) => const ViewMovieScreen(),
          settings: settings,
        );
      default:
        throw Exception('Invalid route: ${settings.name}');
    }
  }
}
