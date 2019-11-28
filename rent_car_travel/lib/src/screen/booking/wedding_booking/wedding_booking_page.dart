import 'package:flutter/material.dart';
import 'package:rent_car_travel/src/constants/contants.dart';
import 'package:rent_car_travel/src/models/place_item.dart';
import 'package:rent_car_travel/src/screen/booking/selected_date/selected_date_page.dart';
import 'package:rent_car_travel/src/screen/booking/wedding_booking/selected_route/selectedRoute.dart';

class WeddingBookingPage extends StatelessWidget {
  final String titleService;

  WeddingBookingPage({this.titleService});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.blue),
        title: Text(
          titleService,
          style: TextStyle(color: Colors.blue, fontSize: 18),
        ),
        centerTitle: true,
        actions: <Widget>[
          Center(
            child: InkWell(
              child: Container(
                padding: EdgeInsets.all(12),
                margin: EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4,
                      offset: Offset(0, 1),
                      color: Colors.white,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          color: Colors.grey[300],
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SelectRouteWedding(
                  onSelected: onPlaceSelected,
                ),
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
            Navigator.push(context, MaterialPageRoute(builder: (builder) {
              return SelectDatePage();
            }));
          },
          child: Text(
            'Next',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  void onPlaceSelected(PlaceItemRes place, bool fromAddress) {}
}
