import 'package:flutter/material.dart';
import 'package:rent_car_travel/src/constants/contants.dart';
import 'package:rent_car_travel/src/screen/side_menu/tabbarSideMenu.dart';

class SideMenu extends StatefulWidget {
  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          child: ListView(
        children: <Widget>[TabbarSideMenu(), MenuItem()],
      )),
    );
  }
}

class MenuItem extends StatefulWidget {
  @override
  _MenuItemState createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: (){
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.list, color: Colors.blueAccent),
            title: Text('Services'),
            onTap: () {
              Navigator.pushNamed(context, Constants.vehicle_list);
            },
          ),
          ListTile(
            leading: Icon(Icons.list, color: Colors.blueAccent),
            title: Text('Vehicle'),
            onTap: () {
              Navigator.pushNamed(context, Constants.vehicle_list);
            },
          ),
          ListTile(
            leading: Icon(Icons.list, color: Colors.blueAccent),
            title: Text('Route'),
            onTap: () {
              Navigator.pushNamed(context, Constants.route_list);
            },
          ),
          ListTile(
            leading: Icon(Icons.favorite, color: Colors.red,),
            title: Text('Favorite'),
            onTap: () {
              Navigator.pushNamed(context, Constants.vehicle_list);
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              Navigator.pushNamed(context, Constants.vehicle_list);
            },
          ),
        ],
      ),
    );
  }
}
