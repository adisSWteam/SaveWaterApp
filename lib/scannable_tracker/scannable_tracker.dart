import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart' as google_ml_kit;
import 'package:image_picker/image_picker.dart';
// import 'dart:io';

import 'package:save_water/theme/theme.dart';
import 'package:save_water/scannable_tracker/result_page.dart';
import 'package:save_water/widgets/normal_elevated_button.dart';
// import 'package:save_water/widgets/weird_button.dart';

class ScannableTracker extends StatefulWidget {
  const ScannableTracker({Key? key}) : super(key: key);

  @override
  State<ScannableTracker> createState() => _ScannableTrackerState();
}

class _ScannableTrackerState extends State<ScannableTracker> {
  bool textScanning = false;
  XFile? imageFile;
  String scannedText = "";

  void button1OnPressed() {
    getImage(ImageSource.gallery);
  }

  void button2OnPressed() {
    getImage(ImageSource.camera);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Scannable Tracker',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
        ),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      body: Center(
          child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (textScanning) const CircularProgressIndicator(),
                  // if (!textScanning && imageFile == null)
                  //   Container(
                  //     width: 300,
                  //     height: 300,
                  //     color: Colors.white,
                  //   ),
                  // if (imageFile != null) Image.file(File(imageFile!.path)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Choose from gallery button

                      InkWell(
                        onTap: () {
                          getImage(ImageSource.gallery);
                        },
                        child: Ink.image(
                            image: AssetImage(
                              "assets/ind_assets/upload_from_gallery.png",
                            ),
                            height: 260,
                            width: 175,
                            fit: BoxFit.cover),
                      ),
                      // Choose from camera button
                      InkWell(
                        onTap: () {
                          getImage(ImageSource.camera);
                        },
                        child: Ink.image(
                            image: AssetImage(
                              "assets/ind_assets/take_photo.png",
                            ),
                            height: 260,
                            width: 175,
                            fit: BoxFit.cover),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 160,
                  ),
                  // Container(
                  //   // child: Text(
                  //   //   scannedText,
                  //   //   style: TextStyle(fontSize: 20),
                  //   child: Card(
                  //     elevation: 15,
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(15.0),
                  //     ),
                  //     child: Column(
                  //       crossAxisAlignment: CrossAxisAlignment.stretch,
                  //       children: [
                  //         Padding(
                  //           padding: const EdgeInsets.all(12),
                  //           child: Text(
                  //             "Total units:",
                  //             style: TextStyle(
                  //               fontWeight: FontWeight.bold,
                  //               fontSize: 22,
                  //               color: primaryColor,
                  //             ),
                  //           ),
                  //         ),
                  //         Padding(
                  //           padding: const EdgeInsets.all(12),
                  //           child: Text(scannedText,
                  //               style: TextStyle(fontWeight: FontWeight.w500)),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ))),
    );
  }

  void processImage() {
    scannedText.runes.forEach((word) {
      print(word);
      // if (word == "in"||word == "in"||word == "in"){

      // }
    });
  }

  void getImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage != null) {
        textScanning = true;
        imageFile = pickedImage;
        getRecognisedText(pickedImage);
      }
    } catch (e) {
      textScanning = false;
      imageFile = null;
      scannedText = "Error occured while scanning";
    }
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ScanTrackerResultPage(
                scannedText: scannedText,
              )),
    );
  }

  void getRecognisedText(XFile image) async {
    final inputImage = google_ml_kit.InputImage.fromFilePath(image.path);
    final textDetector = google_ml_kit.GoogleMlKit.vision.textRecognizer();
    google_ml_kit.RecognizedText recognisedText =
        await textDetector.processImage(inputImage);
    await textDetector.close();
    scannedText = "";
    // int cnt = 0;
    // double high1 = 0, high2 = 0;

    for (google_ml_kit.TextBlock block in recognisedText.blocks) {
      for (google_ml_kit.TextLine line in block.lines) {
        String text = line.text.trim();
        List<String> textList = text.split(" ");

        if (textList[0] == "AED") {
          double amt = double.parse(textList[1]);
          scannedText = amt.toString() + " Dhs";
        }

        /*
        //     // Removes all commas so that it doesn't mess up calculation
        //     String text = line.text.trim().replaceAll(",", "");
        //     print(text + "\n");

        //     // Checks if text is not spotted
        //     if (cnt == 0) {
        //       // Checks if the text is in the hint texts
        //       if (text == "Total (before VAT)" ||
        //           text == "TOTAL INCL" ||
        //           text == "VAT at 5%") {
        //         cnt++;
        //         print(cnt);
        //       }

        //       // Checks if it's a double + contains "." + if val less than 1000
        //     } else if (double.tryParse(text) != null &&
        //         text.contains(".") &&
        //         double.parse(text) < 1000) {
        //       cnt++;
        //       print(cnt);
        //       if (cnt == 4) {
        //         scannedText = text + "units!";
        //       }
        //     }

        /* Simple Logic
        // if (double.tryParse(text) != null && text.contains(".")) {
        //   if (double.parse(text) > high1) {
        //     high2 = high1;
        //     high1 = double.parse(text);
        //   }
        // }
        */
        */
      }
    }
    if (scannedText == "") {
      scannedText = "Unable to recognize text";
    }
    // scannedText = (high1 - high2).toString() + "units!";

    textScanning = false;
    setState(() {});
    @override
    void initState() {
      super.initState();
    }
  }
}
