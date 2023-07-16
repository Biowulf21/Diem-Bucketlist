import 'package:diem/features/authentication/repositories/auth_interface.dart';
import 'package:diem/features/authentication/repositories/firebase/auth_firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth implements IAuth {
  @override
  User? getCurrentUser() {
    User? user = AuthFirebase().getCurrentUser();
    return user;
  }

  @override
  Stream<User?> authStateChanges() {
    return AuthFirebase().authStateChanges();
  }

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await AuthFirebase().signInWithEmailAndPassword(email, password);
  }

  @override
  Future<void> createAccountWithEmailAndPassword(
      String email, String password) async {
    await AuthFirebase().createAccountWithEmailAndPassword(email, password);
  }

  @override
  Future<void> signOut() async {
    await AuthFirebase().signOut();
  }
}
