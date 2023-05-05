import 'package:flutter/material.dart';
import 'package:save_water/theme/theme.dart';

class ScanTrackerResultPage extends StatelessWidget {
  final String scannedText;
  const ScanTrackerResultPage({Key? key, required this.scannedText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
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
              padding: const EdgeInsets.all(14),
              child: Column(
                children: [
                  const Text(
                    'Total litres of water',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.lightBlueAccent,
                        fontFamily: 'Proxima-Nova'),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'used this month is:',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.lightBlueAccent,
                        fontFamily: 'Proxima-Nova'),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "$scannedText litres",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 30,
                      color: Colors.lightBlueAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )),
            const Image(
              image: AssetImage('assets/ind_assets/drop_hold.png'),
              height: 100,
              width: 100,
            )
          ],
        ));
  }
}
