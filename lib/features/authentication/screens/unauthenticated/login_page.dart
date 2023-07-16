import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormFieldState> _signInEmailKey = GlobalKey<FormFieldState>();
  GlobalKey<FormFieldState> _signInPasswordKey = GlobalKey<FormFieldState>();
  GlobalKey<FormState> _loginFormState = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          key: _loginFormState,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  key: _signInEmailKey,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  key: _signInPasswordKey,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  final String? email = _signInEmailKey.currentState?.value;
                  final String? password =
                      _signInPasswordKey.currentState?.value;

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Oten'),
                      duration: Duration(seconds: 3),
                    ),
                  );
                },
                child: Text("Login"),
              )
            ],
          )),
    );
  }
}
