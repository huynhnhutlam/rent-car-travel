import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SelectedDate extends StatefulWidget {
  @override
  _SelectedDateState createState() => _SelectedDateState();
}

class _SelectedDateState extends State<SelectedDate> {
  DateTime _date = new DateTime.now();

  Future<DateTime> _selectedDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(2018, 8),
        lastDate: DateTime(2100));
    if (picked != null && picked != _date) {
      setState(() {
        _date = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(12),
            child: _InputDropdown(
              labelText: 'Select Date to go',
              valueText: DateFormat.yMMMd().format(_date),
              onPressed: () {
                _selectedDate(context);
              },
              valueStyle: TextStyle(color: Colors.blue),
              timePicker: 'Time to go',
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12),
            child: _InputDropdown(
              labelText: 'Select Date of return',
              valueText: DateFormat.yMMMd().format(_date),
              onPressed: () {
                _selectedDate(context);
              },
              valueStyle: TextStyle(color: Colors.blue),
              timePicker: 'Time return',
            ),
          ),
        ],
      ),
    );
  }
}

class _InputDropdown extends StatelessWidget {
  const _InputDropdown(
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
                      size: 18,
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
              baseStyle: valueStyle,

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
