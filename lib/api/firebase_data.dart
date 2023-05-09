import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseData {
  FirebaseData._();
  static final FirebaseData _firebaseData = FirebaseData._();
  static FirebaseData get i => _firebaseData;
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseDatabase _database = FirebaseDatabase.instance;

  Future<String?> getPhoneNumber() async {
    String phone =
        ((await _database.ref('users').child(_auth.currentUser!.uid).get())
            .value as Map)['phone'];
    return phone;
  }
}
