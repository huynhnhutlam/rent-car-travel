import 'package:flutter/material.dart';
import 'package:rent_car_travel/src/constants/contants.dart';
import 'package:rent_car_travel/src/screen/booking/selected_date/selected_date.dart';

class SelectDatePage extends StatefulWidget {
  @override
  _SelectDatePageState createState() => _SelectDatePageState();
}

class _SelectDatePageState extends State<SelectDatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Date'),
      ),
      body: Container(
        child: SelectedDate(),
      ),
      bottomNavigationBar: Container(
        height: 56,
        padding: EdgeInsets.all(16),
        child: RaisedButton(
          color: Colors.blueAccent,
          onPressed: () {
//            Navigator.pushNamed(context, Constants.select_date);
          },
          child: Text('Next', style: TextStyle(color: Colors.white),),
        ),
      ),
    );
  }
}
