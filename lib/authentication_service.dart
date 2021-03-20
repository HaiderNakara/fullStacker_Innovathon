import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:inventory_management_system/Screens/Home/home_screen.dart';
import 'package:inventory_management_system/Screens/sign_in/sign_in_screen.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;
  AuthenticationService(this._firebaseAuth);

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signIn(
      {@required String email,
      @required String password,
      @required BuildContext context}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<void> signUp(
      {@required String email,
      @required String password,
      @required BuildContext context}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await _firebaseAuth.signOut();
      Navigator.pushReplacementNamed(context, SignInScreen.routeName);
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}
