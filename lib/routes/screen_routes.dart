import 'package:flutter/material.dart';
import 'package:todo_app/Screens/home_page.dart';
import 'package:todo_app/Screens/login_register.dart';

class ScreenRoutes {
  static Map<String, WidgetBuilder> routes = {
    '/home': (context) => const HomePage(),
    '/login': (context) => const LoginRegister(),
  };
}
