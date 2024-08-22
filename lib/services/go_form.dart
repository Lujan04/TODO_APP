import 'package:flutter/material.dart';
import 'package:todo_app/Screens/login_register.dart';

void goHome(BuildContext context) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => const LoginRegister()),
    (Route<dynamic> route) => false,
  );
}
