import 'package:flutter/material.dart';
import 'package:save_water/theme/theme.dart';

class ScanTrackerResultPage extends StatelessWidget {
  final String scannedText;
  const ScanTrackerResultPage({Key? key, required this.scannedText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool overAverage = int.parse(scannedText) > 27000;
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
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 20),
              const SizedBox(height: 20),
              const Text(
                'Total litres of water used this month:',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.lightBlueAccent,
                    fontFamily: 'Proxima-Nova',
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                "$scannedText litres",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 48,
                  color: Colors.lightBlueAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),
              Image.asset(
                'assets/ind_assets/drop_hold.png',
                height: 30,
                width: 30,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 32),
              Text(
                overAverage
                    ? 'You are over the average'
                    : 'Good Job. Your water usage is controlled',
                style: const TextStyle(fontSize: 20.0),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 35),
              const Text(
                'Tips to Save Water:',
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.lightBlueAccent,
                    fontFamily: 'Proxima-Nova',
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const <Widget>[
                  SizedBox(height: 0.0),
                  SizedBox(height: 16.0),
                  Text(
                    '1. Fix leaky faucets and pipes.\n 2. Take shorter showers.\n 3. Use a broom instead of a hose to clean driveways and sidewalks.\n 4. Install a low-flow toilet.\n 5. Water your lawn only when it needs it.\n',
                    style: TextStyle(fontSize: 16.5),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
