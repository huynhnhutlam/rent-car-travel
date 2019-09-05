import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:rent_car_travel/src/models/route.dart';
import 'dart:async';

class PopularRoute extends StatefulWidget {
  @override
  _PopularRouteState createState() => _PopularRouteState();
}

class _PopularRouteState extends State<PopularRoute> {
  Future<List<Routes>> _getRoute() async {
    var data = await http
        .get("http://www.json-generator.com/api/json/get/bVVufgrThe?indent=2");
    var jsonData = json.decode(data.body) as List;
    List<Routes> routes = new List<Routes>();
    for (var obj in jsonData) {
      Routes route = Routes(
          id: obj["id"],
          nameRoute: obj["nameRoute"],
          image: obj["image"],
          description: obj["description"]);
      routes.add(route);
    }

    return routes;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 12, right: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Text('Popular Route', style: TextStyle(color: Colors.cyan[300]),),
                new InkWell(
                  child: Text('See more', style: TextStyle(color: Colors.cyan[300], fontStyle: FontStyle.italic)),
                ),
              ],
            ),
          ),
          new Container(
            height: 200,
            child: FutureBuilder(
                future: _getRoute(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return new CircularProgressIndicator();
                  } else
                    return new ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return SinglePopularRoute(
                          name: snapshot.data[index].nameRoute,
                          image: snapshot.data[index].image,
                          description: snapshot.data[index].description,
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

  const SinglePopularRoute({Key key, this.name, this.image, this.description})
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
        borderRadius: BorderRadius.circular(2.0),
        boxShadow: [
          BoxShadow(
              blurRadius: 4,
              spreadRadius: 0,
              color: Colors.grey,
              offset: Offset(0, 1))
        ],
      ),
      margin: EdgeInsets.only(top: 10, left: 12, bottom: 10, right: 12),
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      width: 150,
      child: InkWell(
        onTap: () {},
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                child: ClipRRect(
                  borderRadius: new BorderRadius.circular(50.0),
                  child: Container(
                      width: 100.0,
                      height: 100.0,
                      decoration: new BoxDecoration(
                          image: new DecorationImage(
                        fit: BoxFit.fill,
                        image: new NetworkImage(widget.image),
                      ))),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                    child: Text(widget.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.green))),
              )
            ]),
      ),
    );
  }
}
