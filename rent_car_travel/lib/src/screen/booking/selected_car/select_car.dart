import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rent_car_travel/src/bloc/place_notifer.dart';
import 'package:rent_car_travel/src/models/vehicle.dart';
import 'package:rent_car_travel/src/screen/booking/detail_booking/detail_booking.dart';

import 'list_car.dart';

class SelectCar extends StatefulWidget {
  final String timeTogo;
  final String timeReturn;

  SelectCar({this.timeTogo, this.timeReturn});

  @override
  _SelectCarState createState() => _SelectCarState();
}

var formatPrice = NumberFormat.currency();

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

class _SelectCarState extends State<SelectCar> {
  Vehicle vehicle;

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.blue),
        title: Text('Chọn xe', style: TextStyle(color: Colors.blue, fontSize: 18),),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _imageCar(
                    image: vehicle == null ? null : vehicle.imageCar,
                    onPressed: () {
                      _waitData(context);
                    }),
                _line(),
                _infoCar(
                    nameCar: vehicle == null ? null : vehicle.nameCar,
                    numberOfSeats:
                        vehicle == null ? null : vehicle.numberOfSeats,
                    price: vehicle == null ? null : vehicle.pricePerKm,
                    distance: vehicle == null ? null : appState.distance),
                _line(),
                _selected(context),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomButton(
        onPressed: () {
          _selectedCar(context);
        },
      ),
    );
  }

  void _showDialogTime(BuildContext context, String contentAlert) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            title: Text('Chọn xe'),
            content: Text(contentAlert),
            actions: <Widget>[
              new FlatButton(
                child: Text('Chọn lại'),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  _selectedCar(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    if (vehicle == null) {
      _showDialogTime(context, 'Vui lòng xe không để trống');
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (builder) => DetailBooking(
            distance: appState.distance,
            dropPoint: appState.destinationController.text,
            pickupPoint: appState.locationController.text,
            timeReturn: widget.timeReturn,
            timeTogo: widget.timeTogo,
            vehicle: vehicle,
            service: 'Đi sân bay',
          ),
        ),
      );
    }
  }

  _waitData(BuildContext context) async {
    final resultData = await Navigator.push(
        context, MaterialPageRoute(builder: (builder) => ListCarSelected()));
    setState(() {
      vehicle = resultData;
    });
  }

  Widget _selected(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Stack(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _selectDate(
                timeTogo: widget.timeTogo, timeReturn: widget.timeReturn),
            _line(),
            _selectRoute(appState.locationController.text, title: 'Điểm đón'),
            _selectRoute(appState.destinationController.text,
                title: 'Điểm đến'),
          ],
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 180,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Colors.black.withOpacity(0.3)),
        )
      ],
    );
  }
}

Widget _infoCar(
    {String nameCar, int numberOfSeats, int price, double distance}) {
  TextStyle titleStyle = TextStyle(
      color: Color(0xFF000000), fontSize: 14, fontWeight: FontWeight.bold);
  TextStyle textStyle = TextStyle(color: Color(0xFF737373), fontSize: 12);
  return Container(
    child: Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
                child: Text(
              'Tên xe: ',
              style: titleStyle,
            )),
            Text(
              nameCar != null ? nameCar : '',
              style: textStyle,
            ),
          ],
        ),
        _line(),
        Row(
          children: <Widget>[
            Expanded(
                child: Text(
              'Loại xe: ',
              style: titleStyle,
            )),
            Text(numberOfSeats != null ? '${numberOfSeats.toInt()} chỗ' : '',
                style: textStyle),
          ],
        ),
        _line(),
        Row(
          children: <Widget>[
            Expanded(
                child: Text(
              'Khoảng cách: ',
              style: titleStyle,
            )),
            Text(price != null ? '${formatter(distance.toDouble())} km' : '',
                style: textStyle),
          ],
        ),
        _line(),
        Row(
          children: <Widget>[
            Expanded(
                child: Text(
              'Giá xe: ',
              style: titleStyle,
            )),
            Text(price != null ? '${(price.toInt())} đ' : '', style: textStyle),
          ],
        )
      ],
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
        Text(
          'Thời gian đi',
          style: titleStyle,
        ),
        Container(
          margin: EdgeInsets.only(top: 8, left: 4),
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
    padding: EdgeInsets.only(top: 12, left: 4, right: 4),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
            margin: EdgeInsets.only(bottom: 8),
            child: Text(title, style: titleStyle)),
        Text(
          text,
          style: textStyle,
        ),
      ],
    ),
    width: double.maxFinite,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(4),
    ),
  );
}

Widget _imageCar({String image, Function onPressed}) {
  return SizedBox(
    height: 200,
    child: image != null
        ? Container(
            decoration: BoxDecoration(
                color: Colors.blueGrey,
                image: image != null
                    ? DecorationImage(
                        image: NetworkImage(image), fit: BoxFit.cover)
                    : null),
          )
        : Container(
            alignment: Alignment.center,
            child: FlatButton(
              onPressed: onPressed,
              child: Text('Chọn Xe'),
            ),
          ),
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
        'Tiếp tục',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
