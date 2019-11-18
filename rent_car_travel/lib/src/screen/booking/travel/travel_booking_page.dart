import 'package:flutter/material.dart';
import 'package:rent_car_travel/src/models/place_item.dart';
import 'package:rent_car_travel/src/screen/booking/travel/selected_Route_Travel/selectedRoute.dart';

class TravelBookingPage extends StatefulWidget {
  @override
  _TravelBookingPageState createState() => _TravelBookingPageState();
}

class _TravelBookingPageState extends State<TravelBookingPage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: <Widget>[
            InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 25,
                  width: 25,
                  child: Icon(Icons.arrow_back, size: 20,),
                ),),
                Text('Travel')
          ],
        ),
      ),
      body: Container(
        child: SingleChildScrollView(child: SelectRoute(onSelected: onPlaceSelected,)),
      ),
    );
  }
   void onPlaceSelected(PlaceItemRes place, bool fromAddress) {
    var mkId = fromAddress ? "from_address" : "to_address";}
}
