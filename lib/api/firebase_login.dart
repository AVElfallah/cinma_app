import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseLogin {
  FirebaseLogin._();
  static final FirebaseLogin _firebaseLogin = FirebaseLogin._();
  static FirebaseLogin get i => _firebaseLogin;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message.toString());
      return false;
    }
  }
}
