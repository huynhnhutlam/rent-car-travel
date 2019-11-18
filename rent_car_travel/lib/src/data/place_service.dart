import 'package:rent_car_travel/src/models/place_item.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class PlaceService {
  //Key Map: AIzaSyCvAaSMgeGCb5zJc6evLOehEHxayBEu8ms
  static Future<List<PlaceItemRes>> searchPlace(String keyword) async {
    String url =
        "https://maps.googleapis.com/maps/api/place/textsearch/json?key=" +
            'AIzaSyCvAaSMgeGCb5zJc6evLOehEHxayBEu8ms' +
            "&language=vi&region=VN&query=" +
            Uri.encodeQueryComponent(keyword);

    print("search >>: " + url);
    var res = await http.get(url);
    if (res.statusCode == 200) {
      return PlaceItemRes.fromJson(json.decode(res.body));
    } else {
      return new List();
    }
  }
}

const apiKey = "AIzaSyCvAaSMgeGCb5zJc6evLOehEHxayBEu8ms";

class GoogleMapsServices {
  Future<String> getRouteCoordinates(LatLng l1, LatLng l2) async {
    String url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${l1.latitude},${l1.longitude}&destination=${l2.latitude},${l2.longitude}&sensor=false&mode=driving&key=$apiKey";
    http.Response response = await http.get(url);
    Map values = jsonDecode(response.body);
    print(url);
    return values["routes"][0]["overview_polyline"]["points"];
  }
}
