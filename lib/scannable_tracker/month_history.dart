import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:save_water/theme/theme.dart';

class MonthHistory extends StatefulWidget {
  const MonthHistory({Key? key}) : super(key: key);

  @override
  State<MonthHistory> createState() => _MonthHistoryState();
}

class _MonthHistoryState extends State<MonthHistory> {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  List results = [];

  void getData() async {
    mongo.Db db = await mongo.Db.create(
        'mongodb+srv://savewater:savewater123@savewater.tfctjml.mongodb.net/waterData?retryWrites=true&w=majority');
    await db.open();
    final water = db.collection('waterData');
    final find = await water.find({"uid": uid}).toList();
    if (find.isNotEmpty) {
      setState(() {
        results = find[0]['monthresult'];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => getData());
  }

  Widget resultOut(res) {
    bool aboveAverage = res[0] > 27000;

    return Card(
      elevation: 5,
      margin: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ResultPage(result_: res[0]),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    aboveAverage ? Icons.arrow_upward : Icons.arrow_downward,
                    color: aboveAverage ? Colors.red : Colors.green,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "${(res[0] / 3.785).round()} Gallons recorded on ${res[1]}",
                    style: const TextStyle(fontSize: 10.5),
                  ),
                ],
              ),
              const Icon(Icons.arrow_forward_ios),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'History',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: primaryColor,
        centerTitle: true,
        leading: const Icon(Icons.history, color: Colors.white),
      ),
      body: results.isEmpty
          ? const Center(
              child: SpinKitWave(
                color: primaryColor,
                size: 25.0,
              ),
            )
          : ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, index) {
                return resultOut(results[index]);
              },
            ),
    );
  }
}

class ResultPage extends StatelessWidget {
  final int result_;

  const ResultPage({Key? key, required this.result_}) : super(key: key);

  String getGallons(int liters) {
    final gallons = liters / 3.785;
    return gallons.toStringAsFixed(2);
  }

  Widget getUsageInfo(int liters) {
    String gallons = getGallons(liters);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.opacity_rounded, color: primaryColor),
            const SizedBox(width: 10),
            Text(
              'Water Usage: $liters Litres ($gallons Gallons)',
              style:
                  const TextStyle(fontSize: 13.45, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 10),
            Image.asset(
              'assets/ind_assets/drop_hold.png',
              width: 20,
              height: 20,
            ),
          ],
        ),
        const SizedBox(height: 20),
        Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0, 2),
                  blurRadius: 6,
                ),
              ],
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Tips to Reduce Water Usage:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  '1. Fix leaking faucets and pipes\n'
                  '2. Use a low-flow showerhead\n'
                  '3. Don\'t leave the tap running while brushing your teeth\n'
                  '4. Collect and reuse rainwater\n'
                  '5. Install a dual-flush toilet\n',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Result',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
        backgroundColor: primaryColor,
        centerTitle: true,
        leading: const Icon(Icons.history, color: Colors.white),
      ),
      body: FutureBuilder(
        future: Future.delayed(const Duration(seconds: 2)),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: SpinKitWave(
                color: primaryColor,
                size: 25.0,
              ),
            );
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    '$result_ Litres',
                    style: const TextStyle(
                        fontSize: 48, fontWeight: FontWeight.bold),
                  ),
                ),
                getUsageInfo(result_),
              ],
            );
          }
        },
      ),
    );
  }
}
