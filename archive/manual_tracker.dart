import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'single_choice_radio.dart';
import 'manual_tracker_question.dart';

const Color primaryColor = Color.fromARGB(255, 75, 57, 239);

class ManualTracker extends StatefulWidget {
  final User user;
  const ManualTracker({Key? key, required this.user}) : super(key: key);

  @override
  State<ManualTracker> createState() => _ManualTrackerState();
}

class _ManualTrackerState extends State<ManualTracker> {
  // List of questions
  List<ManualTrackerQuestion> questions = [
    ManualTrackerQuestion(
      question: 'How long is the average shower in your house hold',
      options: [
        'Under 5 minutes',
        '5-10 minutes',
        '11-15 minutes',
        'Over 15 minutes'
      ],
    ),
    ManualTrackerQuestion(
      question: 'Do you that baths? If so, how long',
      options: ['per day', 'per week', 'per month', 'per year'],
    ),
    ManualTrackerQuestion(
      question: 'How many baths do you take per day?',
      options: ['once', 'twice', 'thrice', '4 times'],
    ),
    ManualTrackerQuestion(
      question: 'How long do you leave your bathroom faucets running each day',
      options: [
        'Under 4 minutes',
        '4-10 minutes',
        '11-30 minutes',
        'Over 30 minutes'
      ],
    ),
  ];

  // Generating questions with single radio choice options
  List<Step> stepList() => questions
      .map((e) => Step(
            title: Text("Question" + (questions.indexOf(e) + 1).toString()),
            content: SingleChoiceRadioForm(form: e),
          ))
      .toList();

  int _activeStepIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: primaryColor,
          title: const Text(
            "Manual Tracker",
            style: TextStyle(
              color: Colors.white,
            ),
          )),
      body: SingleChildScrollView(
        child: Stepper(
            physics:
                const ClampingScrollPhysics(), // Allows scrolling in Stepper widget
            type: StepperType.vertical,
            currentStep: _activeStepIndex,
            steps: stepList(),
            onStepContinue: () {
              // Checking whether active step is not the last step
              if (_activeStepIndex < (stepList().length - 1)) {
                setState(() {
                  _activeStepIndex += 1;
                });
              } else {
                // Add code to be executed when Submitted button is pressed
              }
            },
            onStepCancel: () {
              // Checking if the active step is the first step
              if (_activeStepIndex == 0) {
                return;
              }
              setState(() {
                _activeStepIndex -= 1;
              });
            },
            onStepTapped: (int index) {
              setState(() {
                _activeStepIndex = index;
              });
            },
            controlsBuilder: (context, controls) {
              // Asserting if active step is the last step
              final isLastStep = _activeStepIndex == stepList().length - 1;
              return Row(
                children: [
                  if (_activeStepIndex > 0)
                    Expanded(
                      child: ElevatedButton(
                        onPressed: controls.onStepCancel,
                        child: const Text('Back'),
                      ),
                    ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: controls.onStepContinue,
                      child: (isLastStep) // Checking if it is the last step
                          ? const Text('Submit')
                          : const Text('Next'),
                    ),
                  )
                ],
              );
            }),
      ),
    );
  }
}
