import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:save_water/authentication/authentication.dart';
import 'package:save_water/home/home_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Authentication();
        }

        // Render application if signed in
        return HomePage(user: snapshot.data!);
      },
    );
  }
}
