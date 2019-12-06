import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:rent_car_travel/src/constants/api_http.dart';
import 'package:rent_car_travel/src/models/vehicle.dart';
import 'package:rent_car_travel/src/screen/vehicle/detailCar/detailCar_home_page.dart';

class VehicleList extends StatefulWidget {
  @override
  _VehicleListState createState() => _VehicleListState();
}

class _VehicleListState extends State<VehicleList> {
  Future<List<Vehicle>> _getVehicle() async {
    var data = await http.get(ApiHttp.urlListVehicle);
    List<Vehicle> vehicles = new List<Vehicle>();
    if (data.statusCode == 200) {
      var jsonData = json.decode(data.body) as List;
      for (var obj in jsonData) {
        Vehicle vehicle = Vehicle(
            id: obj["id"] as int,
            nameCar: obj["name"],
            imageCar: obj["image"],
            categoryID: obj["category_code"],
            mode: obj["mode"],
            numberOfSeats: obj["number_of_seats"] as int,
            licensePlates: obj["license_plates"],
            status: obj["status"] as int,
            description: obj["description"],
            pricePerKm: obj["price_perKm"]);
        vehicles.add(vehicle);
      }
    } else {
      throw Exception(
          'We were not able to successfully download the json data.');
    }
    return vehicles;
  }

  @override
  void initState() {
    _getVehicle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      child: FutureBuilder(
          future: _getVehicle(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Center(child: CupertinoActivityIndicator());
            } else
              return _listViewBuild(snapshot);
          }),
    );
  }

  ListView _listViewBuild(AsyncSnapshot snapshot) {
    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.all(16),
      physics: ScrollPhysics(),
      itemCount: snapshot.data.length,
      separatorBuilder: (context, index) {
        return Container(
          height: 12,
        );
      },
      itemBuilder: (context, index) {
        return _buildItemCar(context, snapshot, index);
      },
    );
  }
}

Widget _buildItemCar(BuildContext context, AsyncSnapshot snapshot, int index) {
  var data = snapshot.data[index];
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailCar(
            vehicle: data,
          ),
        ),
      );
    },
    child: Container(
      padding: EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _imageCar(NetworkImage(data.imageCar)),
          Expanded(
            child: _buildInfoCar(
                data.nameCar, data.mode, data.numberOfSeats, data.description),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: _textStatus(data.status))
        ],
      ),
    ),
  );
}

Container _imageCar(ImageProvider<dynamic> image) {
  return Container(
    margin: EdgeInsets.only(right: 12),
    width: 130,
    height: 100,
    decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(blurRadius: 4, color: Colors.grey, offset: Offset(0, 1))
        ],
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(image: image, fit: BoxFit.cover)),
  );
}

Widget _buildInfoCar(
    String nameCar, String mode, int numberOfSeats, String description) {
  return Container(
    alignment: Alignment.topLeft,
    margin: EdgeInsets.only(right: 12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
            margin: EdgeInsets.only(bottom: 8), child: _buildName(nameCar)),
        _buildDetail(mode, numberOfSeats),
        _textDescription(description),
      ],
    ),
  );
}

Widget _buildName(String text) {
  TextStyle nameStyle = TextStyle(
      color: Color(0xFF737373), fontSize: 14, fontWeight: FontWeight.w500);
  return Text(
    text,
    style: nameStyle,
  );
}

Widget _textDescription(String description) {
  return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Text(
        '''${description.toString()}''',
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: Color(0xFFb7b7b7), fontSize: 12),
      ));
}

Widget _buildDetail(String mode, int numberOfSeats) {
  return Container(
    child: Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(right: 12),
          padding: EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.3),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(mode, style: TextStyle(fontSize: 10)),
        ),
        Container(
          padding: EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.3),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            '${numberOfSeats.toInt()} chỗ',
            style: TextStyle(fontSize: 10),
          ),
        )
      ],
    ),
  );
}

Widget _textStatus(int status) {
  TextStyle styleStatus = TextStyle(color: Colors.white, fontSize: 14);
  return Container(
    padding: EdgeInsets.all(4),
    decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              blurRadius: 2,
              color: Colors.grey,
              offset: Offset(0, 1),
              spreadRadius: 0)
        ],
        color: status == 1
            ? Colors.green
            : status == 2 ? Colors.red : Colors.grey,
        borderRadius: BorderRadius.circular(4)),
    child: Text(
      status == 1 ? 'Trống' : status == 2 ? 'Đã thuê' : 'Bảo trì',
      style: styleStatus,
    ),
  );
}
