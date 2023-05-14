// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart' as google_ml_kit;
import 'package:image_picker/image_picker.dart';
import 'package:save_water/theme/theme.dart';
import 'package:save_water/scannable_tracker/result_page.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:save_water/scannable_tracker/month_history.dart';

class ScannableTracker extends StatefulWidget {
  const ScannableTracker({Key? key}) : super(key: key);

  @override
  State<ScannableTracker> createState() => _ScannableTrackerState();
}

class _ScannableTrackerState extends State<ScannableTracker> {
  bool textScanning = false;
  XFile? imageFile;
  String scannedText = "";
  final uid = FirebaseAuth.instance.currentUser!.uid;

  void button1OnPressed() {
    getImage(ImageSource.gallery);
  }

  void button2OnPressed() {
    getImage(ImageSource.camera);
  }

  void button3OnPressed() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const MonthHistory()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Scannable Tracker',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
        ),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (textScanning) const CircularProgressIndicator(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    getImage(ImageSource.gallery);
                  },
                  child: Ink.image(
                    image: const AssetImage(
                      "assets/ind_assets/upload_from_gallery.png",
                    ),
                    height: 260,
                    width: 175,
                    fit: BoxFit.cover,
                  ),
                ),
                InkWell(
                  onTap: () {
                    getImage(ImageSource.camera);
                  },
                  child: Ink.image(
                    image: const AssetImage(
                      "assets/ind_assets/take_photo.png",
                    ),
                    height: 260,
                    width: 175,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            InkWell(
              onTap: button3OnPressed,
              child: Ink.image(
                image: const AssetImage("assets/ind_assets/monthHistory.png"),
                height: 250,
                width: 250,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void processImage() {
    // ignore: unused_local_variable
    for (var word in scannedText.runes) {}
  }

  void getImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage != null) {
        textScanning = true;
        imageFile = pickedImage;
        getRecognisedText(pickedImage);
        await Future.delayed(const Duration(milliseconds: 900));
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

  void getLitres(double price) async {
    const double greenBandPricePerM3 = 7.84;
    const double redBandPricePerM3 = 10.41;
    final double greenBandPriceLimit;

    double units = 0;
    double temp;

    greenBandPriceLimit = (0.7 * greenBandPricePerM3) * 30;

    if (price > greenBandPriceLimit) {
      temp = price - greenBandPriceLimit;
      units += greenBandPriceLimit / greenBandPricePerM3;
      units += temp / redBandPricePerM3;
    } else {
      units += price / greenBandPricePerM3;
    }

    units *= 1000;
    dataBaseAdd(units);
    scannedText = units.round().toString();
  }

  void dataBaseAdd(double result) async {
    mongo.Db db = await mongo.Db.create(
        'mongodb+srv://savewater:savewater123@savewater.tfctjml.mongodb.net/waterData?retryWrites=true&w=majority');
    await db.open();
    final water = db.collection('waterData');
    final find = await water.find({"uid": uid}).toList();
    DateFormat dateFormat = DateFormat("dd-MM-yyyy, hh:mm a");
    String date = dateFormat.format(DateTime.now());
    if (find.isEmpty) {
      await water.insertOne({
        'uid': uid,
        'monthresult': [
          [(result).round(), date]
        ]
      });
    } else {
      List<dynamic>? waterUseList = find[0]['monthresult'];
      // ignore: prefer_conditional_assignment
      if (waterUseList == null) {
        waterUseList = [];
      }
      bool dateEx = false;
      for (int j = 0; j < waterUseList.length; j++) {
        if (waterUseList[j][1] == date) {
          dateEx = true;
        }
      }
      if (!dateEx) {
        //waterUseList.add([(result * 3.785).round(), date]);
        waterUseList.add([(result).round(), date]);
        await water.updateOne(mongo.where.eq('uid', uid),
            mongo.modify.set('monthresult', waterUseList));
      } else {
        for (int i = 0; i < waterUseList.length; i++) {
          if (waterUseList[i][1] == date) {
            waterUseList[i][0] += (result).round();
            //waterUseList[i][0] += (result * 3.785).round();
            await water.updateOne(mongo.where.eq('uid', uid),
                mongo.modify.set('monthresult', waterUseList));
            break;
          }
        }
      }
    }
  }

  void getRecognisedText(XFile image) async {
    final inputImage = google_ml_kit.InputImage.fromFilePath(image.path);
    final textDetector = google_ml_kit.GoogleMlKit.vision.textRecognizer();
    google_ml_kit.RecognizedText recognisedText =
        await textDetector.processImage(inputImage);
    await textDetector.close();
    scannedText = "";
    String reformatStr = "";

    for (google_ml_kit.TextBlock block in recognisedText.blocks) {
      for (google_ml_kit.TextLine line in block.lines) {
        String text = line.text.trim();
        List<String> textList = text.split(" ");

        if (textList[0] == "AED") {
          for (int i = 0; i < textList[1].length; i++) {
            if (textList[1][i] != ",") {
              reformatStr += textList[1][i];
            }
          }
          double money = double.parse(reformatStr);
          getLitres(money);
        }
      }
    }
    if (scannedText == "") {
      scannedText = "Unable to recognize text";
    }
    textScanning = false;
  }
}
