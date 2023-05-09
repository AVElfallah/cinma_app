import 'package:flutter/material.dart';

import '../styles/cinema_theme.dart';

class TabLayoutView extends StatelessWidget {
  final TabController? tabcontroller;

  const TabLayoutView({super.key, @required this.tabcontroller});
  @override
  Widget build(BuildContext context) {
    return TabBar(
        controller: tabcontroller,
        indicatorColor: Colors.transparent,
        labelColor: const Color(0xFF303030),
        isScrollable: true,
        labelPadding: const EdgeInsets.only(right: 40.0),
        unselectedLabelColor: const Color(0xFFb8b8b8),
        tabs: [
          _tab("Box Office"),
          _tab("Premier"),
          _tab("Trending"),
          _tab("Upcoming")
        ]);
  }

  Widget _tab(String title) => Tab(
        child: Text(
          title,
          style: TextStyle(
            fontFamily: CinemaAppTheme.Poppins,
            fontWeight: FontWeight.w600,
            fontSize: 16.0,
          ),
        ),
      );
}
