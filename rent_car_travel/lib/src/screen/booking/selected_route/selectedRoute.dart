import 'package:flutter/material.dart';
import 'package:rent_car_travel/src/screen/widget/title_home.dart';

class SelectRoute extends StatefulWidget {
  @override
  _SelectRouteState createState() => _SelectRouteState();
}

class _SelectRouteState extends State<SelectRoute> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: <Widget>[
          _diemDen(context),
          _selectRoute(context),
          TitleHome(
            text: 'Recommend Route',
          ),
          SizedBox(height: 4,),

        ],
      ),
    );
  }
}

Widget _diemDen(BuildContext context) {
  return Container(
    margin: EdgeInsets.all(12),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [BoxShadow(blurRadius: 4, color: Colors.grey)]),
    child: Column(
      children: <Widget>[
        Container(
          child: Row(
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: 12),
                        child: Icon(Icons.location_on, size: 18,)),
                    Text('Điểm đón'),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: TextField(
            textInputAction: TextInputAction.go,
            decoration: InputDecoration(
              hintText: 'Input',
            ),
          ),
        )
      ],
    ),
  );
}

Widget _selectRoute(BuildContext context) {
  return Container(
    margin: EdgeInsets.all(12),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [BoxShadow(blurRadius: 4, color: Colors.grey)]),
    child: Column(
      children: <Widget>[
        Container(
          child: Row(
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: 12),
                        child: Icon(Icons.my_location, size: 18, color: Colors.blue,)),
                    Text('Route', style: TextStyle( color: Colors.blue),),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: TextField(
            textInputAction: TextInputAction.go,
            decoration: InputDecoration(
              hintText: 'Input',
            ),
          ),
        )
      ],
    ),
  );
}
