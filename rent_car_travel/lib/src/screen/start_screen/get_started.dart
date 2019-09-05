import 'package:flutter/material.dart';
import 'package:rent_car_travel/src/constants/contants.dart';

class GetStartPage extends StatefulWidget {
  @override
  _GetStartPageState createState() => _GetStartPageState();
}

class _GetStartPageState extends State<GetStartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              child: new Image.asset(
                'lib/res/images/bg.jpg',
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.fitHeight,
              ),
            ),
            Container(
              color: Colors.black.withOpacity(0.5),
            ),
            Align(
              alignment: Alignment(0, -0.5),
              child: Text(
                'Rental Car',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.all(14),
              child: MaterialButton(
                height: 45,
                minWidth: MediaQuery.of(context).size.width,
                color: Colors.green,
                onPressed: () {Navigator.pushNamed(context, Constants.signInScreen);},
                child: Text('Get Started'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
