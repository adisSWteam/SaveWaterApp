import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:save_water/home/profile_page.dart';
import 'package:save_water/widgets/image_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            'Main Menu',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
          ),
          backgroundColor: const Color(0xFF4B39EF),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProfilePage(user: user)));
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/home/water');
                },
                child: const ImageCard(
                  title: "Water Consumption Tracker",
                  description:
                      "Track your water consumption by using our manual tracker or by scanning your bill!",
                  image: AssetImage("assets/images/watertracker1.png"),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/home/event');
                },
                child: const ImageCard(
                  title: "Events",
                  description:
                      "Find all the upcoming events regarding the save water campaign locally or internationally.",
                  image: AssetImage("assets/images/events.png"),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/home/gallery');
                },
                child: const ImageCard(
                  title: "Gallery",
                  description: "A collection of fond memories.",
                  image: AssetImage("assets/images/image.png"),
                ),
              ),
            ],
          ),
        ));
  }
}
