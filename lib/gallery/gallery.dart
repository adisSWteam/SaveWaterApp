import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

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
  }

  Widget imageCard(_link) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ShowImg(
                      title_: _link['title'],
                      link2_: _link['link'],
                    )));
      },
      child: Card(
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Image.network(_link['link']),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) => getData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Images'),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: links.map((e) => imageCard(e)).toList(),
      ),
    );
  }
}

class ShowImg extends StatelessWidget {
  final String title_;
  final String link2_;

  ShowImg({required this.title_, required this.link2_});

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
          child: Image.network(link2_),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
