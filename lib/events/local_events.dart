// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

import 'package:save_water/theme/theme.dart';

class localEvents extends StatefulWidget {
  const localEvents({Key? key}) : super(key: key);

  @override
  State<localEvents> createState() => _localEventsState();
}

class _localEventsState extends State<localEvents> {
  List events = [];

  void getData() async {
    Response response = await get(Uri.parse(
        'https://api.jsonbin.io/v3/b/64561adcb89b1e2299981254?meta=false'));
    Map info = jsonDecode(response.body);
    List local = info['Local'];
    setState(() {
      events = local;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => getData());
  }

  Widget display(events) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 0, 3),
            child: Text(
              "${events['event_name']}:",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 0, 3),
            child: Text('${events['description']}'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Local Events',
          ),
          backgroundColor: primaryColor,
          centerTitle: true,
        ),
        body: Column(
          children: events.map((e) => display(e)).toList(),
        ));
  }
}
