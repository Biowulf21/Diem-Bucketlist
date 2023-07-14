import 'package:firebase_auth/firebase_auth.dart';
import 'package:diem/features/authentication/repositories/auth_interface.dart';

class Auth implements AuthInterface {
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Stream<User?> authStateChanges() {
    return _auth.authStateChanges();
  }

  @override
  Future<void> createAccountWithEmailAndPassword(
      String email, String password) async {
    await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
