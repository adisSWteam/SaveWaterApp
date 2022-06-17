import 'package:flutter/material.dart';

import 'manual_tracker_question.dart';

const Color primaryColor = Color.fromARGB(255, 75, 57, 239);

class SingleChoiceRadioForm extends StatefulWidget {
  const SingleChoiceRadioForm({
    Key? key,
    required this.form,
  }) : super(key: key);

  final ManualTrackerQuestion form;

  @override
  State<SingleChoiceRadioForm> createState() => _SingleChoiceRadioFormState();
}

class _SingleChoiceRadioFormState extends State<SingleChoiceRadioForm> {
  int selectedVal = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.,
      children: <Widget>[
        // Question
        Text(
          widget.form.question,
          style: const TextStyle(
            fontSize: 20,
            color: primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),

        // Option 1
        RadioListTile(
          value: 1,
          groupValue: selectedVal,
          title: Text(widget.form.options[0]),
          onChanged: (int? val) {
            setState(
              () {
                selectedVal = 1;
              },
            );
          },
        ),

        // Option 2
        RadioListTile(
          value: 2,
          groupValue: selectedVal,
          title: Text(widget.form.options[1]),
          onChanged: (val) {
            setState(
              () {
                selectedVal = 2;
              },
            );
          },
        ),

        // Option 3
        RadioListTile(
          value: 3,
          groupValue: selectedVal,
          title: Text(
            widget.form.options[2],
          ),
          onChanged: (val) {
            setState(
              () {
                selectedVal = 3;
              },
            );
          },
        ),

        // Option 4
        RadioListTile(
            value: 4,
            groupValue: selectedVal,
            title: Text(
              widget.form.options[3],
            ),
            onChanged: (val) {
              setState(() {
                selectedVal = 4;
              });
            }),
      ],
    );
  }
}
