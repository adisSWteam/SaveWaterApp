import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class thanks extends StatelessWidget {
  const thanks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Acknowledgment',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 18
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF4B39EF),
        elevation: 0,
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/ind_assets/background.png'),
                fit: BoxFit.cover)),
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          //debug stuff delete after use
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                Padding(
                  padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: Text(
                    "'Save Water App' developed as part of the 'Hold That Drop' initiative\n by Abu Dhabi Indian School Al-Muroor",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Capriola',
                    ),
                  ),
                ),
                Padding(
                  child: Image.asset('assets/images/waterdrop.png', height: 95, width: 95,),
                  padding: EdgeInsets.all(10),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                Padding(
                  padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                  child: Text(
                    "Under the vision and guidance of the Principal Mr. Neeraj Bhargava",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Capriola',
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                CircleAvatar(
                  backgroundImage: AssetImage('assets/ind_assets/principal.png'),
                  backgroundColor: Colors.transparent,
                  radius: 40,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                Text(
                  "Developed by",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Capriola',
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.001,),
                Text(
                  "Utkarsh Gupta\nAbdulla Abdul Jaleel\nAustin Philip\nDevamsh Ajayakumar\nDevarya Ruparelia\nof the Abu Dhabi Indian School - Al Muroor ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    fontFamily: 'Capriola',
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.005,),
                Text(
                  "With support and guidance from",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Capriola',
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Mrs. Hufrish Parekh",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Capriola',
                      ),
                    ),
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/ind_assets/huffrishmaam.png'),
                      backgroundColor: Colors.transparent,
                      radius: 40,
                    ),
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/ind_assets/aditimaam.png'),
                      backgroundColor: Colors.transparent,
                      radius: 40,
                    ),
                    Text(
                      "Dr. Aditi Hazra",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Capriola',
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Mrs. Nisha Sameer",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Capriola',
                      ),
                    ),
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/ind_assets/nishamaam.png'),
                      backgroundColor: Colors.transparent,
                      radius: 40,
                    ),
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/ind_assets/palaniappansir.png'),
                      backgroundColor: Colors.transparent,
                      radius: 40,
                    ),
                    Container(
                      width: 65,
                      child: Text(
                        "Mr. Palaniappan Muthu",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Capriola',
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
