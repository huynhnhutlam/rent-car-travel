import 'package:flutter/material.dart';
import 'package:rent_car_travel/src/screen/home/banner.dart';
import 'package:rent_car_travel/src/screen/home/newest_vehicle.dart';
import 'package:rent_car_travel/src/screen/home/popular_route.dart';
import 'package:rent_car_travel/src/screen/home/popular_vehicle.dart';
import 'package:rent_car_travel/src/screen/home/service_recommend.dart';
import 'package:rent_car_travel/src/screen/side_menu/side_menu.dart';
import 'package:rent_car_travel/src/screen/widget/bottomBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Builder(
          builder: (context) => SideMenu(),
        ),
      ),
      appBar: AppBar(
        title: Text('HOME'),
      ),
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                //banner
                BannerHome(),
                Container(
                  height: 30,
                ),
                //NewestCar
                NewestCar(),
                ServiceRecommend(),
                //Popular Vehicle
                Container(
                  height: 30,
                ),
                PopularVehicle(),
                Container(
                  height: 30,
                ),
                //Popular Route
                PopularRoute(),
                //Select Service
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
