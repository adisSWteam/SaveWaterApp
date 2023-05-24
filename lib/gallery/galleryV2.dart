// ignore_for_file: camel_case_types, file_names, use_build_context_synchronously, prefer_const_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import 'package:save_water/theme/theme.dart';

class Gallery extends StatefulWidget {
  const Gallery({Key? key}) : super(key: key);

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  List links = [];

  void getData() async {
    Response response = await get(Uri.parse(
        'https://api.jsonbin.io/v3/b/645619dd8e4aa6225e976721?meta=false'));
    List linkI = jsonDecode(response.body);
    setState(() {
      links = linkI;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => getData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Images'),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: links.isEmpty
          ? const Center(
              child: SpinKitWave(
                color: Colors.lightBlueAccent,
                size: 25.0,
              ),
            )
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: links.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainShow(
                          links: links,
                          initialIndex: index,
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(
                      links[index]['link'],
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class MainShow extends StatefulWidget {
  final List links;
  final int initialIndex;
  const MainShow({Key? key, required this.links, required this.initialIndex})
      : super(key: key);

  @override
  _MainShowState createState() => _MainShowState();
}

class _MainShowState extends State<MainShow> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
  }

  void showImg(String title, String link) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title),
              SizedBox(height: 5.0),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Images'),
        centerTitle: true,
      ),
      body: GestureDetector(
        child: PhotoViewGallery.builder(
          itemCount: widget.links.length,
          builder: (BuildContext context, int index) {
            return PhotoViewGalleryPageOptions(
              imageProvider: NetworkImage(widget.links[index]['link']),
              initialScale: PhotoViewComputedScale.contained * 1,
              minScale: PhotoViewComputedScale.contained * 1,
              maxScale: PhotoViewComputedScale.contained * 5,
              heroAttributes:
                  PhotoViewHeroAttributes(tag: widget.links[index]['link']),
              onTapUp: (context, details, value) {
                showImg(
                    widget.links[index]['title'], widget.links[index]['link']);
              },
            );
          },
          onPageChanged: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          pageController: PageController(initialPage: currentIndex),
        ),
      ),
    );
  }
}
