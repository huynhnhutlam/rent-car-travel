import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rent_car_travel/src/models/vehicle.dart';

class PopularVehicle extends StatefulWidget {
  @override
  _PopularVehicleState createState() => _PopularVehicleState();
}

class _PopularVehicleState extends State<PopularVehicle> {
  Future<List<Vehicle>> _getVehicle() async {
    var data = await http
        .get("http://www.json-generator.com/api/json/get/cetfLCHWMi?indent=2");
    var jsonData = json.decode(data.body) as List;
    List<Vehicle> routes = new List<Vehicle>();
    for (var obj in jsonData) {
      Vehicle route = Vehicle(
          id: obj["id"],
          nameCar: obj["nameCar"],
          imageCar: obj["imageCar"],
          categoryID: obj["categoryID"],
          mode: obj["mode"],
          numberOfSeats: obj["numberOfSeats"],
          licensePlates: obj["licensePlates"],
          status: obj["status"]);
      routes.add(route);
    }

    return routes;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 12, right: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Text(
                  'Popular Car',
                  style: TextStyle(color: Colors.cyan[300]),
                ),
                new InkWell(
                  child: Text('See more',
                      style: TextStyle(
                          color: Colors.cyan[300],
                          fontStyle: FontStyle.italic)),
                ),
              ],
            ),
          ),
          new Container(
            height: 250,
            child: FutureBuilder(
                future: _getVehicle(),
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
                          nameCar: snapshot.data[index].nameCar,
                          imageCar: snapshot.data[index].imageCar,
                          mode: snapshot.data[index].mode,
                          numberOfSeats: snapshot.data[index].numberOfSeats,
                          licensePlates: snapshot.data[index].licensePlates,
                          status: snapshot.data[index].status,
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
  final String nameCar;
  final String imageCar;
  final String mode;
  final int numberOfSeats;
  final String licensePlates;
  final String status;

  const SinglePopularRoute(
      {Key key,
      this.nameCar,
      this.imageCar,
      this.mode,
      this.numberOfSeats,
      this.licensePlates,
      this.status})
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
      margin: EdgeInsets.only(top: 10, left: 12, bottom: 10, right: 12,),
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      width: MediaQuery.of(context).size.width - 30,
      child: InkWell(
        onTap: () {},
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ClipRRect(
                borderRadius: new BorderRadius.circular(5.0),
                child: Container(
                    width: 200.0,
                    height: 150.0,
                    decoration: new BoxDecoration(
                        image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: new NetworkImage(widget.imageCar),
                    ))),
              ),
              Expanded(
                child: Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Column(
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(widget.nameCar,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green)),
                            Text(widget.status, style: TextStyle(color: Colors.greenAccent),)
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(widget.mode),
                            Text('${widget.numberOfSeats}'+ "chỗ")
                          ],
                        )
                      ],
                    )),
              )
            ]),
      ),
    );
  }
}
