// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:save_water/theme/theme.dart';
import 'package:save_water/widgets/image_card.dart';
import 'package:connectivity/connectivity.dart';

class eventMenu extends StatefulWidget {
  const eventMenu({Key? key}) : super(key: key);

  @override
  State<eventMenu> createState() => _eventMenuState();
}

class _eventMenuState extends State<eventMenu> {
  bool _buttonsEnabled = true;

  @override
  void initState() {
    super.initState();
    checkConnectivity();
  }

  Future<void> checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        _buttonsEnabled = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Events',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
          ),
          backgroundColor: primaryColor,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                InkWell(
                    onTap: _buttonsEnabled
                        ? () {
                            Navigator.pushNamed(
                                context, '/home/event/international');
                          }
                        : null,
                    child: const ImageCard(
                      title: 'International Events',
                      description: 'Events happening all over the world',
                      image: AssetImage('assets/images/intl_event.png'),
                    )),
                InkWell(
                    onTap: _buttonsEnabled
                        ? () {
                            Navigator.pushNamed(context, '/home/event/local');
                          }
                        : null,
                    child: const ImageCard(
                      title: 'Local Events',
                      description:
                          'Find out about all the events happening in UAE',
                      image: AssetImage('assets/images/local_event.png'),
                    )),
                InkWell(
                  onTap: _buttonsEnabled
                      ? () {
                          Navigator.pushNamed(context, '/home/gallery');
                        }
                      : null,
                  child: const ImageCard(
                    title: "Gallery",
                    description: "A collection of fond memories.",
                    image: AssetImage("assets/images/gallery.png"),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
