// ignore_for_file: camel_case_types, file_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:save_water/theme/theme.dart';

class Gallery extends StatefulWidget {
  const Gallery({Key? key}) : super(key: key);

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  List links = [];

  void getData() async {
    Response response =
        await get(Uri.parse('https://api.npoint.io/fa4b067e2d359e33b379'));
    List linkI = jsonDecode(response.body);
    setState(() {
      links = linkI;
    });
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => mainShow(links: links)),
        (route) => route.isFirst);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => getData());
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: SpinKitRotatingCircle(
        color: Colors.lightBlueAccent,
        size: 50.0,
      ),
    ));
  }
}

class ShowImg extends StatelessWidget {
  final String title_;
  final String link2_;

  const ShowImg({Key? key, required this.title_, required this.link2_})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title_),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: Center(
        child: FittedBox(
          fit: BoxFit.fill,
          child: Image.network(link2_),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class mainShow extends StatefulWidget {
  List links;
  mainShow({Key? key, required this.links}) : super(key: key);

  @override
  State<mainShow> createState() => _mainShowState();
}

class _mainShowState extends State<mainShow> {
  Widget imageCard(link) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ShowImg(
                      title_: link['title'],
                      link2_: link['link'],
                    )));
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Image.network(link['link']),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Images'),
        centerTitle: true,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: widget.links.map((e) => imageCard(e)).toList(),
      ),
    );
  }
}
