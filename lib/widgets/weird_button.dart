import 'package:flutter/material.dart';
import 'package:save_water/theme/theme.dart';

class WeirdButton extends StatelessWidget {
  const WeirdButton({Key? key, required this.onPressed, required this.text})
      : super(key: key);

  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            // primary: Colors.white,
            // onPrimary: Colors.grey,
            // shadowColor: Colors.grey[400],
            shadowColor: Colors.lightBlueAccent,
            elevation: 10,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.0)),
          ),
          onPressed: onPressed,
          child: Container(
            color: Colors.blue[500],
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  "assets/ind_assets/manual_tracker_icon.png",
                  height: 100,
                  width: 100,
                  fit: BoxFit.contain,
                ),
                Text(
                  "Test Text",
                  // this.text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontFamily: 'Capriola'),
                )
              ],
            ),
          )),
    );
  }
}
