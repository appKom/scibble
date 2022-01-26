import 'package:flutter/material.dart';
import 'package:scibble/pages/auth/login.dart';
import 'package:scibble/pages/auth/web_login.dart';
import 'package:scibble/pages/home.dart';
import 'package:scibble/pages/invalid_route.dart';

class Routes {
  static const String login = "/";
  static const String webLogin = "/login/online";
  static const String home = "/home";
}

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case Routes.login:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case Routes.webLogin:
        return MaterialPageRoute(builder: (_) => OnlineLoginPage());
      case Routes.home:
        return MaterialPageRoute(builder: (_) => Home());
      default:
        return MaterialPageRoute(builder: (_) => InvalidRoute());
    }
  }
}
