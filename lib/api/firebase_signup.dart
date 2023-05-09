import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class FirebaseSignup {
  FirebaseSignup._();
  static final FirebaseSignup _firebaseSignup = FirebaseSignup._();
  static FirebaseSignup get i => _firebaseSignup;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  signup(
      {required String email,
      required String password,
      required String name,
      required String phone}) async {
    try {
      //SECTION -  sing in with email and password
      var xrUser = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      xrUser.user!.updateDisplayName(name);
      //SECTION -  save user data in database
      debugPrint(xrUser.user!.uid);
      // ignore: unnecessary_null_comparison
      if (xrUser != null) {
        _database.ref('users').child(xrUser.user!.uid).set(
          {'phone': phone},
        );
      } else {
        return false;
      }
      return true;
    } catch (e) {
      return false;
    }
  }
}
