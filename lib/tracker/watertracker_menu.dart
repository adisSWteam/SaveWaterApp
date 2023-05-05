import 'package:flutter/material.dart';
import 'package:save_water/theme/theme.dart';
import 'package:save_water/widgets/image_card.dart';

// ignore: camel_case_types
class waterMenu extends StatefulWidget {
  const waterMenu({Key? key}) : super(key: key);

  @override
  State<waterMenu> createState() => _waterMenuState();
}

// ignore: camel_case_types
class _waterMenuState extends State<waterMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Water Consumption Tracker',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.info, color: Colors.white),
              onPressed: () {
                Navigator.pushNamed(context, '/home/thanks');
              },
            ),
          ],
          backgroundColor: primaryColor,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/home/water/manual');
                    },
                    child: const ImageCard(
                      title: 'Manual Tracker',
                      description:
                          'Track your water consumption by filling in the questionnaire and compare it with your local usage. Save more water and money!',
                      image: AssetImage('assets/images/tracker.png'),
                    )),
                InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/home/water/scan');
                    },
                    child: const ImageCard(
                      title: 'Scan Tracker',
                      description:
                          'Track your water usage by scanning your water bill and compare it with your local usage. Save more water and money!',
                      image: AssetImage('assets/images/scan.png'),
                    )),
                InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/home/water/history');
                    },
                    child: const ImageCard(
                      title: 'History',
                      description:
                          'See and analyse how much water you have used.',
                      image: AssetImage('assets/images/history.png'),
                    )),
              ],
            ),
          ),
        ));
  }
}
