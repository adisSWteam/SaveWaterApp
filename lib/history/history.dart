import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'package:firebase_auth/firebase_auth.dart';

class history extends StatefulWidget {
  const history({Key? key}) : super(key: key);

  @override
  State<history> createState() => _historyState();
}

class _historyState extends State<history> {

  final uid = FirebaseAuth.instance.currentUser!.uid;
  List results = [];

  void getData() async {
    mongo.Db db = await mongo.Db.create('mongodb+srv://saveWaterDB:asdc12@cluster0.9ebxgrp.mongodb.net/test?retryWrites=true&w=majority');
    await db.open();
    final water = db.collection('waterData');
    final find = await water.find({"uid" : uid}).toList();
    if(find.length != 0){
      setState(() {
        results = find[0]['result'];
      });
    }
    print("Done");
  }

  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) => getData());
  }

  Widget resultOut(res){
    return OverflowBox(
      maxWidth: double.infinity,
      child: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>ResultPage(result_: res[0])));
        },
        child: Card(
          elevation: 5,
          margin: const EdgeInsets.fromLTRB(16, 14, 16, 14),
          child: Padding(
          padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${(res[0]/3.785).round()}",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                  ),
                ),
                SizedBox(width: 5,),
                Text(
                  "GPD recorded on ${res[1]}",
                  style: TextStyle(
                    fontSize: 18
                  ),
                )
              ],
            ),
          ),
        )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'History',
        ),
        backgroundColor: Color(0xFF4B39EF),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: results.map((e) => resultOut(e)).toList(),
        ),
      ),
    );
  }
}


class ResultPage extends StatelessWidget {
  final int result_;

  ResultPage({required this.result_});

  String overunder(){
    if(result_ > 114){
      return "You are over the average";
    }else{
      return "Good Job. Your water usage is controlled";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Tracker'),
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
                )
            ),
            Center(
                child: Padding(
                  padding: EdgeInsets.all(14),
                  child: Column(
                    children: [
                      Text(
                        'Your approximate',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.lightBlueAccent,
                            fontFamily: 'Capriola'
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'water footprint is',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.lightBlueAccent,
                            fontFamily: 'Capriola'
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '${result_.round()} Liters per day',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.lightBlueAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'or',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Capriola',
                            color: Colors.lightBlueAccent
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '${(result_/3.785).round()} Gallons per day',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.lightBlueAccent,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                )
            ),
            Image(
              image: AssetImage('assets/ind_assets/drop_hold.png'),
              height: 100,
              width: 100,
            )
          ],
        ));
  }
}