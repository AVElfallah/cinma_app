import 'package:cinma_app/api/firebase_bookmark.dart';
import 'package:cinma_app/models/results.dart';
import 'package:flutter/material.dart';

class SavedScreenLayoutController extends ChangeNotifier {
  SavedScreenLayoutController() {
    FirebaseBookMarks.i.getAllBookMarks().then((value) {
      savedList = value;
      notifyListeners();
    });
  }
  List<Results?>? savedList = [];
  void deleteFromBookMarks(String id) async {
    bool xwait = await FirebaseBookMarks.i.deleteFromBookMarks(id);
    if (xwait) {
      refreshList();
      notifyListeners();
    }
  }

  void refreshList() async {
    FirebaseBookMarks.i.getAllBookMarks().then((value) {
      savedList = value;
      notifyListeners();
    });
  }
}
