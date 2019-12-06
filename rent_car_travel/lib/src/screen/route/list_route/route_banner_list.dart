import 'package:flutter/material.dart';

import 'package:rent_car_travel/src/utils/carousel_build.dart';

const List<String> imageUrls = <String>[
  "https://intertour.vn/upload/leaderboard/du-lich-da-lat-duong-ham-dieu-_banner_2016020510243530.jpg",
  "https://static.abay.vn/DalatLangBiang_banner.jpg",
  "https://dulichkhampha24.com/wp-content/uploads/2019/03/52828046_1982791592015217_2452500650425057280_n.jpg",
  "https://hoangkhoitravel.com/img_data/images/hoang-khoi-travel-vung-tau-01.jpg",
  "http://gst.vn/wp-content/uploads/2014/12/phan-thiet-banner.jpg"
];

class BannerRoute extends StatefulWidget {
  @override
  _BannerRouteState createState() => _BannerRouteState();
}

class _BannerRouteState extends State<BannerRoute> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      child: CarouselBuild(
        autoplay: true,
        imageUrls: imageUrls,
        animationDuration: Duration(milliseconds: 1000),
        animationCurve: Curves.slowMiddle,
      ),
    );
  }
}
