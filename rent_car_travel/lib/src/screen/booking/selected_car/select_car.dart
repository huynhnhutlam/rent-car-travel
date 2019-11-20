import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rent_car_travel/src/bloc/place_notifer.dart';

class SelectCar extends StatefulWidget {
  final String timeTogo;
  final String timeReturn;

  SelectCar({this.timeTogo, this.timeReturn});

  @override
  _SelectCarState createState() => _SelectCarState();
}
var formatPrice = NumberFormat.currency();
class _SelectCarState extends State<SelectCar> {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    int price = appState.distance.toInt() * 30000;
    return Scaffold(
      appBar: AppBar(
        title: Text('Chọn xe'),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _imageCar(image: AssetImage('lib/res/images/bg.jpg')),
                _line(),
                _infoCar(nameCar: 'Mazda 5', numberOfSeats: 7, price: price),
                _line(),
                _selected(context)
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomButton(
        onPressed: () {

        },
      ),
    );
  }

  Widget _selected(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Stack(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _selectDate(widget.timeTogo, widget.timeReturn),
            _line(),
            _selectRoute(appState.locationController.text, title: 'Điểm đón'),
            _selectRoute(appState.destinationController.text, title: 'Điểm đến'),
          ],
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.black.withOpacity(0.3)
          ),
        )
      ],
    );
  }
}

Widget _infoCar({String nameCar, int numberOfSeats, int price}) {
  TextStyle titleStyle = TextStyle(
      color: Color(0xFF000000), fontSize: 14, fontWeight: FontWeight.bold);
  TextStyle textStyle = TextStyle(color: Color(0xFF737373), fontSize: 12);
  return Container(
    child: Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(child: Text('Tên xe: ', style: titleStyle,)),
            Text(nameCar, style: textStyle,),
          ],
        ),
        _line(),
        Row(
          children: <Widget>[
            Expanded(child: Text('Loại xe: ', style: titleStyle,)),
            Text('${numberOfSeats.toInt()} chỗ', style: textStyle),
          ],
        ),
        _line(),
        Row(
          children: <Widget>[
            Expanded(child: Text('Giá xe: ', style: titleStyle,)),
            Text('${price.toInt()} đ', style: textStyle),
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

Widget _selectDate(String timeTogo, String timeReturn) {
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

Widget _imageCar({ImageProvider<dynamic> image}) {
  return SizedBox(
    height: 200,
    child: image != null
        ? Container(
            decoration: BoxDecoration(
                color: Colors.blueGrey,
                image: image != null
                    ? DecorationImage(image: image, fit: BoxFit.cover)
                    : null),
          )
        : Container(
            child: FlatButton(
              onPressed: () {},
              child: Text('Chọn'),
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
        'Next',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
