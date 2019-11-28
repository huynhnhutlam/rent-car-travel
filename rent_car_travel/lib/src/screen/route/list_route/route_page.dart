library route_page;

import 'package:flutter/material.dart';
import 'package:rent_car_travel/src/screen/route/list_route/route_banner_list.dart';
import 'package:rent_car_travel/src/screen/route/list_route/route_list.dart';
import 'package:rent_car_travel/src/screen/vehicle/list_vehicle/vehicle_list.dart';

class RoutePage extends StatefulWidget {
  @override
  _RoutePageState createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 5, initialIndex: 0, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.orange),
        title: Text(
          'Danh sách tuyến đường',
          style: TextStyle(
            color: Colors.orange,
            fontSize: 18,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              BannerRoute(),
              _tabView(),
              _tabBarView(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tabView() {
    return TabBar(
      tabs: _tabs,
      controller: _tabController,
      labelColor: Colors.green,
      labelStyle: TextStyle(fontSize: 14),
      isScrollable: true,
      unselectedLabelColor: Colors.grey,
      unselectedLabelStyle: TextStyle(fontSize: 12),
    );
  }

  Widget _tabBarView() {
    return Flexible(
      flex: 1,
      child: TabBarView(
        controller: _tabController,
        children: <Widget>[
          RouteList(),
          VehicleList(),
          VehicleList(),
          VehicleList(),
          VehicleList(),
        ],
      ),
    );
  }

  List<Widget> _tabs = [
    Tab(
      text: 'All',
    ),
    Tab(
      text: 'Popular Route',
    ),
    Tab(
      text: 'Mới nhất',
    ),
    Tab(
      text: 'Xe 16 chỗ',
    ),
    Tab(
      text: 'Xe 16 chỗ',
    )
  ];
}
