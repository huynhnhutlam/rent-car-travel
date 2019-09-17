import 'package:flutter/material.dart';
import 'package:rent_car_travel/src/models/vehicle.dart';

import 'detailCar.dart';

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
                  child: Image.network(data.imageCar, fit: BoxFit.fitWidth),
                ),
              ),
            ),
          ];
        },
        body: Container(
          color: Colors.grey.withOpacity(0.3),
          child: ListView(
            children: <Widget>[
              Container(
                child: Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Detail',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      new Detail(data: data)
                    ],
                  ),
                ),
              ),
              Container(
                height: 3,
                color: Colors.grey.withOpacity(0.5),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: _description(context),
              ),
              Container(
                height: 3,
                color: Colors.grey.withOpacity(0.5),
              ),
              //ReView
              Padding(
                padding: EdgeInsets.all(10),
                child: Text('Review'),
              ),
              Container(
                height: 3,
                color: Colors.grey.withOpacity(0.5),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text('Recommendation'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.green,
          boxShadow: [
            BoxShadow(
              blurRadius: 4,
              color: Colors.grey
            )
          ]
        ),
        height: 56,
        child: RaisedButton(
          onPressed: null,
          child: Text('Booking Now'),
        ),
      ),
    );
  }

  Widget _description(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Description'),
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
                '''abbccasdsadsadsadsadsadasddassssssssssssssssssssssssssssssssssssssssssssssssssssssssasddddddddddddddddddddddddddddd'''),
          )
        ],
      ),
    );
  }
}
