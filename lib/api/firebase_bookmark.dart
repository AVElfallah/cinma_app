import 'package:cinma_app/models/results.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseBookMarks {
  FirebaseBookMarks._();
  static final FirebaseBookMarks _firebaseBookMarks = FirebaseBookMarks._();
  static FirebaseBookMarks get i => _firebaseBookMarks;
  final String collectionName = 'bookmarks';
  final User? xUser = FirebaseAuth.instance.currentUser;

  Future<bool> saveToBookMarks(Results results) async {
    try {
      var re = await FirebaseDatabase.instance
          .ref('users')
          .child(xUser!.uid)
          .child(collectionName)
          .child(results.id.toString())
          .set(results.toJson());
      re;
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> checkIFBookMarked(String id) async {
    try {
      var re = await FirebaseDatabase.instance
          .ref('users')
          .child(xUser!.uid)
          .child(collectionName)
          .child(id)
          .once();

      if (re.snapshot.value != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteFromBookMarks(String id) async {
    try {
      var re = await FirebaseDatabase.instance
          .ref('users')
          .child(xUser!.uid)
          .child(collectionName)
          .child(id)
          .remove();
      re;
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<Results>> getAllBookMarks() async {
    var re = await FirebaseDatabase.instance
        .ref('users')
        .child(xUser!.uid)
        .child(collectionName)
        .get();
    var middleMap = (re.value as Map).values;

    return [for (Map i in middleMap) Results.fromJson(i)];
  }
}
