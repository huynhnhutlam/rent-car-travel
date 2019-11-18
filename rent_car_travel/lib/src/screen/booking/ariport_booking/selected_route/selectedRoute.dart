import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rent_car_travel/src/bloc/place_notifer.dart';
import 'package:rent_car_travel/src/models/place_item.dart';
import 'package:rent_car_travel/src/screen/map/place_picker_page.dart';
import 'package:rent_car_travel/src/screen/widget/title_home.dart';

class SelectRoute extends StatefulWidget {
  final String controllerPickUp;
  final TextEditingController controllerGoto;
  final Function(PlaceItemRes, bool) onSelected;

  SelectRoute(
      {Key key, this.onSelected, this.controllerPickUp, this.controllerGoto})
      : super(key: key);
  @override
  _SelectRouteState createState() => _SelectRouteState();
}

class _SelectRouteState extends State<SelectRoute> {
  static final String _text = airport[0]['nameAirport'];
  final TextEditingController _controllerGoto =
      TextEditingController(text: _text);
  PlaceItemRes fromAddress;
  PlaceItemRes toAddress;
  String _currentLocation = '';
  @override
  void initState() {
    super.initState();
  }

  RouteWay _route = RouteWay.one_way;
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: <Widget>[
          _selectRoutePickUp(
            context,
            _controllerGoto,
            _route,
            fromAddress == null ? widget.controllerPickUp : fromAddress.name,
            onChanged: (route) {
              setState(() {
                _route = route;
              });
            },
            onPressed: _selectedPlace,
          ),
          _selectRoute(context, _controllerGoto, onSubmitted: (value) {
            appState.sendRequest(value);
          }),
          TitleHome(
            text: 'Recommend Route',
          ),
          SizedBox(
            height: 4,
          ),
          _listAirport(
          ),
        ],
      ),
    );
  }

  Widget _selectRoutePickUp(BuildContext context,
      TextEditingController controller, RouteWay routeWay, String route,
      {Function(Object) onChanged, Function onPressed}) {
    return Container(
      margin: EdgeInsets.all(12),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          boxShadow: [BoxShadow(blurRadius: 4, color: Colors.grey)]),
      child: Column(
        children: <Widget>[
          Text(
            'Chọn chuyến đi',
            style: TextStyle(
                color: Color(0xFF737373),
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _selectWay(
                  RouteWay.one_way, routeWay, 'Đưa đến sân bay', onChanged),
              _selectWay(
                  RouteWay.two_way, routeWay, 'Đón từ sân bay', onChanged)
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 8),
            child: _titleInput('Điểm đón', Icons.location_on,
                color: Colors.blueGrey),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: _textRoute(route, onPressed: onPressed),
          )
        ],
      ),
    );
  }

  void _selectedPlace() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PlacePickerPage(
                fromAddress == null ? "" : fromAddress.name, (place, isFrom) {
              widget.onSelected(place, isFrom);

              fromAddress = place;
              setState(() {
               
              });
            }, true)));
  }
  
Widget _listAirport() {
  return Container(
    height: 40,
    child: ListView.builder(
      padding: EdgeInsets.only(left: 16, top: 2, bottom: 3),
      itemCount: airport.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return _itemAirport(
            nameAirport: airport[index]['nameAirport'], onPressed: (){
              setState(() {
                _controllerGoto.text = airport[index]['nameAirport'];
                 Provider.of<AppState>(context).sendRequest(_controllerGoto.text);
              });
            });
      },
    ),
  );
}
}

Widget _selectRoute(BuildContext context, TextEditingController controller,
    {Function(String) onSubmitted}) {
  return Container(
    margin: EdgeInsets.all(12),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [BoxShadow(blurRadius: 4, color: Colors.grey)]),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          child: _titleInput('Điểm đến', Icons.location_on, color: Colors.red),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: _textInputRoute(controller, 'Chọn điểm đến',
              onSubmitted: onSubmitted),
        )
      ],
    ),
  );
}

Widget _titleInput(String title, IconData icon, {Color color}) {
  return Container(
    child: Row(
      children: <Widget>[
        Container(
            margin: EdgeInsets.symmetric(horizontal: 12),
            child: Icon(
              icon,
              size: 18,
              color: color,
            )),
        Text(
          title,
          style: TextStyle(
              color: Colors.blue, fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ],
    ),
  );
}

Widget _textInputRoute(TextEditingController controller, String hintText,
    {Function(String) onSubmitted}) {
  final TextStyle hintStyle = TextStyle(color: Color(0xFFadadad), fontSize: 12);
  return Container(
    child: TextField(
      controller: controller,
      textInputAction: TextInputAction.go,
      onSubmitted: onSubmitted,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: hintStyle,
          focusedBorder: InputBorder.none,
          enabledBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(color: Color.fromRGBO(213, 213, 213, 0.34)))),
    ),
  );
}

Widget _textRoute(String title, {Function onPressed}) {
  final TextStyle hintStyle = TextStyle(color: Color(0xFFadadad), fontSize: 12);
  final TextStyle textStyle = TextStyle(color: Colors.black, fontSize: 14);
  return InkWell(
    onTap: onPressed,
    child: Container(
      height: 30,
      alignment: Alignment.centerLeft,
      width: double.maxFinite,
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: title == 'Chọn điểm đón' ? hintStyle : textStyle,
      ),
    ),
  );
}

Widget _selectWay(RouteWay value, RouteWay routeWay, String titleWay,
    Function(Object) onChanged) {
  final TextStyle styleTitleWay =
      TextStyle(color: Color(0xFF737373), fontSize: 12);
  return Container(
    child: Row(
      children: <Widget>[
        Radio(
          value: value,
          groupValue: routeWay,
          onChanged: onChanged,
        ),
        Text(
          titleWay,
          style: styleTitleWay,
        ),
      ],
    ),
  );
}


Widget _itemAirport({String nameAirport, Function onPressed}) {
  final TextStyle styleAirport =
      TextStyle(color: Colors.blueAccent, fontSize: 14);
  return InkWell(
    onTap: onPressed,
    child: Container(
      margin: EdgeInsets.only(right: 8),
      padding: EdgeInsets.all(8),
      height: 24,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                blurRadius: 4,
                color: Color(0xFFadadad),
                spreadRadius: 0,
                offset: Offset(0, 1))
          ]),
      child: Row(
        children: <Widget>[
          Icon(Icons.airplanemode_active),
          Container(
            margin: EdgeInsets.only(left: 4),
            child: Text(nameAirport, style: styleAirport),
          )
        ],
      ),
    ),
  );
}

List airport = [
  {"nameAirport": "Sân bay nội địa Tân Sơn Nhất", "long": "", "lat": ""},
  {"nameAirport": "Sân bay Cần Thơ", "long": "", "lat": ""},
  {"nameAirport": "Sân bay Cần Thơ", "long": "", "lat": ""},
];
enum RouteWay { one_way, two_way }
