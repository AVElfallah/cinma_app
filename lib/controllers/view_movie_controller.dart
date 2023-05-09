import 'package:cinma_app/api/firebase_bookmark.dart';
import 'package:cinma_app/models/results.dart';
import 'package:flutter/material.dart';

class ViewMovieController extends ChangeNotifier {
  ViewMovieController(Results results) {
    FirebaseBookMarks.i.checkIFBookMarked(results.id.toString()).then((value) {
      isSaved = value;
      notifyListeners();
    });
  }
  bool isSaved = false;
  bool isBooked = false;
  void changeSaveState(Results results) async {
    if (isSaved) {
      bool xwait =
          await FirebaseBookMarks.i.deleteFromBookMarks(results.id.toString());
      if (xwait) {
        isSaved = false;
        notifyListeners();
      }
    } else {
      bool xwait = await FirebaseBookMarks.i.saveToBookMarks(results);
      if (xwait) {
        isSaved = true;
        notifyListeners();
      }
    }
  }
}
