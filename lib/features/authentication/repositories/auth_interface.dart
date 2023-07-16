import 'package:firebase_auth/firebase_auth.dart';

abstract class IAuth {
  User? getCurrentUser();
  Stream<User?> authStateChanges();
  Future<void> signInWithEmailAndPassword(String email, String password);
  Future<void> createAccountWithEmailAndPassword(String email, String password);
  Future<void> signOut();
}
