import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rent_car_travel/src/bloc/place_notifer.dart';
import 'package:rent_car_travel/src/models/services.dart';
import 'package:rent_car_travel/src/screen/booking/selected_car/select_car.dart';
import 'package:intl/intl.dart';

class SelectDatePage extends StatefulWidget {
  final Service service;

  const SelectDatePage({Key key, this.service}) : super(key: key);
  @override
  _SelectDatePageState createState() => _SelectDatePageState();
}

class _SelectDatePageState extends State<SelectDatePage> {
  DateTime _now = new DateTime.now();
  DateTime _date = new DateTime.now();
  DateTime _dateReturn = new DateTime.now();
  DateTime pickedGoto;
  DateTime pickReturn;

  Future<void> _selectedDate(BuildContext context) async {
    pickedGoto = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(2018, 8),
        lastDate: DateTime(2100));
    if (pickedGoto != null && pickedGoto != _date) {
      setState(() {
        if (pickedGoto.isBefore(_now)) {
          _showDialogTime(
              context, 'Thời gian đi không được nhỏ hơn thời gian hiện tại');
        } else {
          _date = pickedGoto;
        }
      });
    }
  }

  void _showDialogTime(BuildContext context, String contentAlert) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Chọn sai thời gian'),
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

  Future<void> _selectedDateReturn(BuildContext context) async {
    pickReturn = await showDatePicker(
        context: context,
        initialDate: _dateReturn,
        firstDate: DateTime(2018, 8),
        lastDate: DateTime(2100));
    if (pickReturn != null && pickReturn != _now) {
      setState(() {
        if (pickReturn.isBefore(_date)) {
          _showDialogTime(
              context, 'Thời gian về không được chọn nhỏ hơn thời gian đi');
        } else {
          _dateReturn = pickReturn;
        }
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.blue),
        title: Text('Chọn ngày', style: TextStyle(color: Colors.blue),),
      ),
      body: Container(
        child: _buildBody(
          appState.locationController.text,
          appState.destinationController.text
        ),
      ),
      bottomNavigationBar: Container(
        height: 56,
        padding: EdgeInsets.all(16),
        child: RaisedButton(
          color: Colors.blueAccent,
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (builder) => SelectCar(
              timeTogo: DateFormat.d().format(_date) +
                  '/' +
                  DateFormat.M().format(_date) +
                  '/' +
                  DateFormat.y().format(_date) /*+ ' - ' + DateFormat.Hm().format(_date)*/,
              timeReturn: DateFormat.d().format(_dateReturn) +
                  '/' +
                  DateFormat.M().format(_dateReturn) +
                  '/' +
                  DateFormat.y().format(_dateReturn)/*+ ' - ' + DateFormat.Hm().format(_dateReturn)*/,
                  service: widget.service,
            )));
          },
          child: Text(
            'Next',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
  Widget _buildBody(String pickupPoint, String dropPoint){
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 12),
            child: InputDropdown(
              valueText: DateFormat.d().format(_date) +
                  '/' +
                  DateFormat.M().format(_date) +
                  '/' +
                  DateFormat.y().format(_date),
              onPressed: () {
                _selectedDate(context);
              },
              valueStyle: TextStyle(color: Color(0xFF737373), fontSize: 14),
              timePicker: 'Thời gian đi',
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 12),
            child: InputDropdown(
              valueText: DateFormat.d().format(_dateReturn) +
                  '/' +
                  DateFormat.M().format(_dateReturn) +
                  '/' +
                  DateFormat.y().format(_dateReturn),
              onPressed: () {
                _selectedDateReturn(context);
              },
              valueStyle: TextStyle(color: Color(0xFF737373), fontSize: 14),
              timePicker: 'Thời gian về',
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 12),
            alignment: Alignment.centerLeft,
            child: Text('Tuyến đường đã chọn',
                style: TextStyle(
                  color: Color(0xFF737373),
                  fontWeight: FontWeight.bold,
                )),
          ),
          Container(
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(bottom: 12),
                        child: _infoSelected(pickupPoint,
                            title: 'Điểm đón')),
                    _infoSelected(dropPoint, title: 'Điểm đến'),
                  ],
                ),
                Container(
                  height: 136,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.black.withOpacity(0.2),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _infoSelected(String text, {String title = ''}) {
  TextStyle titleStyle = TextStyle(
      color: Color(0xFF000000), fontSize: 14, fontWeight: FontWeight.bold);
  TextStyle textStyle = TextStyle(color: Color(0xFF737373), fontSize: 12);
  return Container(
    padding: EdgeInsets.all(12),
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

class InputDropdown extends StatelessWidget {
  const InputDropdown(
      {Key key,
        this.child,
        this.labelText,
        this.valueText,
        this.valueStyle,
        this.onPressed,
        this.timePicker})
      : super(key: key);

  final String labelText;
  final String valueText;
  final TextStyle valueStyle;
  final VoidCallback onPressed;
  final Widget child;
  final String timePicker;

  @override
  Widget build(BuildContext context) {
    TextStyle styleTitle = TextStyle(color: Colors.blue);
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  blurRadius: 4,
                  color: Colors.black.withOpacity(0.6),
                  offset: Offset(0, 1),
                  spreadRadius: 0)
            ]),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Icon(
                      Icons.access_time,
                      size: 14,
                      color: Colors.blue,
                    )),
                Text(
                  timePicker,
                  style: TextStyle(color: Colors.blue, fontSize: 16),
                ),
              ],
            ),
            InputDecorator(
              decoration: InputDecoration(
                labelText: labelText,
              ),
              baseStyle: styleTitle,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(valueText, style: valueStyle),
                  Icon(
                    Icons.arrow_drop_down,
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.blue.shade700
                        : Colors.white70,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
