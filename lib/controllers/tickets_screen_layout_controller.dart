import 'package:cinma_app/models/book_details_model.dart';
import 'package:flutter/material.dart';

import '../api/firebase_tickets.dart';

class TicketsScreenLayoutController extends ChangeNotifier {
  TicketsScreenLayoutController() {
    FirebaseTickets.i.getTickets().then((value) async {
      tickets = value;
      notifyListeners();
    });
  }

  List<BookDetailsModel?> tickets = [];

  refreshTikets() async {
    tickets = await FirebaseTickets.i.getTickets();
  }
}
