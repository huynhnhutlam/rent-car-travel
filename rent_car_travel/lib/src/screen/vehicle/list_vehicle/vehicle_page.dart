library vehicle_page;

import 'package:flutter/material.dart';
import 'package:rent_car_travel/src/screen/vehicle/list_vehicle/vehicle_banner_list.dart';
import 'package:rent_car_travel/src/screen/vehicle/list_vehicle/vehicle_list.dart';

class VehiclePage extends StatefulWidget {
  @override
  _VehiclePageState createState() => _VehiclePageState();
}

class _VehiclePageState extends State<VehiclePage>
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
        iconTheme: IconThemeData(color: Colors.amber),
        title: Text(
          'Danh sách xe',
          style: TextStyle(
            color: Colors.amber,
            fontSize: 18,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              BannerVehicle(),
              _tabView(),
              _tabBarView(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tabView() {
    return DefaultTabController(
      length: 5,
      child: TabBar(
        tabs: _tabs,
        controller: _tabController,
        labelColor: Colors.green,
        labelStyle: TextStyle(fontSize: 14),
        isScrollable: true,
        unselectedLabelColor: Colors.grey,
        unselectedLabelStyle: TextStyle(fontSize: 12),
        indicatorSize: TabBarIndicatorSize.tab,
      ),
    );
  }

  Widget _tabBarView() {
    return Expanded(
      flex: 1,
      child: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: <Widget>[
          VehicleList(),
          VehicleList(),
          VehicleList(),
          VehicleList(),
          VehicleList()
        ],
      ),
    );
  }

  List<Widget> _tabs = [
    Tab(
      text: 'All',
    ),
    Tab(
      text: 'Phổ biến',
    ),
    Tab(
      text: 'Xe 4 chỗ',
    ),
    Tab(
      text: 'Xe 7 chỗ',
    ),
    Tab(
      text: 'Xe 16 chỗ',
    )
  ];
}
