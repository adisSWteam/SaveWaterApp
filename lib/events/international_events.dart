// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

import 'package:save_water/theme/theme.dart';

class InterEvents extends StatefulWidget {
  const InterEvents({Key? key}) : super(key: key);

  @override
  State<InterEvents> createState() => _InterEventsState();
}

class _InterEventsState extends State<InterEvents> {
  List events = [];

  void getData() async {
    Response response = await get(Uri.parse(
        'https://api.jsonbin.io/v3/b/64561adcb89b1e2299981254?meta=false'));
    Map info = jsonDecode(response.body);
    List inter = info['Inter'];
    setState(() {
      events = inter;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => getData());
  }

  Widget display(Map event) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Image.network(
            event['image_url'],
            fit: BoxFit.cover,
            height: 200.0,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 0, 3),
            child: Text(
              "${event['event_name']}:",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 0, 3),
            child: Text('${event['description']}'),
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
            'International Events',
          ),
          backgroundColor: primaryColor,
          centerTitle: true,
        ),
        body: ListView.builder(
          itemCount: events.length,
          itemBuilder: (context, index) {
            return display(events[index]);
          },
        ));
  }
}
