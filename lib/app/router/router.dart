import 'package:amplify_news/ui/routes/home/home_view.dart';
import 'package:amplify_news/ui/routes/login/login_view.dart';
import 'package:amplify_news/ui/routes/otp_verify/otp_verify_view.dart';
import 'package:flutter/material.dart';

import '../../ui/routes/splash/splash_view.dart';

abstract class Routes {
  static const String splashView = '/';
  static const String loginView = '/login';
  static const String homeView = '/home';
  static const String otp = '/otp';
}

class Router {
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashView:
        return MaterialPageRoute(
          builder: (context) => const SplashView(),
          settings: settings,
        );
      case Routes.loginView:
        return MaterialPageRoute(
          builder: (context) => const LoginView(),
          settings: settings,
        );
      case Routes.homeView:
        return MaterialPageRoute(
          builder: (context) => const HomeView(),
          settings: settings,
        );
      case Routes.otp:
        return MaterialPageRoute(
          builder: (context) => const OtpVerifyView(),
          settings: settings,
        );

      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(),
          settings: settings,
        );
    }
  }
}
