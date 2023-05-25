// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:save_water/theme/theme.dart';

class LocalEvents extends StatefulWidget {
  const LocalEvents({Key? key}) : super(key: key);

  @override
  State<LocalEvents> createState() => _LocalEventsState();
}

class _LocalEventsState extends State<LocalEvents> {
  List events = [];

  void getData() async {
    Response response = await get(Uri.parse(dotenv.env['EVENTS_URL']!));
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
            'Local Events',
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
