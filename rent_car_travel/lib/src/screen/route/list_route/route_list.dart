import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rent_car_travel/src/constants/api_http.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:rent_car_travel/src/models/route.dart';
import 'package:rent_car_travel/src/screen/route/detail_route/detail_home_page.dart';

class RouteList extends StatefulWidget {
  @override
  _RouteListState createState() => _RouteListState();
}

double radius = 8;
Future<List<Routes>> fetchRoute(http.Client client) async {
  final response = await client.get(ApiHttp.urlListRoute);

  return compute(parseRoutes, response.body);
}

List<Routes> parseRoutes(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Routes>((json) => Routes.fromJson(json)).toList();
}

class _RouteListState extends State<RouteList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchRoute(http.Client()),
      builder: (context, snapshot) {
        return snapshot.data != null
            ? Container(
                child: GridView.builder(
                  itemCount: snapshot.data.length,
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.all(16),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16.0,
                      crossAxisSpacing: 24.0,
                      childAspectRatio: 2 / 3),
                  itemBuilder: (context, index) {
                    return _itemRouteList(snapshot, index);
                  },
                ),
              )
            : CupertinoActivityIndicator();
      },
    );
  }

  Widget _itemRouteList(AsyncSnapshot snapshot, int index) {
    var data = snapshot.data[index];
    return InkWell(
      onTap: (){
           Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (builder) => DetailRouteHome(
                                  route: data,
                                ),
                              ),
                            );
      },
          child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 4.0,
              offset: Offset(0, 1),
              color: Colors.grey,
              spreadRadius: 1.0,
            ),
          ],
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: _imageRoute(
                image: NetworkImage(ApiHttp.urlImageRoute + data.image),
                chilld: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 8,
                      right: 8,
                      child: _ratingRoute(data.rating),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _textNameRoute(data.nameRoute),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: _textDesriptionRout(data.description),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget _textNameRoute(String nameRoute) {
  TextStyle styleNameRoute = TextStyle(
    color: colorNameRoute,
    fontSize: sizeName,
  );
  return Text(
    nameRoute,
    style: styleNameRoute,
  );
}

Widget _textDesriptionRout(String descriptionRoute) {
  TextStyle styleDescriptionRoute = TextStyle(
    color: colorDescription,
    fontSize: sizeDescription,
  );
  return Text(
    descriptionRoute,
    style: styleDescriptionRoute,
    maxLines: 2,
    overflow: TextOverflow.ellipsis,
  );
}

Widget _imageRoute({ImageProvider<dynamic> image, Widget chilld}) {
  return Container(
    width: 240,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radius), topRight: Radius.circular(radius)),
      image: DecorationImage(image: image, fit: BoxFit.cover),
    ),
    child: chilld,
  );
}

Widget _ratingRoute(double rating) {
  return Container(
    decoration: _decorate,
    padding: EdgeInsets.all(2),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(vertical: 4),
          child: _rowStar(3),
        ),
        _textRating('${rating.toDouble()}'),
      ],
    ),
  );
}

Widget _rowStar(int length) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: List.generate(length, (index) {
      return InkWell(
        onTap: () {},
        child: Icon(
          Icons.star,
          color: Colors.white,
          size: 10,
        ),
      );
    }),
  );
}

Widget _textRating(String rating) {
  TextStyle styleRating = TextStyle(color: colorRating, fontSize: sizeRating);
  return Text(
    rating,
    style: styleRating,
  );
}

BoxDecoration _decorate = BoxDecoration(
  color: Colors.amber,
  borderRadius: BorderRadius.circular(4),
  boxShadow: [
    BoxShadow(
        blurRadius: 4.0,
        offset: Offset(0, 1),
        color: Colors.black,
        spreadRadius: 0.0)
  ],
);
Color colorRating = Color(0xFFFFFFFF);
double sizeRating = 12;
double sizeName = 14;
double sizeDescription = 12;
Color colorNameRoute = Color(0xFF000000);
Color colorDescription = Color(0xFF737373);
