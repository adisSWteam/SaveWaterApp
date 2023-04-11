// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:save_water/theme/theme.dart';
import 'package:save_water/events/event_menu.dart';
import 'package:save_water/tracker/watertracker_menu.dart';
import 'package:save_water/scannable_tracker/scannable_tracker.dart';
import 'package:save_water/home/profile_page.dart';

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

  List getpages() {
    return [
      waterMenu(),
      ScannableTracker(),
      eventMenu(),
      ProfilePage(user: widget.user),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   title: Text(
      //     'Main Menu',
      //     style: TextStyle(
      //         fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
      //   ),
      //   backgroundColor: primaryColor,
      //   centerTitle: true,
      // ),
      // body: PageView(
      //   controller: pageController,
      // ),
      body: getpages()[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTap,
        type: BottomNavigationBarType.fixed,
        backgroundColor: primaryColor,
        // backgroundColor: Colors.white,

        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.apps), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.camera_alt), label: "Scan"),
          BottomNavigationBarItem(
              icon: Icon(Icons.travel_explore_rounded), label: "Events"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: "Settings"),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(0.5),
        // selectedItemColor: Colors.black,
        // unselectedItemColor: Colors.grey.withOpacity(0.5),
        // showSelectedLabels: true,
        // showUnselectedLabels: true,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }
}
