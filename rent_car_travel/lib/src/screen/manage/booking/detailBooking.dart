import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rent_car_travel/src/constants/api_http.dart';
import 'package:rent_car_travel/src/models/booking/booking.dart';
import 'package:http/http.dart' as http;
import 'package:rent_car_travel/src/screen/manage/home/home.dart';

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

class ConfirmBooking extends StatefulWidget {
  final Booking booking;

  const ConfirmBooking({Key key, this.booking}) : super(key: key);
  @override
  _ConfirmBookingState createState() => _ConfirmBookingState();
}

class _ConfirmBookingState extends State<ConfirmBooking> {
  TextEditingController _controller = TextEditingController();

  _confirm() async {
    final response = await http.post(ApiHttp.urlConfirm, body: {
      "id": '${widget.booking.id}',
      "status_vehicle": '2',
      "status_booking": '2'
    });
    final data = jsonDecode(response.body);
    if (data['value'] == 200) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Thông báo"),
            content: Text('Thành công. Về trang chủ'),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (builder) => HomPageManage()),
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

  _cancel() async {
    final response = await http.post(ApiHttp.urlConfirm, body: {
      "id": '${widget.booking.id}',
      "status_vehicle": '1',
      "status_booking": '3'
    });
    final data = jsonDecode(response.body);
    if (data['value'] == 200) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Thông báo"),
            content: Text('Thành công. Về trang chủ'),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (builder) => HomPageManage()),
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

  _completed() async {
    final response = await http.post(ApiHttp.urlConfirm, body: {
      "id": '${widget.booking.id}',
      "status_vehicle": '1',
      "status_booking": '4'
    });
    final data = jsonDecode(response.body);
    if (data['value'] == 200) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Thông báo"),
            content: Text('Thành công. Về trang chủ'),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (builder) => HomPageManage()),
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

  _check(String title, {Function onPressed}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: <Widget>[
                Icon(Icons.check, color: Colors.green, size: 24),
                SizedBox(width: 4),
                Text("Thông báo"),
              ],
            ),
            content: Text(title),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Quay lại'),
              ),
              FlatButton(
                onPressed: onPressed,
                child: Text('Xác nhận'),
              ),
            ],
          );
        });
  }

  _cancelBooking(String title, {Function onPressed}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: <Widget>[
                Icon(Icons.warning, color: Colors.red, size: 24),
                SizedBox(
                  width: 4,
                ),
                Text("Thông báo"),
              ],
            ),
            content: Text(title),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Quay lại'),
              ),
              FlatButton(
                onPressed: onPressed,
                child: Text('Xác nhận'),
              ),
            ],
          );
        });
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
          'Xác nhận',
          style: TextStyle(color: Colors.blue, fontSize: 18),
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
        child: Column(
      children: <Widget>[
        _selected(),
        Center(
          child: widget.booking.status == 1
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    _buildButtonCancel(onPressed: () {
                      _cancelBooking('Xác nhận hủy chuyến xe của khách hàng!!.',
                          onPressed: () {
                        new Future.delayed(new Duration(seconds: 3), () {
                          //pop dialog
                          _cancel();
                          Navigator.pop(context);
                        });
                      });
                    }),
                    _buildButtonConfirm(onPressed: () {
                      _check('Xác nhận chuyến xe đến khách hàng!!.',
                          onPressed: () {
                        new Future.delayed(new Duration(seconds: 3), () {
                          //pop dialog
                          _confirm();
                          Navigator.pop(context);
                        });
                      });
                    }),
                  ],
                )
              : widget.booking.status == 2
                  ? _buildButtonCompleted(onPressed: () {
                      _check('Hoàn thành chuyến xe cho khách hàng!!.',
                          onPressed: () {
                        new Future.delayed(new Duration(seconds: 3), () {
                          //pop dialog
                          _completed();
                          Navigator.pop(context);
                        });
                      });
                    })
                  : _buildButtonBack(onPressed: () {
                      Navigator.pop(context);
                    }),
        )
      ],
    ));
  }

  Widget _selected() {
    TextStyle titleStyle = TextStyle(
        color: Color(0xFF000000), fontSize: 14, fontWeight: FontWeight.bold);

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
              service: widget.booking.nameService,
              image: widget.booking.imageService,
              nameCar: widget.booking.nameVehicle,
              numberOfSeats: widget.booking.numberOfSeats),
          _line(),
          _info(widget.booking.nameUser, title: 'Tên khách hàng'),
          _line(),
          _info(widget.booking.phone, title: 'Số điện thoại'),
          _line(),
          _selectDate(
              timeTogo: widget.booking.startDate,
              timeReturn: widget.booking.endDate),
          _line(),
          _selectRoute(widget.booking.pickUpPoint, title: 'Điểm đón'),
          _line(),
          _selectRoute(widget.booking.dropPoint, title: 'Điểm đến'),
          _line(),
          _price(price: widget.booking.price),
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
          _inputNote(widget.booking.note),
          _line(),
          _status(
            widget.booking.status,
            title: 'Trạng thái',
          )
        ],
      ),
    );
  }
}

Widget _status(int status, {String title}) {
  TextStyle titleStyle = TextStyle(
      color: Color(0xFF000000), fontSize: 14, fontWeight: FontWeight.bold);
  TextStyle textStyle = TextStyle(
      color: status == 1
          ? Colors.amber
          : status == 2 ? Colors.blue : status == 3 ? Colors.red : Colors.green,
      fontSize: 12,
      fontWeight: FontWeight.bold);
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
              status == 1
                  ? 'Chờ xác nhận'
                  : status == 2
                      ? 'Đã nhận'
                      : status == 3 ? 'Đã hủy' : 'Hoàn thành',
              style: textStyle,
            ))
      ],
    ),
  );
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
            _image(image: image != null ? image : null),
            Expanded(
              child: Text(
                nameCar + ' - ' + '${numberOfSeats.toInt()} chỗ',
                style: textStyle,
              ),
            )
          ],
        ),
      ),
    ],
  );
}

Widget _inputNote(String note) {
  TextStyle textStyle = TextStyle(color: Color(0xFF737373), fontSize: 12);
  return Container(
      margin: EdgeInsets.only(top: 12),
      color: Colors.grey[200],
      child: Text(note, maxLines: 4, style: textStyle));
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

Widget _buildButtonConfirm({Function onPressed}) {
  return Container(
    height: 64,
    padding: EdgeInsets.all(12),
    width: 150,
    child: MaterialButton(
      elevation: 5,
      onPressed: onPressed,
      color: Colors.blueAccent,
      child: Text(
        'Xác nhận',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

Widget _buildButtonCompleted({Function onPressed}) {
  return Container(
    height: 64,
    padding: EdgeInsets.all(12),
    width: 200,
    child: MaterialButton(
      elevation: 5,
      onPressed: onPressed,
      color: Colors.green,
      child: Text(
        'Hoàn thành',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

Widget _buildButtonBack({Function onPressed}) {
  return Container(
    height: 64,
    padding: EdgeInsets.all(12),
    width: 200,
    child: MaterialButton(
      elevation: 5,
      onPressed: onPressed,
      color: Colors.grey,
      child: Text(
        'Quay về',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

Widget _buildButtonCancel({Function onPressed}) {
  return Container(
    height: 64,
    padding: EdgeInsets.all(12),
    width: 150,
    child: MaterialButton(
      elevation: 5,
      onPressed: onPressed,
      color: Colors.red,
      child: Text(
        'Hủy',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
