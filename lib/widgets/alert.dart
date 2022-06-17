import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget alert({info, details, cont}){
  return CupertinoAlertDialog(
    title: Text('Error'),
    content: Text('Please choose an option'),
    actions: [
      CupertinoDialogAction(child: Text('Ok'), onPressed: (){
        Navigator.of(cont).pop();
      },)
    ],
  );
}