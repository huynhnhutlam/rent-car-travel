import 'package:flutter/material.dart';
import 'package:rent_car_travel/src/constants/contants.dart';
import 'package:rent_car_travel/src/screen/booking/selected_route/selectedRoute.dart';

class BookingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Route'),

      ),
      body: SafeArea(
        child: Container(
          color: Colors.grey[300],
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SelectRoute(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 56,
        padding: EdgeInsets.all(16),
        child: RaisedButton(
          color: Colors.blueAccent,
          onPressed: () {
            Navigator.pushNamed(context, Constants.select_date);
          },
          child: Text('Next', style: TextStyle(color: Colors.white),),
        ),
      ),
    );
  }
}
