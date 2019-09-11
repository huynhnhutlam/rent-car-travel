import 'package:flutter/material.dart';
import 'package:rent_car_travel/src/models/navigationItem.dart';

class BottomBar extends StatefulWidget {
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _index = 0;
  List<NavigationItem> items = [
    NavigationItem(Icon(Icons.home), Text('Home')),
    NavigationItem(Icon(Icons.person_outline), Text('Profile')),
    NavigationItem(Icon(Icons.settings), Text('Setting')),
  ];
  Widget _buildItem(NavigationItem item, bool isSelected) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 280),
      width: isSelected ? 100 : 50,
      height: double.maxFinite,
      decoration: isSelected
          ? BoxDecoration(
              color: Colors.grey.withOpacity(0.5),
              borderRadius: BorderRadius.circular(20))
          : null,
      child: ListView(
        padding: isSelected ? EdgeInsets.only(left: 10) : null,
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Row(
            mainAxisAlignment:
                isSelected ? MainAxisAlignment.center : MainAxisAlignment.start,
            children: <Widget>[
              IconTheme(
                  data: IconThemeData(
                      size: 24, color: isSelected ? Colors.blue : Colors.black),
                  child: item.icon),
              Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: isSelected
                      ? DefaultTextStyle.merge(
                          style: TextStyle(color: Colors.blue),
                          child: item.title,
                        )
                      : Container())
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: 56,
      width: width,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(blurRadius: 4, color: Colors.black12)]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: items.map((item) {
          var itemIndex = items.indexOf(item);
          return GestureDetector(
              onTap: () {
                setState(() {
                  _index = itemIndex;
                });
              },
              child: _buildItem(item, _index == itemIndex));
        }).toList(),
      ),
    );
  }
}
