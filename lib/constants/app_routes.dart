import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:weather_app/views/sign_up.dart';
import '../views/home_screen.dart';
import '../views/login_screen.dart';

class Routes {
  static const String homeRoute = '/home';
  static const String loginRoute = '/login';
  static const String signUpRoute = '/signUp';

  static Route? getRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(
          builder: (context) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              SemanticsService.announce(
                "Home Screen loaded. Default navigation.",
                TextDirection.ltr,
              );
            });
            return HomeScreen();
          },
        );

      case loginRoute:
        return MaterialPageRoute(
          builder: (context) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              SemanticsService.announce(
                "Login Screen loaded. Default navigation.",
                TextDirection.ltr,
              );
            });
            return const LoginScreen();
          },
        );

      case signUpRoute:
        return MaterialPageRoute(
          builder: (context) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              SemanticsService.announce(
                "Sign Up Screen loaded. Default navigation.",
                TextDirection.ltr,
              );
            });
            return const SignUpPage();
          },
        );

      case null:
      default:
        return MaterialPageRoute(
          builder: (context) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              SemanticsService.announce(
                "Home Screen loaded. Default navigation.",
                TextDirection.ltr,
              );
            });
            return HomeScreen();
          },
        );
    }
  }
}
