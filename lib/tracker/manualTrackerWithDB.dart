import 'package:flutter/material.dart';
import 'package:save_water/tracker/questionsV2.dart';
import 'package:save_water/widgets/alert.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class manualRework extends StatefulWidget {
  const manualRework({Key? key}) : super(key: key);

  @override
  State<manualRework> createState() => _manualReworkState();
}

class _manualReworkState extends State<manualRework> {

  final uid = FirebaseAuth.instance.currentUser!.uid;

  void dataBaseConnect() async{
    mongo.Db db = await mongo.Db.create('mongodb+srv://saveWaterDB:asdc12@cluster0.oz1qubi.mongodb.net/test?retryWrites=true&w=majority');
    await db.open();
    final water = db.collection('waterData');
    //print(await water.find({'name': 'Ballz'}).toList());
    List find = await water.find({'name': 'Austin'}).toList();
    if(find.length == 0){
      print("working");
    }
    List us = await water.find({'uid': uid}).toList();
    print(us[0]['result']);
    print("Done");
    print(uid);
  }

  void dataBaseAdd(double result) async{
    mongo.Db db = await mongo.Db.create('mongodb+srv://saveWaterDB:asdc12@cluster0.oz1qubi.mongodb.net/test?retryWrites=true&w=majority');
    await db.open();
    final water = db.collection('waterData');
    final find = await water.find({"uid" : uid}).toList();
    DateFormat dateFormat = DateFormat("dd-MM-yyyy");
    String date = dateFormat.format(DateTime.now());
    if(find.length == 0){
      await water.insertOne({'uid': uid, 'result': [[(result * 3.785).round(), date]]});
    }else{
      //List us = await water.find({'uid': uid}).toList();
      List waterUseList = find[0]['result'];
      List newAdd = [];
      bool dateEx = false;

      for(int j = 0; j<waterUseList.length; j++){
        if(waterUseList[j][1] == date){
          dateEx = true;
        }
      }
      if(dateEx == false){
        waterUseList.add([(result * 3.785).round(), date]);
        await water.updateOne(mongo.where.eq('uid', uid), mongo.modify.set('result', waterUseList));
      }else{
        for(int i=0; i<waterUseList.length; i++){
          if(waterUseList[i][1] == date){
            newAdd.add([(result * 3.785).round(), date]);
          }else{
            newAdd.add(waterUseList[i]);
          }
        }
        await water.updateOne(mongo.where.eq('uid', uid), mongo.modify.set('result', newAdd));
      }

    }
    print("done");
  }

  @override
  void initState() {
    super.initState();
    //dataBaseConnect();
  }

  List<Question> questions = [
    Question(
        question: 'How long is the average shower in your house hold?',
        options: [
          'Under 5 minutes',
          '5-10 minutes',
          '11-15 minutes',
          'Over 15 minutes'
        ],
        values: [4, 8, 13, 15],
        cals: 5.0,
        imgs: ['assets/ind_assets/time_icons1.png', 'assets/ind_assets/time_icons2.png', 'assets/ind_assets/time_icons3.png', 'assets/ind_assets/time_icons4.png'],
        topimg: 'assets/ind_assets/shower.png'
    ),
    Question(
        question: 'How often do you shower?',
        options: ['per day', 'per week', 'per month', 'per year'],
        values: [1.0, 0.14, 0.033, 0.003],
        cals: 1.0,
        imgs: ['assets/ind_assets/days_tracker1.png', 'assets/ind_assets/days_tracker2.png', 'assets/ind_assets/days_tracker3.png', 'assets/ind_assets/days_tracker4.png'],
        topimg: 'assets/ind_assets/shower.png'
    ),
    Question(
        question: 'How many times in a day, do you shower?',
        options: ['once', 'twice', 'thrice', '4 times'],
        values: [1, 2, 3, 4],
        cals: 35.0,
        imgs: ['assets/ind_assets/repeat_symbols1.png', 'assets/ind_assets/repeat_symbols2.png', 'assets/ind_assets/repeat_symbols3.png', 'assets/ind_assets/repeat_symbols4.png'],
        topimg: 'assets/ind_assets/shower_2.png'
    ),
    Question(
        question:
        'How long do you leave your bathroom faucets running each day?',
        options: [
          'Under 4 minutes',
          '4-10 minutes',
          '11-30 minutes',
          'Over 30 minutes'
        ],
        values: [4, 8, 20, 30],
        cals: 5.0,
        imgs: ['assets/ind_assets/time_icons1.png', 'assets/ind_assets/time_icons2.png', 'assets/ind_assets/time_icons3.png', 'assets/ind_assets/time_icons4.png'],
        topimg: 'assets/ind_assets/faucet .png'
    ),
    Question(
        question: 'How long do you leave the kitchen faucet running each day?',
        options: [
          'Under 5 minutes',
          '5-20 minutes',
          '21-45 minutes',
          'Over 45 minutes'
        ],
        values: [4, 13, 33, 45],
        cals: 5.0,
        imgs: ['assets/ind_assets/time_icons1.png', 'assets/ind_assets/time_icons2.png', 'assets/ind_assets/time_icons3.png', 'assets/ind_assets/time_icons4.png'],
        topimg: 'assets/ind_assets/faucet .png'
    ),
    Question(
        question: 'How often do you wash your dishes?',
        options: ['per day', 'per week', 'per month', 'per year'],
        values: [1.0, 0.14, 0.033, 0.003],
        cals: 1.0,
        imgs: ['assets/ind_assets/days_tracker1.png', 'assets/ind_assets/days_tracker2.png', 'assets/ind_assets/days_tracker3.png', 'assets/ind_assets/days_tracker4.png'],
        topimg: 'assets/ind_assets/dish_wash.png'
    ),
    Question(
        question: 'How many times do you wash you dishes?',
        options: ['once', 'twice', 'thrice', '4 times'],
        values: [1, 2, 3, 4],
        cals: 15.0,
        imgs: ['assets/ind_assets/repeat_symbols1.png', 'assets/ind_assets/repeat_symbols2.png', 'assets/ind_assets/repeat_symbols3.png', 'assets/ind_assets/repeat_symbols4.png'],
        topimg: 'assets/ind_assets/dish_wash.png'
    )
  ];

  int indexs = 0;

  List<Color> colors = [Colors.white, Colors.white, Colors.white, Colors.white];
  Color backCol(ind) {
    if (ind == 0) {
      return Colors.white;
    } else {
      return Colors.blue;
    }
  }

  double result = 0.0;
  double timeVal = 0;

  List prResults = [0.0];
  double prChosen = 0.0;
  int opChosen = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Water Tracker'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Image(
                  image: AssetImage(questions[indexs].topimg),
                  height: 180,
                  width: 180,
                  fit: BoxFit.fill
              )
            ],
          ),
          Center(
            child: Container(
              width: 250,
              height: 100,
              child: Text(
                questions[indexs].question,
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Capriola',
                ),
                textAlign: TextAlign.center ,
              ),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(questions[indexs].options.length, (index){
                return InkWell(
                  onTap: (){
                    colors[index] = Colors.lightBlueAccent;
                    setState(() {
                      for(int i = 0; i<4; i++){
                        opChosen = index;
                        if(i!=index){
                          colors[i] = Colors.white;
                        }
                      }
                    });
                  },
                  child: Container(
                    width: 80,
                    height: 150,
                    child: Card(
                      color: colors[index],
                      child: Column(
                        children: [
                          Padding(
                            child: Image(image: AssetImage(questions[indexs].imgs[index])),
                            padding: EdgeInsets.all(10),
                          ),
                          Padding(
                            child: Text(
                              questions[indexs].options[index],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'OpenSans',
                              ),
                            ),
                            padding: EdgeInsets.all(10),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          //This is the forward and back button
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  if (indexs == 0) {
                    null;
                  } else {
                    setState(() {
                      if (indexs == 2 || indexs == 5) {
                        prChosen = result;
                        result = prResults[prResults.indexOf(result) - 1];
                        prResults.removeAt(prResults.indexOf(prChosen));
                        indexs -= 2;
                      } else {
                        prChosen = result;
                        result = prResults[prResults.indexOf(result) - 1];
                        prResults.removeAt(prResults.indexOf(prChosen));
                        indexs--;
                      }
                    });
                    for (int i = 0; i < colors.length; i++) {
                      colors[i] = Colors.white;
                    }
                  }
                  print(result);
                  print(prResults);
                },
                style: TextButton.styleFrom(backgroundColor: backCol(indexs)),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                  child: Text(
                    'Back',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(width: 10),
              TextButton(
                onPressed: () {
                  setState(() {
                    if (opChosen < 4) {
                      if (indexs <= questions.length - 1) {
                        if (indexs == 1 || indexs == 5) {
                          setState(() {
                            timeVal = questions[indexs].values[opChosen];
                          });
                        } else if (indexs == 2 || indexs == 6) {
                          result += questions[indexs].values[opChosen] * questions[indexs].cals * timeVal;
                          prResults.add(result);
                        } else {
                          result += questions[indexs].values[opChosen] * questions[indexs].cals;
                          prResults.add(result);
                        }
                      }

                      colors[opChosen] = Colors.white;

                      if (indexs != questions.length - 1) {
                        print(result);
                        print(prResults);
                        indexs++;
                      } else {
                        print(prResults);
                        dataBaseAdd(result);
                        print(result);
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>ResultPage(result_: result)), (route) => route.isFirst);
                      }
                      opChosen = 4;
                    } else {
                      showDialog(
                          context: context,
                          builder: (context) => alert(
                              info: 'Error',
                              details: 'Choose an Option',
                              cont: context));
                    }
                  });
                },
                style: TextButton.styleFrom(backgroundColor: Colors.blue),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                  child: Text(
                    'Next',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Image(
                image: AssetImage('assets/ind_assets/water.png'),
                fit: BoxFit.fill,
              ),
            ),
          )
        ],
      ),
    );
  }
}


class ResultPage extends StatelessWidget {
  final double result_;

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
                        '${(result_ * 3.785).round()} Liters per day',
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
                        '${result_.round()} Gallons per day',
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
