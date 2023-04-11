// ignore_for_file: unnecessary_statements

import 'package:flutter/material.dart';
import 'package:save_water/tracker/questionsV3.dart';

// ignore: camel_case_types
class manualRework extends StatefulWidget {
  const manualRework({Key? key}) : super(key: key);

  @override
  State<manualRework> createState() => _manualReworkState();
}

// ignore: camel_case_types
class _manualReworkState extends State<manualRework> {
  List<Question> questions = [
    Question(
      question: 'How many people are there in your household?',
      type: 'input',
      topimg: 'assets/ind_assets/housepeople.png'
    ),
    Question(
      question: 'How long is the average shower in your household?',
      type: 'mcq',
      options: [
        'Under 5 minutes',
        '5-10 minutes',
        '11-15 minutes',
        'Over 15 minutes'
      ],
      values: [4, 8, 13, 15],
      imgs: ['assets/ind_assets/time_icons1.png', 'assets/ind_assets/time_icons2.png', 'assets/ind_assets/time_icons3.png', 'assets/ind_assets/time_icons4.png'],
      topimg: 'assets/ind_assets/shower.png'
    ),
    Question(
      question: 'Do you have low flow Shower-heads?',
      type: 'mcq',
      options: ['Yes', 'No', 'Unsure'],
      values: [2.5, 5.0, 2.5],
      imgs: ['assets/ind_assets/tick.png', 'assets/ind_assets/cross.png', 'assets/ind_assets/unsure.png'],
      topimg: 'assets/ind_assets/shower.png'
    ),
    Question(
      question: 'How often do you take baths?',
      type: 'mcq',
      options: ['per day', 'per week', 'per month', 'per year'],
      values: [1.0, 0.14, 0.033, 0.003],
      imgs: ['assets/ind_assets/days_tracker1.png', 'assets/ind_assets/days_tracker2.png', 'assets/ind_assets/days_tracker3.png', 'assets/ind_assets/days_tracker4.png'],
      topimg: 'assets/ind_assets/bath tub.png'
    ),
    Question(
      question: 'How many times do you take a bath?',
      type: 'input',
      topimg: 'assets/ind_assets/bath tub.png'
    ),
    Question(
      question: 'How long do you leave your bathroom faucets running each day?',
      type: 'mcq',
      options: [
        'Under 4 minutes',
        '4-10 minutes',
        '11-30 minutes',
        'Over 30 minutes'
      ],
      values: [4, 8, 20, 30],
      imgs: ['assets/ind_assets/time_icons1.png', 'assets/ind_assets/time_icons2.png', 'assets/ind_assets/time_icons3.png', 'assets/ind_assets/time_icons4.png'],
      topimg: 'assets/ind_assets/faucet .png'
    ),
    Question(
      question: 'Does your bathroom sink have low flow faucets?',
      type: 'mcq',
      options: ['Yes', 'No', 'Unsure'],
      values: [1.5, 5.0, 1.5],
      imgs: ['assets/ind_assets/tick.png', 'assets/ind_assets/cross.png', 'assets/ind_assets/unsure.png'],
      topimg: 'assets/ind_assets/faucet .png'
    ),
    Question(
      question: 'Do you flush the toilet?',
      type: 'mcq',
      options: ['Always', 'Sometimes', 'Never'],
      values: [1.7, 3.4, 5.0],
      imgs: ['assets/ind_assets/tick.png', 'assets/ind_assets/unsure.png', 'assets/ind_assets/cross.png'],
      topimg: 'assets/ind_assets/toilet.png'
    ),
    Question(
      question: 'Do you have low flow toilets?',
      type: 'mcq',
      options: ['Yes', 'No', 'Unsure'],
      values: [1.5, 5.0, 1.5],
      imgs: ['assets/ind_assets/tick.png', 'assets/ind_assets/cross.png', 'assets/ind_assets/unsure.png'],
      topimg: 'assets/ind_assets/toilet.png'
    ),
    Question(
      question: 'How long do you leave your kitchen faucets running each day?',
      type: 'mcq',
      options: [
        'Under 5 minutes',
        '5-20 minutes',
        '21-45 minutes',
        'Over 45 minutes'
      ],
      values: [4, 13, 33, 45],
      imgs: ['assets/ind_assets/time_icons1.png', 'assets/ind_assets/time_icons2.png', 'assets/ind_assets/time_icons3.png', 'assets/ind_assets/time_icons4.png'],
      topimg: 'assets/ind_assets/faucet .png'
    ),
    Question(
      question: 'Does your kitchen sink have low flow faucets?',
      type: 'mcq',
      options: ['Yes', 'No', 'Some'],
      values: [1.5, 5.0, 1.5],
      imgs: ['assets/ind_assets/tick.png', 'assets/ind_assets/cross.png', 'assets/ind_assets/unsure.png'],
      topimg: 'assets/ind_assets/faucet .png'
    ),
    Question(
      question: 'How often do you wash your dishes?',
      type: 'mcq',
      options: ['per day', 'per week', 'per month', 'per year'],
      values: [1.0, 0.14, 0.033, 0.003],
      imgs: ['assets/ind_assets/days_tracker1.png', 'assets/ind_assets/days_tracker2.png', 'assets/ind_assets/days_tracker3.png', 'assets/ind_assets/days_tracker4.png'],
      topimg: 'assets/ind_assets/dish_wash.png'
    ),
    Question(
      question: 'What kind of dishwasher do you have?',
      type: 'mcq',
      options: ['Old School Dishwasher', 'Water-efficient dishwasher', 'Hand wash'],
      values: [15, 4.3, 27],
      imgs: ['assets/ind_assets/time_icons1.png', 'assets/ind_assets/time_icons2.png', 'assets/ind_assets/time_icons3.png'],
      topimg: 'assets/ind_assets/dish_wash.png'
    ),
    Question(
      question: 'How many times do you wash the dishes?',
      type: 'input',
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
  double holdVal = 0.0;
  int totalPeople = 0;

  List prResults = [0.0];
  double prChosen = 0.0;
  int opChosen = 4;

  String textFieldInput = '';

  Widget mcq(){
    return Row(
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
            width: 90,
            height: 150,
            child: Card(
              color: colors[index],
              child: Column(
                children: [
                  Padding(
                    child: Image(image: AssetImage(questions[indexs].imgs[index])),
                    padding: EdgeInsets.all(15),
                  ),
                  Padding(
                    child: Text(
                      questions[indexs].options[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                    padding: EdgeInsets.fromLTRB(9, 9, 9, 0),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
  Widget input(){
    return SizedBox(
      width: 100,
      height: 80,
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0)
          ),
          hintText: "Input here",
        ),
        onChanged: (val) => setState(() {
          textFieldInput = val;
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
          Center(
            child: (questions[indexs].type == 'mcq')? mcq(): input(),
          ),
          SizedBox(height: 10),
          //This is the forward and back button
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  if(indexs == 0){
                    null;
                  }else{
                    setState(() {
                      if(indexs == 3 || indexs == 5 || indexs == 7 || indexs == 9 || indexs == 11){
                        prChosen = result;
                        result = prResults[prResults.indexOf(prChosen) - 1];
                        prResults.removeAt(prResults.indexOf(prChosen));
                        print(prResults);
                        indexs-=2;
                      }else{
                        indexs--;
                      }
                    });
                  }
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
                    if(indexs == 0){
                      try{
                        totalPeople = int.parse(textFieldInput);
                        indexs++;
                      }catch(err){
                        null;
                      }
                    }else if(indexs == 1 || indexs == 3 || indexs == 5 || indexs == 7 || indexs == 9 || indexs == 11){
                      holdVal = questions[indexs].values[opChosen].toDouble();
                      indexs++;
                    }else if(indexs == 2 || indexs == 6 || indexs == 8 || indexs == 10){
                      result += holdVal * questions[indexs].values[opChosen];
                      prResults.add(result);
                      print(prResults);
                      indexs++;
                    }else if(indexs == 4){
                      try{
                        result += 35 * double.parse(textFieldInput) * holdVal;
                        prResults.add(result);
                        print(prResults);
                        indexs++;
                      }catch(err){
                        null;
                      }
                    }else if(indexs == 12){
                      holdVal = holdVal * questions[indexs].values[opChosen].toDouble();
                      indexs++;
                    }else if(indexs == 13){
                      result+= holdVal * double.parse(textFieldInput);
                      print(result);
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>ResultPage(result_: result, people: totalPeople,)), ModalRoute.withName('/home/water'));
                    }

                    try{
                      colors = [Colors.white, Colors.white, Colors.white, Colors.white];
                    }catch(err){
                      null;
                    }
                    opChosen = 4;
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
  final int people;

  ResultPage({required this.result_, required this.people});


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
                        '${((result_ * 3.785)*people).round()} Liters per day',
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
                        '${(result_ * people).round()} Gallons per day',
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
