import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rent_car_travel/src/constants/contants.dart';
import 'package:rent_car_travel/src/models/place_item.dart';
import 'package:rent_car_travel/src/models/services.dart';
import 'package:rent_car_travel/src/screen/booking/ariport_booking/selected_route/selectedRoute.dart';

import 'package:provider/provider.dart';
import 'package:rent_car_travel/src/bloc/place_notifer.dart';
import 'package:rent_car_travel/src/screen/booking/selected_date/selected_date_aripot.dart';

class AirportBookingPage extends StatefulWidget {
  final Service service;

  AirportBookingPage({this.service});

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
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.blue),
        title: Text(widget.service.nameService, style: TextStyle(color: Colors.blue, fontSize: 18),),
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
                          )
                        ],
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.white,
                      ),
                      child: Text('Tiếp tục', style: TextStyle(color: Colors.blue,),)),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => SelectedDate(
                                  pickupPoint: appState.locationController.text,
                                  dropPoint:
                                      appState.destinationController.text,
                                      service: widget.service,
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
                          target: appState.initialPosition, zoom: 12.0),
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
                    ),
                  )
                ],
              ),
      ),
    );
  }

  void onPlaceSelected(PlaceItemRes place, bool fromAddress) {}
}
