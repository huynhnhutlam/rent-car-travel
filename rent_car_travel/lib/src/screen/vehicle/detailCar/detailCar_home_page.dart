import 'package:flutter/material.dart';
import 'package:rent_car_travel/src/constants/api_http.dart';
import 'package:rent_car_travel/src/models/vehicle.dart';
import 'package:rent_car_travel/src/screen/vehicle/detailCar/review_car.dart';

import 'detailCar.dart';

class DetailCar extends StatefulWidget {
  final Vehicle vehicle;

  const DetailCar({Key key, this.vehicle}) : super(key: key);

  @override
  _DetailCarState createState() => _DetailCarState();
}

class _DetailCarState extends State<DetailCar>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  bool isLike = false;
  @override
  void initState() {
    _tabController = TabController(length: 2, initialIndex: 0, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var data = widget.vehicle;
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                child: SliverAppBar(
                  forceElevated: true,
                  expandedHeight: 250.0,
                  floating: false,
                  pinned: true,
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.white,
                  title: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.amber,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 16),
                          height: 35,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 4,
                                    offset: Offset(0, 1),
                                    color: Colors.grey)
                              ]),
                          child: IconButton(
                            icon: Icon(
                              Icons.favorite,
                              color: isLike ? Colors.redAccent : Colors.grey,
                              size: 20,
                            ),
                            onPressed: () {
                              setState(() {
                                isLike = !isLike;
                              });
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: false,
                    title: Text(data.nameCar,
                        style: TextStyle(
                            color: Colors.amber,
                            fontSize: 16.0,
                            shadows: [
                              BoxShadow(
                                  blurRadius: 4,
                                  color: Colors.black,
                                  spreadRadius: 4)
                            ])),
                    background: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(ApiHttp.urlImageVehicle +data.imageCar),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ];
          },
          body: Container(
            margin: EdgeInsets.only(top: 55),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  color: Colors.white,
                  child: _tabView(),
                ),
                _tabBarView(),
              ],
            ),
          ),
        ),
      ),
     /*  bottomNavigationBar: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(blurRadius: 4, color: Colors.grey)]),
        height: 56,
        padding: EdgeInsets.all(12),
        child: RaisedButton(
          elevation: 5,
          color: Colors.blueAccent,
          onPressed: () {},
          child: Text('Booking Now',style: TextStyle(color: Colors.amber),),
        ),
      ), */
    );
  }

  Widget _tabView() {
    return DefaultTabController(
      length: 2,
      child: TabBar(
        tabs: <Widget>[
          Tab(
            text: 'Thông tin',
          ),
          Tab(
            text: 'Review',
          )
        ],
        controller: _tabController,
        labelColor: Colors.amber,
        labelStyle: TextStyle(fontSize: 14),
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
        controller: _tabController,
        children: <Widget>[
          Detail(
            data: widget.vehicle,
          ),
          ReviewPage()
        ],
      ),
    );
  }
}
