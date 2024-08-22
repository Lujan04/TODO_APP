import 'package:flutter/material.dart';
import 'package:todo_app/services/auth.dart';

final auth = Auth();

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(),
        child: SafeArea(
            child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('homePage'),
              const SizedBox(height: 40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                    foregroundColor: Colors.white),
                onPressed: () {
                  auth.signout;
                  print('Signout button pressed');
                },
                child: const Text('Singout'),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
