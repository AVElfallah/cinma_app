import 'package:cinma_app/api/firebase_tickets.dart';
import 'package:cinma_app/controllers/tickets_screen_layout_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cinma_app/constants/constants.dart';
import 'package:provider/provider.dart';

import '../../../router/router.dart';

class TicketsScreenLayout extends StatelessWidget {
  const TicketsScreenLayout({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TicketsScreenLayoutController>(
        create: (_) => TicketsScreenLayoutController(),
        builder: (context, _) {
          var watch = context.watch<TicketsScreenLayoutController>();
          var read = context.read<TicketsScreenLayoutController>();
          return Scaffold(
            body: ListView.builder(
              itemBuilder: (_, i) {
                var date = DateFormat('dd/MM/y').format(
                  watch.tickets[i]!.date!,
                );
                var time = DateFormat('hh:mm a').format(
                  watch.tickets[i]!.time!,
                );
                return InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(AppRouter.viewMovie,
                        arguments: {'results': watch.tickets[i]!.movie});
                  },
                  child: Card(
                    elevation: 20,
                    margin: const EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Image.network(
                          watch.tickets[i]!.movie!.backdrop_path!
                              .toNetworkImagePath(),
                        ),
                        ListTile(
                          title: Text(
                            watch.tickets[i]!.movie!.title ?? '',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          isThreeLine: true,
                          subtitle: Text(
                            '$date - $time',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.amber.shade700,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: watch.tickets.length,
            ),
          );
        });
  }
}
