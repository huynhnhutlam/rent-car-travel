import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rent_car_travel/src/constants/api_http.dart';
import 'package:rent_car_travel/src/constants/contants.dart';
import 'package:rent_car_travel/src/models/services.dart';
import 'package:rent_car_travel/src/models/vehicle.dart';
import 'package:rent_car_travel/src/screen/home/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

String currencyFormatter(int n) {
  final formatter = new NumberFormat.currency(
    locale: 'vi',
    decimalDigits: 0,
    symbol: "",
  );
  return formatter.format(n);
}

String formatter(double n) {
  final f = new NumberFormat('###.#', 'vi');
  return f.format(n);
}

class DetailBooking extends StatefulWidget {
  final Vehicle vehicle;
  final String timeTogo;
  final String timeReturn;
  final String pickupPoint;
  final String dropPoint;
  final double distance;
  final Service service;

  @override
  _DetailBookingState createState() => _DetailBookingState();

  DetailBooking(
      {this.vehicle,
      this.timeTogo,
      this.timeReturn,
      this.pickupPoint,
      this.dropPoint,
      this.distance,
      this.service});
}

class _DetailBookingState extends State<DetailBooking> {
  TextEditingController _controller = TextEditingController();
  String name = '', phone = '', id = '';

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      phone = preferences.getString("phone");
      name = preferences.getString("name");
      id = preferences.getString("id");
    });
  }

  _booking() async {
    final response = await http.post(ApiHttp.urlBooking, body: {
      "user_id": id,
      "vehicle_id": '${widget.vehicle.id}',
      "start_date_booking": widget.timeTogo,
      "end_date_booking":
          widget.timeReturn == null ? widget.timeTogo : widget.timeReturn,
      "pick_up_point": widget.pickupPoint,
      "drop_point": widget.dropPoint,
      "service_id": '${widget.service.id}',
      "driver_id": '1',
      "note": _controller.text,
      "price": '${widget.vehicle.pricePerKm * widget.distance.toInt()}',
    });
    final data = jsonDecode(response.body);
    if (data['value'] == 200) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Thông báo"),
            content: Text('Đặt xe thành công. Về trang chủ.'),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (builder) => HomePage()),
                      (Route<dynamic> route) => false);
                },
                child: Text('Xác nhận'),
              )
            ],
          );
        },
      );
    }
  }

  _check() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Thông báo"),
            content: Text('Bạn có muốn đặt xe!!.'),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Quay lại'),
              ),
              FlatButton(
                onPressed: () {
                  new Future.delayed(new Duration(seconds: 3), () {
                    //pop dialog
                    _booking();
                    Navigator.pop(context);
                  });
                },
                child: Text('Xác nhận'),
              ),
            ],
          );
        });
  }

  @override
  void initState() {
    getPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.blue),
        title: Text(
          'Xác nhận',
          style: TextStyle(color: Colors.blue, fontSize: 18),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Container(
        child: GestureDetector(
          onTap: () {},
          child: _buildBody(),
        ),
      ),
      bottomNavigationBar: Container(
        child: _buildBottomButton(onPressed: () {
          _check();
        }),
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
        child: Column(
      children: <Widget>[
        _selected(controller: _controller),
      ],
    ));
  }

  Widget _selected({TextEditingController controller}) {
    TextStyle titleStyle = TextStyle(
        color: Color(0xFF000000), fontSize: 14, fontWeight: FontWeight.bold);
    int price = widget.vehicle.pricePerKm * widget.distance.toInt();
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: [
          BoxShadow(spreadRadius: 0, blurRadius: 4, color: Colors.black)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _selectCar(
              nameCar: widget.vehicle.nameCar,
              numberOfSeats: widget.vehicle.numberOfSeats,
              service: widget.service.nameService,
              image: widget.vehicle.imageCar),
          _line(),
          _info(name, title: 'Tên khách hàng'),
          _line(),
          _info(phone, title: 'Số điện thoại'),
          _line(),
          _distance(widget.distance),
          _line(),
          _price(price: price),
          _line(),
          _selectDate(timeTogo: widget.timeTogo, timeReturn: widget.timeReturn),
          _line(),
          _selectRoute(widget.pickupPoint, title: 'Điểm đón'),
          _selectRoute(widget.dropPoint, title: 'Điểm đến'),
          _line(),
          Row(
            children: <Widget>[
              Icon(
                Icons.edit,
                size: 16,
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: Text(
                  'Ghi chú',
                  style: titleStyle,
                ),
              )
            ],
          ),
          _inputNote(controller)
        ],
      ),
    );
  }
}

Widget _info(String text, {String title}) {
  TextStyle titleStyle = TextStyle(
      color: Color(0xFF000000), fontSize: 14, fontWeight: FontWeight.bold);
  TextStyle textStyle = TextStyle(color: Color(0xFF737373), fontSize: 12);
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(
              Icons.directions,
              size: 16,
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              title,
              style: titleStyle,
            ),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Container(
            margin: EdgeInsets.only(left: 8),
            child: Text(
              text,
              style: textStyle,
            ))
      ],
    ),
  );
}

Widget _price({int price}) {
  TextStyle titleStyle = TextStyle(
      color: Color(0xFF000000), fontSize: 14, fontWeight: FontWeight.bold);
  TextStyle textStyle = TextStyle(color: Color(0xFF737373), fontSize: 12);
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(
              Icons.monetization_on,
              size: 16,
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              'Giá xe',
              style: titleStyle,
            ),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Container(
            margin: EdgeInsets.only(left: 8),
            child: Text(
              '${currencyFormatter(price)}',
              style: textStyle,
            ))
      ],
    ),
  );
}

Widget _distance(double distance) {
  TextStyle titleStyle = TextStyle(
      color: Color(0xFF000000), fontSize: 14, fontWeight: FontWeight.bold);
  TextStyle textStyle = TextStyle(color: Color(0xFF737373), fontSize: 12);
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(
              Icons.directions,
              size: 16,
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              'Khoảng cách',
              style: titleStyle,
            ),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Container(
            margin: EdgeInsets.only(left: 8),
            child: Text(
              '${formatter(distance)} km',
              style: textStyle,
            ))
      ],
    ),
  );
}

Widget _selectCar(
    {String nameCar, int numberOfSeats, String service, String image}) {
  TextStyle titleStyle = TextStyle(
      color: Color(0xFF000000), fontSize: 14, fontWeight: FontWeight.bold);
  TextStyle textStyle = TextStyle(color: Color(0xFF737373), fontSize: 14);
  TextStyle serviceStyle = TextStyle(
      color: Color(0xFF000000), fontSize: 16, fontWeight: FontWeight.bold);
  TextStyle textServiceStyle =
      TextStyle(color: Color(0xFF3eb2ec), fontSize: 16);

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Align(
          alignment: Alignment.center,
          child: Text(
            'Dịch vụ đã chọn',
            style: serviceStyle,
          )),
      SizedBox(
        height: 8,
      ),
      Align(
          alignment: Alignment.center,
          child: Text(
            service,
            style: textServiceStyle,
          )),
      SizedBox(
        height: 8,
      ),
      Row(
        children: <Widget>[
          Icon(
            Icons.directions_car,
            size: 16,
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: Text(
              'Xe đã chọn',
              style: titleStyle,
            ),
          ),
        ],
      ),
      Container(
        child: Row(
          children: <Widget>[
            _image(image: image),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    nameCar,
                    style: textStyle,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    '${numberOfSeats.toInt()} chỗ',
                    style: textStyle,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ],
  );
}

Widget _inputNote(TextEditingController controller) {
  return Container(
    margin: EdgeInsets.only(top: 12),
    color: Colors.grey[200],
    child: TextField(
      controller: controller,
      maxLines: 4,
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(), border: OutlineInputBorder()),
    ),
  );
}

Widget _line() {
  return Container(
    height: 1,
    margin: EdgeInsets.symmetric(vertical: 12),
    color: Color.fromRGBO(213, 213, 213, 0.34),
  );
}

Widget _selectDate({String timeTogo, String timeReturn}) {
  TextStyle titleStyle = TextStyle(
      color: Color(0xFF000000), fontSize: 14, fontWeight: FontWeight.bold);
  TextStyle textStyle = TextStyle(color: Color(0xFF737373), fontSize: 12);
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(
              Icons.calendar_today,
              size: 16,
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              'Thời gian đi',
              style: titleStyle,
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.only(top: 8, left: 8),
          child: RichText(
            text: TextSpan(style: textStyle, children: <TextSpan>[
              TextSpan(text: 'Từ '),
              TextSpan(
                  text: '${timeTogo.toString()}',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: timeReturn != null ? ' đến ' : ''),
              TextSpan(
                  text: timeReturn != null ? '${timeReturn.toString()}' : '',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ]),
          ),
        ),
      ],
    ),
  );
}

Widget _selectRoute(String text, {String title = ''}) {
  TextStyle titleStyle = TextStyle(
      color: Color(0xFF000000), fontSize: 14, fontWeight: FontWeight.bold);
  TextStyle textStyle = TextStyle(color: Color(0xFF737373), fontSize: 12);
  return Container(
    padding: EdgeInsets.only(top: 12, right: 4),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 8),
          child: Row(
            children: <Widget>[
              Icon(
                Icons.location_searching,
                size: 16,
              ),
              SizedBox(
                width: 8,
              ),
              Container(child: Text(title, style: titleStyle)),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 8),
          child: Text(
            text,
            style: textStyle,
          ),
        ),
      ],
    ),
    width: double.maxFinite,
  );
}

Widget _image({String image}) {
  return Container(
    width: 40,
    height: 40,
    margin: EdgeInsets.only(right: 12),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        image: image != null
            ? DecorationImage(image: NetworkImage(image), fit: BoxFit.fill)
            : null),
  );
}

Widget _buildBottomButton({Function onPressed}) {
  return Container(
    height: 56,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(14),
        topRight: Radius.circular(14),
      ),
      boxShadow: [
        BoxShadow(blurRadius: 4, color: Colors.grey, spreadRadius: 0),
      ],
    ),
    padding: EdgeInsets.all(12),
    child: MaterialButton(
      elevation: 5,
      onPressed: onPressed,
      color: Colors.blueAccent,
      child: Text(
        'Đặt xe',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
