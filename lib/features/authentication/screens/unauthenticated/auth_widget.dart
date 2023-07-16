import 'package:diem/features/authentication/repositories/auth.dart';
import 'package:diem/features/authentication/screens/unauthenticated/login_page.dart';
import 'package:diem/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthWidget extends StatefulWidget {
  const AuthWidget({super.key});

  @override
  State<AuthWidget> createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Auth().authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasData) {
            final user = snapshot.data;
            if (user == null) {
              return const LoginPage();
            } else {
              return const MyHomePage();
            }
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return const LoginPage();
          }
        });
  }
}
// FutureBuilder<User?>(
//       builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return CircularProgressIndicator();
//         } else if (snapshot.hasData) {
//           final user = snapshot.data;
//           if (user == null) {
//             return LoginPage();
//           } else {
//             return MyHomePage();
//           }
//         } else if (snapshot.hasError) {
//           return Text('Error: ${snapshot.error}');
//         } else {
//           return LoginPage();
//         }
//       },
//     );
//
