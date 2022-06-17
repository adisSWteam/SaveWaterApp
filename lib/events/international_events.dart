import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

class interEvents extends StatefulWidget {
  const interEvents({Key? key}) : super(key: key);

  @override
  State<interEvents> createState() => _interEventsState();
}

class _interEventsState extends State<interEvents> {
  List events = [];

  void getData() async {
    Response response = await get(Uri.parse('https://api.npoint.io/f0be36c0998477543644'));
    Map info = jsonDecode(response.body);
    List inter = info['Inter'];
    setState(() {
      events = inter;
    });
  }


  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) => getData());
  }

  Widget display(events){
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 0, 3),
            child: Text(
              "${events['event name']}:",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 0, 3),
            child: Text(
                '${events['dis']}'
            ),
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'International Events',
          ),
          backgroundColor: Color(0xFF4B39EF),
          centerTitle: true,
        ),
        body: Column(
          children: events.map((e) => display(e)).toList(),
        )
    );
  }
}

