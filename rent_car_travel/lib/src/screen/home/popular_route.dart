import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:rent_car_travel/src/constants/api_http.dart';
import 'package:rent_car_travel/src/constants/contants.dart';
import 'package:rent_car_travel/src/models/route.dart';
import 'package:rent_car_travel/src/screen/route/detail_route/detail_home_page.dart';
import 'dart:async';

import 'package:rent_car_travel/src/screen/widget/title_home.dart';

class PopularRoute extends StatefulWidget {
  @override
  _PopularRouteState createState() => _PopularRouteState();
}

class _PopularRouteState extends State<PopularRoute> {
  Future<List<Routes>> _getRotues() async {
    var data = await http.get(
        ApiHttp.urlListRoute);
    var jsonData = json.decode(data.body) as List;
    List<Routes> vehicles = new List<Routes>();
    for (var obj in jsonData) {
      Routes vehicle = Routes(
        id: obj['id'] as int,
        nameRoute: obj['name'],
        image: obj['image'],
        rating: obj['rating'],
        lat: obj['lat'],
        lng: obj['lng'],
        price4Seats: obj['price_4_seats'],
        price7Seats: obj['price_7_seats'],
        description: obj['description'],
        price16Seats: obj['price_16_seats'],
      );
      vehicles.add(vehicle);
    }

    return vehicles;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: Column(
        children: <Widget>[
          TitleHome(
            onTap: () {
              Navigator.pushNamed(context, Constants.route_list);
            },
            text: 'Tuyến đường phổ biến',
          ),
          new Container(
            height: 200,
            child: FutureBuilder(
                future: _getRotues(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return new CupertinoActivityIndicator();
                  } else
                    return new ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return SinglePopularRoute(
                          name:  snapshot.data[index].nameRoute,
                          image: ApiHttp.urlImageRoute + snapshot.data[index].image,
                          description: snapshot.data[index].description,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (builder) => DetailRouteHome(
                                  route: snapshot.data[index],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                }),
          )
        ],
      ),
    );
  }
}

class SinglePopularRoute extends StatefulWidget {
  final String name;
  final String image;
  final String description;
  final Function onPressed;

  const SinglePopularRoute(
      {Key key, this.name, this.image, this.description, this.onPressed})
      : super(key: key);

  @override
  _SinglePopularRouteState createState() => _SinglePopularRouteState();
}

class _SinglePopularRouteState extends State<SinglePopularRoute> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            spreadRadius: 0,
            color: Colors.grey,
            offset: Offset(0, 1),
          )
        ],
      ),
      margin: EdgeInsets.only(top: 10, left: 12, bottom: 10, right: 12),
      width: 150,
      child: InkWell(
        onTap: widget.onPressed,
        child: Stack(children: <Widget>[
          Container(
            child: Container(
                decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: new NetworkImage(widget.image),
                    ))),
          ),
          Positioned(
            bottom: 5,
            right: 16,
            child: Container(
              margin: EdgeInsets.only(top: 10),
              child: Text(
                widget.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16,
                  shadows: [BoxShadow(blurRadius: 4)],
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
