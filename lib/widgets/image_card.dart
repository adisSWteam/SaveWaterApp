import 'package:flutter/material.dart';
import 'package:save_water/theme/theme.dart';

class ImageCard extends StatelessWidget {
  const ImageCard(
      {Key? key,
      required this.image,
      required this.title,
      required this.description})
      : super(key: key);

  final AssetImage image;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 15,
      margin: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.white, width: 0),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),

          // Image
          child: Image(
            image: image,
            height: 120,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.fitWidth,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),

          // Title
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              color: primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Divider(indent: 10, endIndent: 10, height: 2),
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),

          // Description
          child: Text(
            description,
            style: const TextStyle(
                fontSize: 10,
                color: Colors.black54,
                fontWeight: FontWeight.w500),
          ),
        )
      ]),
    );
  }
}
