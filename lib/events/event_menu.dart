import 'package:flutter/material.dart';
import 'package:save_water/widgets/image_card.dart';

class eventMenu extends StatefulWidget {
  const eventMenu({Key? key}) : super(key: key);

  @override
  State<eventMenu> createState() => _eventMenuState();
}

class _eventMenuState extends State<eventMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Upcoming Events',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 18
            ),
          ),
          backgroundColor: Color(0xFF4B39EF),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              InkWell(
                onTap: (){
                  Navigator.pushNamed(context, '/home/event/international');
                },
                child: ImageCard(
                  title: 'International Events',
                  description: 'Events happening all over the world',
                  image: AssetImage('assets/images/waterpollution.png'),
                )
              ),
              InkWell(
                onTap: (){
                  Navigator.pushNamed(context, '/home/event/local');
                },
                child: ImageCard(
                  title: 'Local Events',
                  description: 'Find out about all the events happening in UAE',
                  image: AssetImage('assets/images/environment.png'),
                )
              ),
            ],
          ),
        )
    );
  }
}
