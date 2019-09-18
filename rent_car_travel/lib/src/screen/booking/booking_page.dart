import 'package:flutter/material.dart';
import 'package:rent_car_travel/src/screen/booking/selectedRoute.dart';

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
              children: <Widget>[SelectRoute()],
            ),
          ),
        ),
      ),
    );
  }
}
