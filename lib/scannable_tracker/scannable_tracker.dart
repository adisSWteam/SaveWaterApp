import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart' as google_ml_kit;
import 'package:image_picker/image_picker.dart';
import 'package:save_water/theme/theme.dart';
import 'package:save_water/scannable_tracker/result_page.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

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
        ],
      ))),
    );
  }

  void processImage() {
    scannedText.runes.forEach((word) {
      print(word);
    });
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
    print("Here 1st");
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ScanTrackerResultPage(
                scannedText: scannedText,
              )),
    );
  }

  void getLitres(double price) async {
    final double greenBandPricePerM3 = 7.84;
    final double redBandPricePerM3 = 10.41;
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
    print(units);
    print(scannedText);
  }

  void dataBaseAdd(double result) async {
    mongo.Db db = await mongo.Db.create(
        'mongodb+srv://savewater:savewater123@savewater.tfctjml.mongodb.net/waterData?retryWrites=true&w=majority');
    await db.open();
    final water = db.collection('waterData');
    final find = await water.find({"uid": uid}).toList();
    DateFormat dateFormat = DateFormat("dd-MM-yyyy");
    String date = dateFormat.format(DateTime.now());
    if (find.length == 0) {
      await water.insertOne({
        'uid': uid,
        'result': [
          [(result).round(), date]
        ]
      });
    } else {
      //List us = await water.find({'uid': uid}).toList();
      List waterUseList = find[0]['result'];
      List newAdd = [];
      bool dateEx = false;

      for (int j = 0; j < waterUseList.length; j++) {
        if (waterUseList[j][1] == date) {
          dateEx = true;
        }
      }
      if (dateEx == false) {
        waterUseList.add([(result * 3.785).round(), date]);
        await water.updateOne(mongo.where.eq('uid', uid),
            mongo.modify.set('result', waterUseList));
      } else {
        for (int i = 0; i < waterUseList.length; i++) {
          if (waterUseList[i][1] == date) {
            newAdd.add([(result).round(), date]);
          } else {
            newAdd.add(waterUseList[i]);
          }
        }
        await water.updateOne(
            mongo.where.eq('uid', uid), mongo.modify.set('result', newAdd));
      }
    }
    print("done");
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
          print("Found");
          for (int i = 0; i < textList[1].length; i++) {
            if (textList[1][i] != ",") {
              reformatStr += textList[1][i];
            }
          }
          double money = double.parse(reformatStr);
          print(money);
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
