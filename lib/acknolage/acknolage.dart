// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:save_water/theme/theme.dart';

class thanks extends StatelessWidget {
  const thanks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Acknowledgment',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/ind_assets/waterbg.png'),
                fit: BoxFit.cover)),
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: Text(
                    "'Save Water App' developed as part of the 'Hold That Drop' initiative\n by Abu Dhabi Indian School Al-Muroor",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Proxima-Nova',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image.asset(
                    'assets/images/waterdrop.png',
                    height: 95,
                    width: 95,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                  child: Text(
                    "Under the vision and guidance of the Principal Mr. Neeraj Bhargava",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Proxima-Nova',
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                const CircleAvatar(
                  backgroundImage:
                      AssetImage('assets/ind_assets/principal.png'),
                  backgroundColor: Colors.transparent,
                  radius: 40,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                const Text(
                  "Developed by",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Proxima-Nova',
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.001,
                ),
                const Text(
                  "Bhautik Dhanpal Shetty, Sairama Nikhilesh,\nJohan Sebastian, Pedro Mark Fernandes,\nKeegan D'Silva, Spandan Bibek Chakrabarty,\nSahal Mohamed\n\nof the Abu Dhabi Indian School - Al Muroor ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11,
                    fontFamily: 'Proxima-Nova',
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.005,
                ),
                const SizedBox(height: 10),
                const Text(
                  "With support and guidance from",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Proxima-Nova',
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Text(
                      "Mrs. Hufrish Parekh",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Proxima-Nova',
                      ),
                    ),
                    CircleAvatar(
                      backgroundImage:
                          AssetImage('assets/ind_assets/huffrishmaam.png'),
                      backgroundColor: Colors.transparent,
                      radius: 40,
                    ),
                    CircleAvatar(
                      backgroundImage:
                          AssetImage('assets/ind_assets/aditimaam.png'),
                      backgroundColor: Colors.transparent,
                      radius: 40,
                    ),
                    Text(
                      "Dr. Aditi Hazra",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Proxima-Nova',
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Text(
                      "Mrs. Nisha Sameer",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Proxima-Nova',
                      ),
                    ),
                    CircleAvatar(
                      backgroundImage:
                          AssetImage('assets/ind_assets/nishamaam.png'),
                      backgroundColor: Colors.transparent,
                      radius: 40,
                    ),
                    CircleAvatar(
                      backgroundImage:
                          AssetImage('assets/ind_assets/palaniappansir.png'),
                      backgroundColor: Colors.transparent,
                      radius: 40,
                    ),
                    SizedBox(
                      width: 65,
                      child: Text(
                        "Mr. Palaniappan Muthu",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Proxima-Nova',
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
