import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rent_car_travel/src/models/place_item.dart';
import 'package:rent_car_travel/src/screen/map/place_picker_page.dart';
import 'package:rent_car_travel/src/screen/widget/title_home.dart';
import 'package:geolocator/geolocator.dart';

class SelectRouteWedding extends StatefulWidget {
  final Function(PlaceItemRes, bool, BuildContext) onSelected;

  SelectRouteWedding({Key key, this.onSelected}) : super(key: key);

  @override
  _SelectRouteWeddingState createState() => _SelectRouteWeddingState();
}

class _SelectRouteWeddingState extends State<SelectRouteWedding> {
  GoogleMapController controller;
  Map<PolylineId, Polyline> polylines = <PolylineId, Polyline>{};
  int _polylineIdCounter = 1;
  PolylineId selectedPolyline;
  PlaceItemRes fromAddress;
  PlaceItemRes toAddress;
  GoogleMapController mapController;
  final Set<Marker> _markers = Set();
  LatLng center;
  Position currentLocation;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  MarkerId selectedMarker;
  int _markerIdCounter = 1;
  String textCurrentLocation = '';
  @override
  void initState() {
    super.initState();
    getUserLocation();
    print(currentLocation);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<Position> locateUser() async {
    return Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
  }

  getUserLocation() async {
    currentLocation = await locateUser();

    List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(
        currentLocation.latitude, currentLocation.longitude);
    setState(() {
      center = LatLng(currentLocation.latitude, currentLocation.longitude);
      textCurrentLocation =
          "${placemark[0].name}, ${placemark[0].subAdministrativeArea}, ${placemark[0].administrativeArea}, ${placemark[0].country}";
    });
    print('center $center');
  }

  void _remove() {
    setState(() {
      if (polylines.containsKey(selectedPolyline)) {
        polylines.remove(selectedPolyline);
      }
      selectedPolyline = null;
    });
  }

  void _add() {
    final int polylineCount = polylines.length;

    if (polylineCount == 12) {
      return;
    }

    final String polylineIdVal = 'polyline_id_$_polylineIdCounter';
    _polylineIdCounter++;
    final PolylineId polylineId = PolylineId(polylineIdVal);

    final Polyline polyline = Polyline(
      polylineId: polylineId,
      consumeTapEvents: true,
      color: Colors.orange,
      width: 5,
      points: _createPoints(),
    );

    setState(() {
      polylines[polylineId] = polyline;
    });
  }

  List<LatLng> _createPoints() {
    final List<LatLng> points = <LatLng>[];
    points.add(
        _createLatLng(currentLocation.latitude, currentLocation.longitude));
    points.add(_createLatLng(fromAddress.lat, fromAddress.lng));
    return points;
  }

  LatLng _createLatLng(double lat, double lng) {
    return LatLng(lat, lng);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _selectedPickUp(
              fromAddress == null ? textCurrentLocation : fromAddress.name,
              _selectedPickUpPlace),
          _selectedPickUp(toAddress == null ? "Chọn điểm đến" : toAddress.name,
              _selectedPlace,
              text: 'Điểm đến'),
          TitleHome(
            text: 'Recommend Route',
            onTap: _add,
          ),
          Container(
            padding: EdgeInsets.all(16),
            width: MediaQuery.of(context).size.width,
            height: 350,
            child: currentLocation == null
                ? Container(
                    child: Container(),
                  )
                : _mapRoute(
                    fromAddress == null
                        ? currentLocation.latitude
                        : fromAddress.lat,
                    fromAddress == null
                        ? currentLocation.longitude
                        : fromAddress.lng),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
          )
        ],
      ),
    );
  }

  Widget _selectedPickUp(String title, Function onPressed,
      {String text = 'Điểm đón'}) {
    return Container(
      margin: EdgeInsets.all(12),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          boxShadow: [BoxShadow(blurRadius: 4, color: Colors.grey)]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: _titleInput(text, Icons.location_on,
                color: text == 'Điểm đón' ? Colors.grey : Colors.redAccent),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: _textRoute(title, onPressed: onPressed),
          )
        ],
      ),
    );
  }

  Widget _textRoute(String title, {Function onPressed}) {
    final TextStyle hintStyle =
        TextStyle(color: Color(0xFFadadad), fontSize: 12);
    final TextStyle textStyle = TextStyle(color: Colors.black, fontSize: 13);
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 30,
        alignment: Alignment.centerLeft,
        width: double.maxFinite,
        child: Text(
          title,
          textAlign: TextAlign.start,
          style: title == 'Chọn điểm đón'
              ? hintStyle
              : title == 'Chọn điểm đến' ? hintStyle : textStyle,
        ),
      ),
    );
  }

  void _selectedPickUpPlace() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PlacePickerPage(
                fromAddress == null ? "" : fromAddress.name, (place, isFrom) {
              widget.onSelected(place, isFrom, context);
              fromAddress = place;
              setState(() {});
            }, true)));
  }

  void _selectedPlace() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PlacePickerPage(
                toAddress == null ? "" : toAddress.name, (place, isFrom) {
              widget.onSelected(place, isFrom,context);
              toAddress = place;
              setState(() {});
            }, false)));
  }

  Widget _mapRoute(double lat, double lng) {
    LatLng _center = LatLng(lat, lng);
    print(_center);
    LatLng _lastMapPosition = _center;
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: CameraPosition(
        target: _lastMapPosition,
        zoom: 13.4746,
      ),
      myLocationEnabled: true,
      onMapCreated: (GoogleMapController controller) {
        mapController = controller;
        setState(() {
          _markers.add(Marker(
            markerId: MarkerId(_lastMapPosition.toString()),
            position: _lastMapPosition,
            infoWindow: InfoWindow(
              title: 'abc',
              snippet: ' Star Rating',
            ),
            icon: BitmapDescriptor.defaultMarker,
          ));
        });
      },
      polylines: Set<Polyline>.of(polylines.values),
      markers: _markers,
      onCameraMove: (CameraPosition position) {
        _lastMapPosition = position.target;
      },
    );
  }
}

Widget _titleInput(String title, IconData icon, {Color color}) {
  return Container(
    child: Row(
      children: <Widget>[
        Container(
            margin: EdgeInsets.symmetric(horizontal: 12),
            child: Icon(
              icon,
              size: 18,
              color: color,
            )),
        Text(
          title,
          style: TextStyle(
              color: Colors.blue, fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ],
    ),
  );
}
