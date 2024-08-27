import 'package:flutter/material.dart';
import 'package:todo_app/services/auth.dart';

final auth = Auth();

final emailcontroller = TextEditingController();
final pswrdcontroller = TextEditingController();

class LoginRegister extends StatelessWidget {
  const LoginRegister({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/background.jpg"),
                  fit: BoxFit.cover)),
          child: const SafeArea(
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 30),
                  CircleAvatar(
                      radius: 70, // Image radius
                      backgroundImage: AssetImage('assets/favicon.jpg')),
                  SizedBox(
                    height: 50,
                  ),
                  MyCustomForm(),
                ],
              ),
            ),
          ),
        ));
  }
}

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          EmailField(),
          const SizedBox(
            height: 80,
          ),
          PasswordField(),
          const SizedBox(
            height: 70,
          ),
          FormButtons(formKey: _formKey),
        ],
      ),
    );
  }
}

class FormButtons extends StatelessWidget {
  const FormButtons({
    super.key,
    required GlobalKey<FormState> formKey,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 0, 0, 0),
              foregroundColor: Colors.white),
          onPressed: () async {
            await _login(context);
            print('Login button pressed');
            if (_formKey.currentState!.validate()) {}
          },
          child: const Text('Enter'),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 0, 0, 0),
              foregroundColor: Colors.white),
          onPressed: () async {
            _signup(context);
            print('Register button pressed');
            if (_formKey.currentState!.validate()) {}
          },
          child: const Text('Register'),
        ),
        const SizedBox(width: 15),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 0, 0, 0),
              foregroundColor: Colors.white),
          onPressed: () {
            print('google button pressed');
            if (_formKey.currentState!.validate()) {}
          },
          child: const Text('Google'),
        ),
      ],
    );
  }
}

class EmailField extends StatelessWidget {
  EmailField({
    super.key,
  });
  final FocusNode foco = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 42.0),
      child: TextFormField(
        onTapOutside: (event) {
          foco.unfocus();
        },
        focusNode: foco,
        controller: emailcontroller,
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(
          labelText: 'Email',
          labelStyle: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.w600),
          suffixIcon: Icon(
            Icons.email_outlined,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          errorStyle: TextStyle(
            color: Color.fromARGB(255, 255, 0, 0),
            fontSize: 14,
          ),
        ),
        cursorColor: const Color.fromARGB(255, 0, 0, 0),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Error empty field';
          }
          final emailRegex =
              RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

          if (!emailRegex.hasMatch(value)) {
            return 'Please, enter a valid Email';
          }

          return null;
        },
      ),
    );
  }
}

class PasswordField extends StatelessWidget {
  final FocusNode foco = FocusNode();
  PasswordField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 42.0),
      child: TextFormField(
        onTapOutside: (event) {
          foco.unfocus();
        },
        focusNode: foco,
        controller: pswrdcontroller,
        obscureText: true,
        decoration: const InputDecoration(
          labelText: 'Password',
          labelStyle: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.w600),
          suffixIcon:
              Icon(Icons.key_sharp, color: Color.fromARGB(255, 255, 255, 255)),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          errorStyle: TextStyle(
            color: Color.fromARGB(255, 255, 0, 0),
            fontSize: 14,
          ),
        ),
        cursorColor:
            const Color.fromARGB(255, 0, 0, 0), // Cambia el color del cursor)

        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Error empty field';
          }
          final passwordRegex =
              RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)[A-Za-z\d]{8,}$');
          if (!passwordRegex.hasMatch(value)) {
            return '8 minus length ( 1 mayus, 1 minus and 1 number)';
          }
          return null;
        },
      ),
    );
  }
}

_signup(BuildContext context) async {
  final user = await auth.createUserEmailPswrd(
    emailcontroller.text,
    pswrdcontroller.text,
  );
  if (user != null) {
    print(
        'user created succesfully credentials email ${emailcontroller.text} pswrd ${pswrdcontroller.text} ');
    _gohome(context);
  } else if (user == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Error al crear el usuario'),
        backgroundColor: Colors.red, // Opcional: color de fondo del snackbar
        duration: Duration(seconds: 2), // Opcional: duración del snackbar
      ),
    );
  }
}

_login(BuildContext context) async {
  final user = await auth.loginUserEmailPswrd(
      emailcontroller.text, pswrdcontroller.text);
  if (user != null) {
    print('user login succesfully');
    _gohome(context);
  } else if (user == null) {
    // Mostrar Snackbar en caso de error
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Error al iniciar sesión'),
        backgroundColor: Colors.red, // Opcional: color de fondo del snackbar
        duration: Duration(seconds: 2), // Opcional: duración del snackbar
      ),
    );
  }
}

_gohome(BuildContext context) =>
    Navigator.pushReplacementNamed(context, '/home');
