import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rent_car_travel/src/constants/contants.dart';
import 'package:rent_car_travel/src/models/vehicle.dart';
import 'package:rent_car_travel/src/screen/detail/detailCar/detailCar_home_page.dart';
import 'package:rent_car_travel/src/screen/widget/title_home.dart';

class PopularVehicle extends StatefulWidget {
  @override
  _PopularVehicleState createState() => _PopularVehicleState();
}

class _PopularVehicleState extends State<PopularVehicle> {
  Future<List<Vehicle>> _getVehicle() async {
    var data = await http
        .get("http://www.json-generator.com/api/json/get/cetfLCHWMi?indent=2");
    var jsonData = json.decode(data.body) as List;
    List<Vehicle> vehicles = new List<Vehicle>();
    for (var obj in jsonData) {
      Vehicle vehicle = Vehicle(
          id: obj["id"],
          nameCar: obj["nameCar"],
          imageCar: obj["imageCar"],
          categoryID: obj["categoryID"],
          mode: obj["mode"],
          numberOfSeats: obj["numberOfSeats"],
          licensePlates: obj["licensePlates"],
          status: obj["status"]);
      vehicles.add(vehicle);
    }

    return vehicles;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          TitleHome(
            onTap: (){},
            text: 'Popular Vehicle',
          ),
          new Container(
            height: 250,
            child: FutureBuilder(
                future: _getVehicle(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return new RefreshIndicator(
                        onRefresh: () async {}, child: Text("Loading..."));
                  } else
                    return new ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return _singlePopularVehicle(context, snapshot, index
                            // nameCar: snapshot.data[index].nameCar,
                            // imageCar: snapshot.data[index].imageCar,
                            // mode: snapshot.data[index].mode,
                            // numberOfSeats: snapshot.data[index].numberOfSeats,
                            // licensePlates: snapshot.data[index].licensePlates,
                            // status: snapshot.data[index].status,
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

Widget _singlePopularVehicle(
    BuildContext context, AsyncSnapshot snapshot, int index) {
  var data = snapshot.data[index];
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(5.0),
      boxShadow: [
        BoxShadow(
            blurRadius: 4,
            spreadRadius: 0,
            color: Colors.grey,
            offset: Offset(0, 1))
      ],
    ),
    margin: EdgeInsets.only(
      top: 10,
      left: 12,
      bottom: 10,
      right: 12,
    ),
    width: MediaQuery.of(context).size.width - 30,
    child: InkWell(
      onTap: () {
        print("data::" + data.nameCar);
        Navigator.pushNamed(context, Constants.detailCar, arguments: data);
      },
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ClipRRect(
              borderRadius: new BorderRadius.circular(5.0),
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 150.0,
                  decoration: new BoxDecoration(
                      image: new DecorationImage(
                    fit: BoxFit.fill,
                    image: new NetworkImage(data.imageCar),
                  ))),
            ),
            Expanded(
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  margin: EdgeInsets.only(top: 10),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(data.nameCar,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green)),
                            Text(
                              data.status,
                              style: TextStyle(color: Colors.greenAccent),
                            )
                          ],
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                              padding: EdgeInsets.all(2),
                              margin: EdgeInsets.only(right: 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: Colors.grey[350].withOpacity(0.5)),
                              child: Text(data.mode)),
                          Container(
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: Colors.grey[350].withOpacity(0.5)),
                              child: Text('${data.numberOfSeats}' + " chỗ"))
                        ],
                      )
                    ],
                  )),
            )
          ]),
    ),
  );
}
/*
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
        borderRadius: BorderRadius.circular(5.0),
        boxShadow: [
          BoxShadow(
              blurRadius: 4,
              spreadRadius: 0,
              color: Colors.grey,
              offset: Offset(0, 1))
        ],
      ),
      margin: EdgeInsets.only(
        top: 10,
        left: 12,
        bottom: 10,
        right: 12,
      ),
      width: MediaQuery.of(context).size.width - 30,
      child: InkWell(
        onTap: () {  Navigator.pushNamed(context, Constants.detailCar, arguments: widget.nameCar);},
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ClipRRect(
                borderRadius: new BorderRadius.circular(5.0),
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 150.0,
                    decoration: new BoxDecoration(
                        image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: new NetworkImage(widget.imageCar),
                    ))),
              ),
              Expanded(
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    margin: EdgeInsets.only(top: 10),
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(bottom: 5),
                          child: Row(
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
                              Text(
                                widget.status,
                                style: TextStyle(color: Colors.greenAccent),
                              )
                            ],
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                                padding: EdgeInsets.all(2),
                                margin: EdgeInsets.only(right: 5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    color: Colors.grey[350].withOpacity(0.5)),
                                child: Text(widget.mode)),
                            Container(
                                padding: EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    color: Colors.grey[350].withOpacity(0.5)),
                                child:
                                    Text('${widget.numberOfSeats}' + " chỗ"))
                          ],
                        )
                      ],
                    )),
              )
            ]),
      ),
    );
  }
}*/