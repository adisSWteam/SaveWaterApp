import 'package:flutter/material.dart';
import 'package:save_water/theme/theme.dart';
import 'package:save_water/widgets/image_card.dart';
import 'package:connectivity/connectivity.dart';

class WaterMenu extends StatefulWidget {
  const WaterMenu({Key? key}) : super(key: key);

  @override
  State<WaterMenu> createState() => _WaterMenuState();
}

class _WaterMenuState extends State<WaterMenu> {
  bool _isConnected = true;

  @override
  void initState() {
    super.initState();
    _checkConnectivity();
  }

  void _checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        _isConnected = false;
      });
    }
  }

  void _showNoInternetPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('No Internet Connection'),
        content: const Text(
          'Your data from Manual & Scan Tracker will not be recorded in the database. You won\'t be able to access History, Gallery & Local/International Events pages.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Water Consumption Tracker',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: () {
              Navigator.pushNamed(context, '/home/thanks');
            },
          ),
        ],
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/home/water/manual');
                },
                child: const ImageCard(
                  title: 'Manual Tracker',
                  description:
                      'Track your water consumption by filling in the questionnaire and compare it with your local usage. Save more water and money!',
                  image: AssetImage('assets/images/tracker.png'),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/home/water/scan');
                },
                child: const ImageCard(
                  title: 'Scan Tracker',
                  description:
                      'Track your water usage by scanning your water bill and compare it with your local usage. Save more water and money!',
                  image: AssetImage('assets/images/scan.png'),
                ),
              ),
            ),
            Expanded(
              child: IgnorePointer(
                ignoring: !_isConnected,
                child: InkWell(
                  onTap: () {
                    if (_isConnected) {
                      Navigator.pushNamed(context, '/home/water/history');
                    } else {
                      _showNoInternetPopup(context);
                    }
                  },
                  child: const ImageCard(
                    title: 'History',
                    description:
                        'See and analyze how much water you have used.',
                    image: AssetImage('assets/images/history.png'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
