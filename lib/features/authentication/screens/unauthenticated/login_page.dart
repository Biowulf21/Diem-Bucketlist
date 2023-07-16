import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormFieldState> _signInKey = GlobalKey<FormFieldState>();
  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
      children: [
        TextFormField(
          key: _signInKey,
        ),
        TextFormField(
          key: _signInKey,
        )
      ],
    ));
  }
}
