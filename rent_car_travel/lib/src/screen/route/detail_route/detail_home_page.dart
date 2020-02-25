import 'package:flutter/material.dart';
import 'package:rent_car_travel/src/constants/api_http.dart';
import 'package:rent_car_travel/src/models/route.dart';
import 'package:rent_car_travel/src/screen/route/detail_route/detail_route.dart';
import 'package:rent_car_travel/src/screen/widget/row_rating.dart';

class DetailRouteHome extends StatefulWidget {
  final Routes route;

  const DetailRouteHome({Key key, this.route}) : super(key: key);

  @override
  _DetailRouteHomeState createState() => _DetailRouteHomeState();
}

class _DetailRouteHomeState extends State<DetailRouteHome>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  bool isLike = false;

  List<Widget> _tabs = <Widget>[
    Tab(
      text: 'Thông tin',
    ),
    Tab(
      text: 'Bình luận',
    ),
  ];

  @override
  void initState() {
    _tabController =
        TabController(length: _tabs.length, initialIndex: 0, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var data = widget.route;

    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.grey.withOpacity(0.3),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              _appBar(context, data.nameRoute, data.rating),
              Container(color: Colors.white, child: _tabView()),
              _tabBarView(),
            ],
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
          color: Colors.blueAccent,
          onPressed: () {},
          child: Text('Selected'),
        ),
      ), */
    );
  }

  Widget _appBar(BuildContext context, String name, double rating) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(ApiHttp.urlImageRoute +widget.route.image),
                      fit: BoxFit.cover))),
          Positioned(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 20,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Container(
                  margin: EdgeInsets.only(right: 16),
                  height: 40,
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
          Positioned(
            bottom: 0,
            child: Container(
              color: Colors.black.withOpacity(0.4),
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.fromLTRB(16, 8, 0, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    name,
                    style: TextStyle(
                        color: Colors.orange,
                        shadows: [BoxShadow(blurRadius: 3, spreadRadius: 3)],
                        fontSize: 24,
                        fontWeight: FontWeight.w600),
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(right: 8),
                          child:
                              StarRating(value: rating.toDouble(), size: 16)),
                      Text(
                        '${rating.toDouble()}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _tabView() {
    return DefaultTabController(
      length: 2,
      child: TabBar(
        tabs: _tabs,
        controller: _tabController,
        labelColor: Colors.orange,
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
          DetailRoute(
            routes: widget.route,
          ),
          Container(),
        ],
      ),
    );
  }
}
