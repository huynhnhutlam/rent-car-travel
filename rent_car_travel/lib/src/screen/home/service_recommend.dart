import 'package:flutter/material.dart';
import 'package:rent_car_travel/src/constants/api_http.dart';
import 'package:rent_car_travel/src/constants/contants.dart';
import 'package:rent_car_travel/src/models/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:rent_car_travel/src/screen/widget/title_home.dart';

class ServiceRecommend extends StatefulWidget {
  @override
  _ServiceRecommendState createState() => _ServiceRecommendState();
}

class _ServiceRecommendState extends State<ServiceRecommend> {
  Future<List<Service>> _getService() async {
    var data = await http
        .get(ApiHttp.urlListService);
    var jsonData = json.decode(data.body) as List;
    List<Service> services = new List<Service>();
    for (var obj in jsonData) {
      Service service = Service(
        id: obj["id"],
        nameService: obj["name"],
        image: obj["image"],
        description: obj["description"],
      );
      services.add(service);
    }

    return services;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          TitleHome(
            onTap: () {},
            text: 'Chọn dịch vụ',
            txtSeemore: '',
          ),
          new Container(
            height: 300,
            child: FutureBuilder(
                future: _getService(),
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return new RefreshIndicator(
                        onRefresh: () async {}, child: Text("Loading..."));
                  } else
                    return new ListView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return _singleService(context, snapshot, index);
                      },
                    );
                }),
          )
        ],
      ),
    );
  }
}

Widget _singleService(BuildContext context, AsyncSnapshot snapshot, int index) {
  var data = snapshot.data[index];
  final styleTitle =
      TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16);
  final styleDescription = TextStyle(color: Colors.grey[600], fontSize: 14);
  return GestureDetector(
    onTap: () {
      if (index == 0) {
        Navigator.pushNamed(context, Constants.travel_booking, arguments: data);
      }
      if (index == 1) {
        Navigator.pushNamed(context, Constants.airport_booking, arguments: data);
      }
      if (index == 2) {
        Navigator.pushNamed(context, Constants.wedding_booking,arguments: data);
      }
    },
    child: Container(
      height: 80,
      margin: EdgeInsets.only(
        top: 10,
        left: 12,
        bottom: 10,
        right: 12,
      ),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 4)]),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(bottom: 5),
                      child: Text(
                        data.nameService,
                        style: styleTitle,
                      )),
                  Container(
                      child: Text(
                    '''${data.description}''',
                    style: styleDescription,
                  ))
                ],
              ),
            ),
          ),
          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(image: NetworkImage(data.image))),
          )
        ],
      ),
    ),
  );
}
