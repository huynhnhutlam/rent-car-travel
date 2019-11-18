import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rent_car_travel/src/models/route.dart';

class DetailRoute extends StatefulWidget {
  final Routes routes;

  const DetailRoute({Key key, this.routes}) : super(key: key);
  @override
  _DetailRouteState createState() => _DetailRouteState();
}

class _DetailRouteState extends State<DetailRoute> {
  GoogleMapController mapController;
  final Set<Marker> _markers = Set();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return ListView(padding: EdgeInsets.all(16), children: <Widget>[
      Text('Description',
          style:
              TextStyle(color: Color(0xFF737373), fontWeight: FontWeight.bold)),
      _buildDescription(widget.routes.description),
      Container(
          margin: EdgeInsets.symmetric(vertical: 8),
          color: Colors.grey,
          height: 2),
      Text('Address',
          style:
              TextStyle(color: Color(0xFF737373), fontWeight: FontWeight.bold)),
      Container(
        margin: EdgeInsets.only(top: 8),
        width: 200,
        height: 250,
        child: _mapRoute(),
      )
    ]);
  }

  Widget _mapRoute() {
    LatLng _center = LatLng(widget.routes.lat, widget.routes.lng);
    LatLng _lastMapPosition = _center;
    return GoogleMap(
      scrollGesturesEnabled: false,
      zoomGesturesEnabled: false,
      mapType: MapType.normal,
      initialCameraPosition: CameraPosition(
        target: _center,
        zoom: 13.4746,
      ),
      onMapCreated: (GoogleMapController controller) {
        mapController = controller;
        setState(() {
          _markers.add(Marker(
            markerId: MarkerId(_lastMapPosition.toString()),
            position: _lastMapPosition,
            infoWindow: InfoWindow(
              title: widget.routes.nameRoute,
              snippet: '${widget.routes.rating} Star Rating',
            ),
            icon: BitmapDescriptor.defaultMarker,
          ));
        });
      },
      markers: _markers,
      onCameraMove: (CameraPosition position) {
        _lastMapPosition = position.target;
      },
    );
  }
}

Widget _buildDescription(String description) {
  TextStyle styleDescription = TextStyle(color: Color(0xFF737373));
  return Container(
    padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
    child: Text(description, style: styleDescription),
  );
}
