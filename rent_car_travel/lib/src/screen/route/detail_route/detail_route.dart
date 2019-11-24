import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
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
    return ListView(
      padding: EdgeInsets.all(16),
      children: <Widget>[
        Text('Chi tiết',
            style: TextStyle(
                color: Color(0xFF737373), fontWeight: FontWeight.bold)),
        _buildDescription(widget.routes.description),
        _lineHorizontal(),
        Text(
          'Giá',
          style: TextStyle(
            color: Color(0xFF737373),
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8,),
        _price('Giá xe 4 chỗ: ', widget.routes.price4Seats),
        _lineHorizontal(),
        _price('Giá xe 7 chỗ: ', widget.routes.price7Seats),
        _lineHorizontal(),
        _price('Giá xe 16 chỗ: ', widget.routes.price16Seats),
        _lineHorizontal(),
        Text(
          'Address',
          style: TextStyle(
            color: Color(0xFF737373),
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 8),
          width: 200,
          height: 250,
          child: _mapRoute(),
        )
      ],
    );
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

Widget _price(String title, int price) {
  TextStyle titleStyle = TextStyle(
      color: Color(0xFF000000), fontSize: 14, fontWeight: FontWeight.bold);
  TextStyle textStyle = TextStyle(color: Color(0xFF737373), fontSize: 12);
  return Row(
    children: <Widget>[
      Expanded(
        child: Text(
          title,
          style: titleStyle,
        ),
      ),
      Text(
        '${currencyFormatter(price.toInt())} đ',
        style: textStyle,
      )
    ],
  );
}

Widget _buildDescription(String description) {
  TextStyle styleDescription = TextStyle(color: Color(0xFF737373));
  return Container(
    padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
    child: Text(description, style: styleDescription),
  );
}

String currencyFormatter(int n) {
  final formatter = new NumberFormat.currency(
    locale: 'vi',
    decimalDigits: 0,
    symbol: "",
  );
  return formatter.format(n);
}

Widget _lineHorizontal() {
  return Container(
    height: 1,
    margin: EdgeInsets.symmetric(vertical: 12),
    color: Color.fromRGBO(213, 213, 213, 0.34),
  );
}
