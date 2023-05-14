// ignore_for_file: must_be_immutable

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:save_water/events/event_menu.dart';
import 'package:save_water/home/profile_page.dart';
import 'package:save_water/scannable_tracker/scannable_tracker.dart';
import 'package:save_water/theme/theme.dart';
import 'package:save_water/tracker/watertracker_menu.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key, required this.user}) : super(key: key);

  User user;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  PageController pageController = PageController();

  void onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

  List<Widget> getpages() {
    return [
      const WaterMenu(),
      const ScannableTracker(),
      const eventMenu(),
      ProfilePage(user: widget.user),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: getpages()[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTap,
        type: BottomNavigationBarType.fixed,
        backgroundColor: primaryColor,
        elevation: 0,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_outlined),
            activeIcon: Icon(Icons.qr_code),
            label: "Scan",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_outlined),
            activeIcon: Icon(Icons.event),
            label: "Events",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            activeIcon: Icon(Icons.account_circle),
            label: "Profile",
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
