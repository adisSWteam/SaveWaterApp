// ignore_for_file: unnecessary_statements

import 'package:flutter/material.dart';
import 'package:save_water/tracker/questionsV2.dart';
import 'package:save_water/widgets/alert.dart';


// ignore: camel_case_types
class manualTracker extends StatefulWidget {
  const manualTracker({Key? key}) : super(key: key);

  @override
  State<manualTracker> createState() => _manualTrackerState();
}

// ignore: camel_case_types
class _manualTrackerState extends State<manualTracker> {
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
        cals: 5.0),
    Question(
        question: 'Do you that baths? If so, how long?',
        options: ['per day', 'per week', 'per month', 'per year'],
        values: [1.0, 0.14, 0.033, 0.003],
        cals: 1.0),
    Question(
        question: 'How many baths do you take per day?',
        options: ['once', 'twice', 'thrice', '4 times'],
        values: [1, 2, 3, 4],
        cals: 35.0),
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
        cals: 5.0),
    Question(
        question: 'How long do you leave the kitchen faucet running each day?',
        options: [
          'Under 5 minutes',
          '5-20 minutes',
          '21-45 minutes',
          'Over 45 minutes'
        ],
        values: [4, 13, 33, 45],
        cals: 5.0),
    Question(
        question: 'How often do you wash your dishes?',
        options: ['per day', 'per week', 'per month', 'per year'],
        values: [1.0, 0.14, 0.033, 0.003],
        cals: 1.0),
    Question(
        question: 'How many times do you wash you dishes?',
        options: ['once', 'twice', 'thrice', '4 times'],
        values: [1, 2, 3, 4],
        cals: 15.0)
  ];

  List<Color> colors = [
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
  ];
  Color backCol(ind) {
    if (ind == 0) {
      return Colors.white;
    } else {
      return Colors.blue;
    }
  }

  double result = 0.0;
  int indexs = 0;
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
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            questions[indexs].question,
            style: TextStyle(
              fontSize: 25,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: List.generate(questions[indexs].options.length, (index) {
              return InkWell(
                onTap: () {
                  setState(() {
                    opChosen = index;
                    colors[index] = Colors.green;
                    for (int i = 0; i < 4; i++) {
                      if (i != index) {
                        colors[i] = Colors.white;
                      }
                    }
                  });
                },
                child: Card(
                  color: colors[index],
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                      child: Center(
                          child: Text(questions[indexs].options[index]))),
                ),
              );
            }),
          ),
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
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>ResultPage(result_: result)), ModalRoute.withName('/home/water'));
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
        appBar: AppBar(
          title: Text('Tracker'),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
                child: Image.asset(
              'assets/images/result.png',
              height: 300,
              width: 300,
              fit: BoxFit.contain,
            )),
            Center(
              child: Column(
                children: <Widget>[
                  Text(
                    '${result_.toStringAsFixed(3)} Gallons Per Day',
                    style: TextStyle(fontSize: 30, color: Colors.blue),
                  ),
                  Text(
                    overunder(),
                    style: TextStyle(fontSize: 15),
                  )
                ]
              ),
            )
          ],
        ));
  }
}
