import 'package:flutter/material.dart';
import 'package:rent_car_travel/src/models/place_item.dart';
import 'package:rent_car_travel/src/screen/map/place_picker_page.dart';
import 'package:rent_car_travel/src/screen/widget/title_home.dart';

class SelectRoute extends StatefulWidget {
  final Function(PlaceItemRes, bool) onSelected;

  SelectRoute({Key key, this.onSelected}) : super(key: key);

  @override
  _SelectRouteState createState() => _SelectRouteState();
}

class _SelectRouteState extends State<SelectRoute> {
  PlaceItemRes fromAddress;
  PlaceItemRes toAddress;
  static int _count = 1;
  List<TextEditingController> _controller = new List(100);
  @override
  void initState() {
    super.initState();
    print(fromAddress);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _selectedPickUp(
              fromAddress == null ? "Chọn điểm đón" : fromAddress.name,
              _selectedPickUpPlace),
          _selectedPickUp(toAddress == null ? "Chọn điểm đến" : toAddress.name,
              _selectedPlace, text: 'Điểm đến'),
          _selectStopPoint(context, _controller, _count),
          TitleHome(
            text: 'Recommend Route',
            onTap: _selectedPlace,
          ),
        ],
      ),
    );
  }

  Widget _selectStopPoint(BuildContext context,
      List<TextEditingController> controller, int _count) {
    List<Widget> _contatos = new List.generate(
        _count,
        (_count) => _textInputRoute(controller[_count], 'Thêm tuyến ngoài',
            icon: _icon()));

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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _titleInput('Điểm dừng', Icons.location_on, color: Colors.grey),
                InkWell(
                  onTap: _addNewStopPoint,
                  child: Text(
                    '+ Thêm điểm mới',
                    style: TextStyle(
                        fontSize: 10,
                        color: Colors.blueAccent,
                        fontStyle: FontStyle.italic),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: ListView(
              shrinkWrap: true,
              children: _contatos,
            ),
          )
        ],
      ),
    );
  }

  Widget _icon() {
    return InkWell(
      onTap: _removeStopPoint,
      child: Icon(
        Icons.remove_circle_outline,
        size: 18,
        color: Colors.red,
      ),
    );
  }

  Widget _selectedPickUp(String title, Function onPressed,{String text = 'Điểm đón'}) {
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
            child: _titleInput(text, Icons.location_on,color:text == 'Điểm đón' ? Colors.grey: Colors.redAccent),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: _textRoute(title, onPressed: onPressed),
          )
        ],
      ),
    );
  }

  Widget _textRoute(String title, {Function onPressed}) {
    final TextStyle hintStyle =
        TextStyle(color: Color(0xFFadadad), fontSize: 12);
    final TextStyle textStyle = TextStyle(color: Colors.black, fontSize: 14);
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 30,
        alignment: Alignment.centerLeft,
        width: double.maxFinite,
        child: Text(
          title,
          textAlign: TextAlign.start,
          style: title == 'Chọn điểm đón' ? hintStyle : title == 'Chọn điểm đến' ? hintStyle: textStyle,
        ),
      ),
    );
  }

  void _selectedPickUpPlace() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PlacePickerPage(
                fromAddress == null ? "" : fromAddress.name, (place, isFrom) {
              widget.onSelected(place, isFrom);
              fromAddress = place;
              setState(() {});
            }, true)));
  }

  void _selectedPlace() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PlacePickerPage(
                toAddress == null ? "" : toAddress.name, (place, isFrom) {
              widget.onSelected(place, isFrom);
              toAddress = place;
              setState(() {});
            }, false)));
  }

  void _addNewStopPoint() {
    setState(() {
      _count = _count + 1;
    });
  }

  void _removeStopPoint() {
    setState(() {
      _count = _count - 1;
    });
  }
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
    {Widget icon}) {
  final TextStyle hintStyle = TextStyle(color: Color(0xFFadadad), fontSize: 12);
  return Container(
    child: TextField(
      controller: controller,
      textInputAction: TextInputAction.go,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: hintStyle,
        suffixIcon: icon,
        focusedBorder: InputBorder.none,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromRGBO(213, 213, 213, 0.34),
          ),
        ),
      ),
    ),
  );
}