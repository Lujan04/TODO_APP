import 'package:flutter/material.dart';
import 'package:todo_app/Screens/home_page.dart';

void goHome(BuildContext context) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => const HomePage()),
    (Route<dynamic> route) => false,
  );
}
