  import 'package:flutter/material.dart';
import 'package:save_water/theme/theme.dart';

class ScanTrackerResultPage extends StatelessWidget {
  final String scannedText;
  ScanTrackerResultPage({required this.scannedText});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Scan Tracker Result',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
          ),
          backgroundColor: primaryColor,
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
                child: Image.asset(
              'assets/ind_assets/whale.png',
              height: 100,
              width: 100,
              fit: BoxFit.contain,
            )),
            Center(
                child: Padding(
              padding: EdgeInsets.all(14),
              child: Column(
                children: [
                  Text(
                    'Your money spend',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.lightBlueAccent,
                        fontFamily: 'Capriola'),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'on water is:',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.lightBlueAccent,
                        fontFamily: 'Capriola'),
                  ),
                  SizedBox(height: 8),
                  Text(
                    scannedText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.lightBlueAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )),
            Image(
              image: AssetImage('assets/ind_assets/drop_hold.png'),
              height: 100,
              width: 100,
            )
          ],
        ));
  }
}
