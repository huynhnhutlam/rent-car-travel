import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rent_car_travel/src/constants/contants.dart';
import 'package:rent_car_travel/src/models/place_item.dart';
import 'package:rent_car_travel/src/screen/booking/ariport_booking/selected_route/selectedRoute.dart';

import 'package:provider/provider.dart';
import 'package:rent_car_travel/src/bloc/place_notifer.dart';
import 'package:rent_car_travel/src/screen/booking/selected_date/selected_date_aripot.dart';

class AirportBookingPage extends StatefulWidget {
  @override
  _AirportBookingPageState createState() => _AirportBookingPageState();
}

class _AirportBookingPageState extends State<AirportBookingPage> {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text('Ariport Booking'),
        actions: <Widget>[
          Center(
              child: InkWell(
                  child: Text('Tiếp'),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (builder)=>SelectedDate(
                      pickupPoint: appState.locationController.text,
                      dropPoint: appState.destinationController.text,
                    )));
                  }))
        ],
      ),
      body: Container(
        child: appState.initialPosition == null
            ? Container(
                alignment: Alignment.center,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Stack(
                children: <Widget>[
                  Container(
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                          target: appState.initialPosition, zoom: 8.0),
                      onMapCreated: appState.onCreated,
                      myLocationEnabled: true,
                      mapType: MapType.normal,
                      compassEnabled: true,
                      markers: appState.markers,
                      onCameraMove: appState.onCameraMove,
                      polylines: appState.polyLines,
                    ),
                  ),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: Container(
                        height: MediaQuery.of(context).size.height / 1.9,
                        width: MediaQuery.of(context).size.height,
                        child: SelectRoute(
                          controllerPickUp: appState.locationController.text,
                          onSelected: onPlaceSelected,
                          controllerGoto: appState.destinationController,
                        ),
                      ))
                ],
              ),
      ),
    );
  }

  void onPlaceSelected(PlaceItemRes place, bool fromAddress) {}
}
