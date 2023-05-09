import 'package:cinma_app/api/firebase_tickets.dart';
import 'package:cinma_app/models/results.dart';
import 'package:cinma_app/router/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../models/book_details_model.dart';

class BottomSheetViewController extends ChangeNotifier {
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  DateTime? date;
  DateTime? time;
  changeDate(DateTime date) {
    dateController.text = '${date.day}/${date.month}/${date.year}';
    this.date = date;
    notifyListeners();
  }

  changeTime(DateTime time) {
    timeController.text = '${time.hour}:${time.minute}';
    this.time = time;
    notifyListeners();
  }

  void bookATicket(NavigatorState state, Results movie) async {
    if (date != null && time != null) {
      var back = await FirebaseTickets.i.createATicket(BookDetailsModel(
        date: date,
        time: time,
        movie: movie,
      ));
      if (back) {
        print('done');
        state.pushNamedAndRemoveUntil(
          AppRouter.landingPage,
          (route) => false,
        );
      } else {
        print('error');
      }
    }
  }
}
