import 'package:cinma_app/router/router.dart';
import 'package:cinma_app/screens/landing_page/layouts/home_screen.dart';
import 'package:cinma_app/screens/landing_page/layouts/saved_screen_layout.dart';
import 'package:cinma_app/screens/landing_page/layouts/tickets_screen_layout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../styles/cinema_theme.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<StatefulWidget> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  late PageController _controller;
  int currentIndex = 0;
  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Cinema",
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: CinemaAppTheme.background,
        foregroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: CinemaAppTheme.titleColor,
            ),
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, AppRouter.loginPage);
            },
          ),
        ],
      ),
      backgroundColor: CinemaAppTheme.background,
      body: PageView(controller: _controller, children: const [
        HomeScreenLayout(),
        SavedScreenLayout(),
        TicketsScreenLayout(),
      ]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (v) {
          _controller.jumpToPage(v);
          setState(() {
            currentIndex = v;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: CinemaAppTheme.titleColor,
            ),
            activeIcon: Icon(
              Icons.home,
              color: Colors.red,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.bookmark,
              color: CinemaAppTheme.titleColor,
            ),
            activeIcon: Icon(
              Icons.bookmark,
              color: Colors.red,
            ),
            label: "Saved",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.tv,
              color: CinemaAppTheme.titleColor,
            ),
            activeIcon: Icon(
              Icons.tv,
              color: Colors.red,
            ),
            label: "Tickets",
          ),
        ],
      ),
    );
  }
}
