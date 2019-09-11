import 'package:flutter/material.dart';
import 'package:rent_car_travel/src/models/vehicle.dart';

class DetailCar extends StatefulWidget {
  final Vehicle vehicle;

  const DetailCar({Key key, this.vehicle}) : super(key: key);
  @override
  _DetailCarState createState() => _DetailCarState();
}

class _DetailCarState extends State<DetailCar> {
  @override
  Widget build(BuildContext context) {
    var data = widget.vehicle;
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: Colors.blueAccent,
              expandedHeight: 350.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(data.nameCar,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    )),
                background: Container(
                  child: Image.network(
                    data.imageCar,
                    fit: BoxFit.fitWidth
                  ),
                ),
              ),
            ),
          ];
        },
        body: Center(
          child: InkWell(
            onTap: () {
              print("dataaaaa" + data.nameCar);
            },
            child: Text("detail"),
          ),
        ),
      ),
    );
  }
}
