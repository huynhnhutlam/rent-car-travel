import 'package:flutter/material.dart';
import 'package:rent_car_travel/src/models/vehicle.dart';

Color colorText = Color(0xFF737373);
double sizeText = 14;

class Detail extends StatelessWidget {
  const Detail({
    Key key,
    @required this.data,
  }) : super(key: key);

  final Vehicle data;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.all(16),
        children: <Widget>[
          _textTitle('Detail'),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8,vertical: 12),
            child: _rowDetail(),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            margin: EdgeInsets.only(bottom: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: 12),
                    child: _detailInfo('${data.mode}', 'Mode: ',
                        icon: Icon(Icons.description, size: 18),
                        style: TextStyle(color: colorText, fontSize: sizeText)),
                  ),
                ),
                Expanded(
                  child: _detailInfo(
                    data.status == 0
                        ? 'Open'
                        : data.status == 1 ? 'Closed' : 'Busy',
                    'Status: ',
                    style: TextStyle(
                        color: data.status == 0
                            ? Colors.green
                            : data.status == 1 ? Colors.red: Colors.amber,
                        fontSize: sizeText),
                    icon: Icon(Icons.help_outline, size: 18),
                  ),
                ),
              ],
            ),
          ),
          line(),
          Padding(
            padding: EdgeInsets.fromLTRB(0,8,0,8),
            child: _description(context,data.description),
          ),
          line(),
          Padding(
            padding: EdgeInsets.fromLTRB(0,8,0,8),
            child: _textTitle('Recommendation'),
          ),
        ],
      ),
    );
  }

  Widget _rowDetail() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: Container(
            margin: EdgeInsets.only(right: 12),
            child: _detailInfo('${data.numberOfSeats.toInt()}', 'Seats: ',
                icon: Icon(Icons.airline_seat_recline_extra, size: 18),
                style: TextStyle(color: colorText, fontSize: sizeText)),
          ),
        ),
        Expanded(
          child: _detailInfo(
            '${data.licensePlates}',
            'Lincense: ',
            style: TextStyle(color: colorText, fontSize: sizeText),
            icon: Icon(Icons.format_line_spacing, size: 18),
          ),
        ),
      ],
    );
  }
}

Widget _description(BuildContext context, String description) {
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _textTitle('Description'),
        Container(
          padding: EdgeInsets.all(10),
          child: Text(
              '''${description.toString()}'''),
        )
      ],
    ),
  );
}

Widget _textTitle(String title) {
  return Text(
    title,
    style: TextStyle(
      color: Color(0xFF737373),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    ),
  );
}

Widget _detailInfo(String text, String title, {Icon icon, TextStyle style}) {
  final decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(5.0),
      color: Colors.white,
      boxShadow: [BoxShadow(blurRadius: 4, color: Colors.black26)]);
  return Container(
    height: 75,
    padding: EdgeInsets.all(10),
    decoration: decoration,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(margin: EdgeInsets.only(right: 10), child: icon),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
                padding: EdgeInsets.only(top: 5),
                child: Text(
                  text,
                  style: style,
                )),
          ],
        ),
      ],
    ),
  );
}

Widget line() {
  return Container(
    height: 2,
    color: Colors.grey.withOpacity(0.5),
  );
}
