import 'package:diem/features/authentication/repositories/auth.dart';
import 'package:diem/features/authentication/repositories/firebase/auth_firebase.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormFieldState> _signInEmailKey = GlobalKey<FormFieldState>();
  final TextEditingController _signInEmailController = TextEditingController();
  final GlobalKey<FormFieldState> _signInPasswordKey =
      GlobalKey<FormFieldState>();
  final TextEditingController _signInPasswordController =
      TextEditingController();

  final _loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          key: _loginFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  key: _signInEmailKey,
                  controller: _signInEmailController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  key: _signInPasswordKey,
                  controller: _signInPasswordController,
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  final String? email = _signInEmailKey.currentState?.value;
                  final String? password =
                      _signInPasswordKey.currentState?.value;

                  print('hello');
                  // await AuthFirebase().createAccountWithEmailAndPassword(
                  //     _signInEmailController.text.trim(),
                  //     _signInPasswordController.text.trim());
                  await AuthFirebase().signOut();
                },
                child: const Text("Login"),
              )
            ],
          )),
    );
  }
}
