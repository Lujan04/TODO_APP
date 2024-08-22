import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final auth = FirebaseAuth.instance;

  Future<User?> createUserEmailPswrd(
    String emailinput,
    String pswrdinput,
  ) async {
    try {
      final credentials = await auth.createUserWithEmailAndPassword(
          email: emailinput, password: pswrdinput);

      return credentials.user;
    } catch (a) {
      print('Algo salio mal $a');
    }
    return null;
  }

  Future<User?> loginUserEmailPswrd(
      String emailinput, String pswrdinput) async {
    try {
      final credentials = await auth.signInWithEmailAndPassword(
          email: emailinput, password: pswrdinput);

      return credentials.user;
    } catch (a) {
      print('Algo salio mal $a');
    }
    return null;
  }

  Future<void> signout() async {
    try {
      auth.signOut();
    } catch (a) {
      print('algo salio mal $a');
    }
  }
}
