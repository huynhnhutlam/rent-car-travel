import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rent_car_travel/src/constants/api_http.dart';
import 'package:rent_car_travel/src/models/booking/booking.dart';
import 'package:rent_car_travel/src/screen/history/detail.dart';

class HistoryBooking extends StatefulWidget {
  final String userId;

  const HistoryBooking({Key key, this.userId}) : super(key: key);
  @override
  _HistoryBookingState createState() => _HistoryBookingState();
}
enum HistoryStatus {empty, notEmpty}
HistoryStatus historyStatus ;
Future<List<Booking>> _getHistory(String userId) async {
  final response = await http.post(ApiHttp.urlHistory, body: {
    "user_id": userId,
  });

  final data = jsonDecode(response.body);
  print(data);
  
  return compute(parsePhotos, response.body);
}

List<Booking> parsePhotos(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Booking>((json) => Booking.fromJson(json)).toList();
}

class _HistoryBookingState extends State<HistoryBooking> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 5,
        iconTheme: IconThemeData(color: Colors.blue),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        title: Text(
          'Lịch sử',
          style: TextStyle(color: Colors.blue, fontSize: 18),
        ),
      ),
      body: FutureBuilder(
        future: _getHistory(widget.userId),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Center(child: CupertinoActivityIndicator());
          } else {
            if (snapshot.data.length == 0) {
              return Center(child: Text('Trống'));
            } else {
              return _buildBody(snapshot);
            }
          }
        },
      ),
    );
  }

  Widget _buildBody(AsyncSnapshot snapshot) {
    return ListView.separated(
      itemCount: snapshot.data.length,
      shrinkWrap: true,
      padding: EdgeInsets.all(16),
      separatorBuilder: (context, index) {
        return SizedBox(
          height: 16,
        );
      },
      itemBuilder: (context, index) {
        return _buildItemHistory(context, snapshot, index);
      },
    );
  }
}

Widget _buildItemHistory(
    BuildContext context, AsyncSnapshot snapshot, int index) {
      print(snapshot.data[index].nameUser);
      var data = snapshot.data[index];
  return InkWell(
    onTap: (){
      Navigator.of(context).push(MaterialPageRoute(builder: (builder)=>DetailBooking(booking: data,)));
    },
    child: Container(
      child: Row(
        children: <Widget>[
        _image(data.imageService),
        SizedBox(width: 12,),
        Expanded(child: _info(data.nameService,data.nameVehicle, data.numberOfSeats ,data.dropPoint, data.startDate, data.endDate),),
        _status(data.status)
      ],),
    ),
  );
}
Widget _image(String image){
  return ClipRRect(
    borderRadius: BorderRadius.circular(6),
    child: CachedNetworkImage(imageUrl: image,height: 90, width: 90, fit: BoxFit.cover,),
  );
}
Widget _info(String service,String nameCar, int numberOfSeats ,String route, String timeGoto, String timeReturn){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Text(service,style: TextStyle(color: Color(0xFF737373), fontSize: 14, fontWeight: FontWeight.w500),),
      SizedBox(height: 8,),
      Text('Xe: ' + nameCar + ' - '  + '${numberOfSeats.toInt()} chỗ',style: TextStyle(color: Color(0xFF737373), fontSize: 14,)),
      SizedBox(height: 8,),
      Text('Điểm đến: '+ route,style: TextStyle(color: Color(0xFF737373), fontSize: 14,)),
      SizedBox(height: 8,),
      Text('${timeGoto.toString()} - ${timeReturn.toString()}',style: TextStyle(color: Color(0xFF737373), fontSize: 12,))
    ],
  );
}
Widget _status(int status) {
  TextStyle statusStyle = TextStyle(
      fontWeight: FontWeight.bold,
      color: status == 1 ? Colors.amber : status == 2 ? Colors.blue : status == 3 ? Colors.red : Colors.green);
  return Container(
    width: 60,
    child: Text(
      status == 1 ? 'Chờ xác nhận' : status == 2 ? 'Đã nhận' : status == 3 ? 'Đã hủy': 'Hoàn thành',
      softWrap: true,
      textAlign: TextAlign.center,
      style: statusStyle,
    ),
  );
}