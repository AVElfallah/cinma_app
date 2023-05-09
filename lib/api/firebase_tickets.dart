import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import '../models/book_details_model.dart';

class FirebaseTickets {
  FirebaseTickets._();
  static final FirebaseTickets _firebaseTickets = FirebaseTickets._();
  static FirebaseTickets get i => _firebaseTickets;
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> createATicket(BookDetailsModel bookDetails) async {
    try {
      await _database
          .ref('users')
          .child(_auth.currentUser!.uid)
          .child('tickets')
          .push()
          .set(bookDetails.toJson());

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<BookDetailsModel?>> getTickets() async {
    try {
      var data = await _database
          .ref('users')
          .child(_auth.currentUser!.uid)
          .child('tickets')
          .get();
      var ls = (data.value as Map).values.toList();

      return ls.map((e) => BookDetailsModel.fromJson(e)).toList();
    } catch (e) {
      return [];
    }
  }
}
