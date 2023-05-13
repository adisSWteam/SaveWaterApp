import 'package:flutter/material.dart';

Widget alert(
    {required String title,
    required String content,
    required BuildContext context}) {
  return AlertDialog(
    title: Text(title),
    content: Text(content),
    actions: [
      TextButton(
        child: const Text('Ok'),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    ],
  );
}
