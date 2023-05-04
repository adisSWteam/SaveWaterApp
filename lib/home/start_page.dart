import 'package:flutter/material.dart';

class Start extends StatefulWidget {
  const Start({Key? key}) : super(key: key);

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  void load() async {
    await Future.delayed(Duration(seconds: 1), () {
      Navigator.pushNamedAndRemoveUntil(context, '/auth', (route) => false);
    });
  }

  @override
  void initState() {
    super.initState();
    load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/waterbg.png'),
                fit: BoxFit.cover)),
        child: Stack(
          children: <Widget>[
            Align(
                alignment: AlignmentDirectional(0.85, -0.8),
                child: Image.asset(
                  'assets/images/waterdrop.png',
                  height: 100,
                )),
            Align(
              alignment: AlignmentDirectional(0, 0),
              child: Text(
                'Welcome!',
                style: TextStyle(
                    fontSize: 60,
                    letterSpacing: 2.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0.07, 0.52),
              child: Text(
                'HOLD THAT DROP',
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0.02, 0.61),
              child: Text(
                'An Intiative By',
                style: TextStyle(
                  color: Color(0xFF40DBFF),
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0, 0.7),
              child: Text(
                'Abu Dhabi Indian School, Al Muroor',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
