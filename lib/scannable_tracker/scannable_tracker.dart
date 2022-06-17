import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:save_water/theme/theme.dart';
import 'package:save_water/widgets/normal_elevated_button.dart';

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
          child: SingleChildScrollView(
        child: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (textScanning) const CircularProgressIndicator(),
                if (!textScanning && imageFile == null)
                  Container(
                    width: 300,
                    height: 300,
                    color: Colors.white,
                  ),
                if (imageFile != null) Image.file(File(imageFile!.path)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    NormalElevatedButton(
                      onPressed: () {
                        getImage(ImageSource.gallery);
                      },
                      text: "Choose from Gallery",
                    ),
                    NormalElevatedButton(
                      onPressed: () {
                        getImage(ImageSource.camera);
                      },
                      text: "Choose from Camera",
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  // child: Text(
                  //   scannedText,
                  //   style: TextStyle(fontSize: 20),
                  child: Card(
                    elevation: 15,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text(
                            "Scanned Text: ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text(scannedText,
                              style: TextStyle(fontWeight: FontWeight.w500)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
      )),
    );
  }

  void getImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage != null) {
        textScanning = true;
        imageFile = pickedImage;
        setState(() {});
        getRecognisedText(pickedImage);
      }
    } catch (e) {
      textScanning = false;
      imageFile = null;
      scannedText = "Error occured while scanning :(";
      setState(() {});
    }
  }

  void getRecognisedText(XFile image) async {
    final inputImage = InputImage.fromFilePath(image.path);
    final textDetector = GoogleMlKit.vision.textRecognizer();
    RecognizedText recognisedText = await textDetector.processImage(inputImage);
    await textDetector.close();
    scannedText = "";
    for (TextBlock block in recognisedText.blocks) {
      for (TextLine line in block.lines) {
        scannedText = scannedText + line.text + "\n";
      }
    }
    textScanning = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }
}
