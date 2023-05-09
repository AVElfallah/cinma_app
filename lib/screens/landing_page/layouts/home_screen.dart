import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../styles/cinema_theme.dart';
import '../../../ui_views/movies_tablayout_view.dart';
import '../../../ui_views/tablayout_view.dart';

class HomeScreenLayout extends StatefulWidget {
  const HomeScreenLayout({super.key});

  @override
  State<HomeScreenLayout> createState() => _HomeScreenLayoutState();
}

class _HomeScreenLayoutState extends State<HomeScreenLayout>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  var xUser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(left: 30.0),
      children: [
        const SizedBox(
          height: 10.0,
        ),
        // SearchBarView(),
        const SizedBox(
          height: 40.0,
        ),
        Text(
          "Hi,${xUser?.displayName ?? ''}",
          style: TextStyle(
            fontFamily: CinemaAppTheme.Poppins,
            fontWeight: FontWeight.w600,
            fontSize: 17.0,
            letterSpacing: 0.3,
            color: CinemaAppTheme.titleColor,
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
        Text(
          "What you Gonna watch today ?",
          style: TextStyle(
            fontFamily: CinemaAppTheme.OpenSans,
            fontWeight: FontWeight.w500,
            fontSize: 15.5,
            letterSpacing: 0.3,
            color: CinemaAppTheme.subTitleColor,
          ),
        ),
        const SizedBox(
          height: 40.0,
        ),
        TabLayoutView(
          tabcontroller: _tabController,
        ),
        const SizedBox(
          height: 20.0,
        ),
        MoviesTablayoutView(
          tabController: _tabController,
        ),
        const SizedBox(
          height: 30.0,
        ),
        const SizedBox(
          height: 30.0,
        ),
      ],
    );
  }
}
