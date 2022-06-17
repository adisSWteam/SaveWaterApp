import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfire_ui/auth.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProfileScreen(
        actions: [
          SignedOutAction((context) {
            Navigator.of(context).pushReplacementNamed('/auth');
          }),
        ],
      ),
    );
  }
}
