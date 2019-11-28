import 'package:flutter/material.dart';
import 'package:rent_car_travel/src/models/place_item.dart';
import 'package:rent_car_travel/src/screen/booking/travel/selected_Route_Travel/selectedRoute.dart';

class TravelBookingPage extends StatefulWidget {
  final String titleService;

  TravelBookingPage({this.titleService});

  @override
  _TravelBookingPageState createState() => _TravelBookingPageState();
}

class _TravelBookingPageState extends State<TravelBookingPage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.blue),
        title: Text(
          widget.titleService,
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
      body: Container(
        child: SingleChildScrollView(child: SelectRoute(onSelected: onPlaceSelected,)),
      ),
    );
  }
   void onPlaceSelected(PlaceItemRes place, bool fromAddress) {
    var mkId = fromAddress ? "from_address" : "to_address";}
}
