import 'package:cinma_app/models/results.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:cinma_app/api/firebase_data.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';

import '../controllers/bottom_sheet_view_controller.dart';

class TicketBookingBottomSheet extends StatefulWidget {
  const TicketBookingBottomSheet({super.key, required this.movie});
  final Results? movie;

  @override
  State<TicketBookingBottomSheet> createState() =>
      _TicketBookingBottomSheetState();
}

class _TicketBookingBottomSheetState extends State<TicketBookingBottomSheet> {
  var xuser = FirebaseAuth.instance.currentUser;
  String? phone = '';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => BottomSheetViewController(),
        builder: (context, _) {
          var watch = context.watch<BottomSheetViewController>();
          var read = context.read<BottomSheetViewController>();
          return AnimationLimiter(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: AnimationConfiguration.toStaggeredList(
                    duration: const Duration(milliseconds: 375),
                    childAnimationBuilder: (widget) => SlideAnimation(
                      verticalOffset: 50.0,
                      child: FadeInAnimation(
                        child: widget,
                      ),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Text(
                          'Book a Ticket',
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.headline6!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                  ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: TextFormField(
                          controller: TextEditingController(
                              text: xuser!.displayName ?? 'Sai'),
                          enabled: false,
                          decoration: const InputDecoration(
                            disabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            labelText: 'Name',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: TextFormField(
                          controller: TextEditingController(
                              text: xuser!.email ?? 'Sai'),
                          enabled: false,
                          decoration: const InputDecoration(
                            disabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            labelText: 'Email',
                          ),
                        ),
                      ),
                      FutureBuilder(
                          future: FirebaseData.i.getPhoneNumber(),
                          builder: (_, snap) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: TextFormField(
                                controller: TextEditingController(
                                  text: snap.hasData
                                      ? snap.data.toString()
                                      : '000',
                                ),
                                enabled: false,
                                decoration: const InputDecoration(
                                  disabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  labelText: 'Phone',
                                ),
                              ),
                            );
                          }),
                      const SizedBox(height: 16.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: TextFormField(
                          controller: watch.dateController,
                          readOnly: true,
                          onTap: () {
                            DatePicker.showDatePicker(
                              context,
                              showTitleActions: true,
                              minTime: DateTime.now(),
                              maxTime:
                                  DateTime.now().add(const Duration(days: 365)),
                              onConfirm: (date) {
                                read.changeDate(date);
                              },
                              currentTime: DateTime.now(),
                            );
                          },
                          decoration: const InputDecoration(
                            labelText: 'Cinema Date',
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: TextFormField(
                          controller: watch.timeController,
                          readOnly: true,
                          onTap: () {
                            DatePicker.showTimePicker(
                              context,
                              showTitleActions: true,
                              showSecondsColumn: false,
                              onConfirm: (time) {
                                read.changeTime(time);
                              },
                              currentTime: DateTime.now(),
                            );
                          },
                          decoration: const InputDecoration(
                            labelText: 'Cinema Time',
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Confirm Ticket Booking'),
                                  content: const Text(
                                    'Are you sure you want to book this ticket?',
                                  ),
                                  actionsAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('No'),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        read.bookATicket(Navigator.of(context),
                                            widget.movie!);
                                      },
                                      child: const Text('Yes'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: const Text('Book Ticket'),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
