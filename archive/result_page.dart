// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  double result_ = 0.0;

  ResultPage({required this.result_});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tracker',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
        ),
        backgroundColor: Color(0xFF4B39EF),
        centerTitle: true,
      ),
      body: Center(child: Text('$result_ Gpd')),
    );
  }
}
