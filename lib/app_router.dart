import 'package:flutter/material.dart';
import 'package:scibble/pages/auth/login.dart';
import 'package:scibble/pages/auth/web_login.dart';
import 'package:scibble/pages/home.dart';
import 'package:scibble/pages/invalid_route.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => LoginPage());
      case '/login/online':
        return MaterialPageRoute(builder: (_) => OnlineLoginPage());
      case '/home':
        return MaterialPageRoute(builder: (_) => Home());
      default:
        return MaterialPageRoute(builder: (_) => InvalidRoute());
    }
  }
}
