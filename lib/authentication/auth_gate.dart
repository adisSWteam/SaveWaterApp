import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:save_water/authentication/authentication.dart';
import 'package:save_water/home/home_screen.dart';
import 'package:save_water/acknolage/acknolageInital.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  bool homeState = false;

  void getState() async {
    final prefs = await SharedPreferences.getInstance();
    final state = prefs.getBool('showHome') ?? false;
    homeState = state;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => getState());
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Authentication();
        }

        if (homeState == false) {
          return thanks(
            user: snapshot.data!,
          );
        } else {
          return HomeScreen(user: snapshot.data!);
        }
      },
    );
  }
}
