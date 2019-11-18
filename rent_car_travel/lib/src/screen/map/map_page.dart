import 'package:flutter/material.dart';
import 'package:rent_car_travel/src/screen/map/map.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MapSample(),
    );
  }
}