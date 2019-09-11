import 'package:flutter/material.dart';
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
          ),
          ListTile(
            leading: Icon(Icons.list),
            title: Text('Vehicle'),
          ),
          ListTile(
            leading: Icon(Icons.list),
            title: Text('Route'),
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Favorite'),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
          ),
        ],
      ),
    );
  }
}
