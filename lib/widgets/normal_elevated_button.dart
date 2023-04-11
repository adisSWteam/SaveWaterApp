import 'package:flutter/material.dart';

class NormalElevatedButton extends StatelessWidget {
  const NormalElevatedButton(
      {Key? key, required this.onPressed, required this.text})
      : super(key: key);

  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        padding: const EdgeInsets.only(top: 10),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.grey, backgroundColor: Colors.white,
            shadowColor: Colors.grey[400],
            elevation: 10,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
          ),
          onPressed: onPressed,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.image,
                  size: 30,
                ),
                Text(
                  this.text,
                  style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                )
              ],
            ),
          ),
        ));
  }
}
