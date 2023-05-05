import 'package:flutter/cupertino.dart';

Widget alert({info, details, cont}) {
  return CupertinoAlertDialog(
    title: const Text('Error'),
    content: const Text('Please choose an option'),
    actions: [
      CupertinoDialogAction(
        child: const Text('Ok'),
        onPressed: () {
          Navigator.of(cont).pop();
        },
      )
    ],
  );
}
