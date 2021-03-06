import 'package:flutter/material.dart';
import 'package:rent_car_travel/src/constants/api_http.dart';
import 'package:rent_car_travel/src/models/vehicle/banner..dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:rent_car_travel/src/utils/carousel_build.dart';

import 'package:http/http.dart' as http;

const List<String> imageUrls = <String>[
  "https://image.iol.co.za/image/1/process/620x349?source=https://inm-baobab-prod-eu-west-1.s3.amazonaws.com/public/inm/media/image/iol/2018/11/19/18178133/IOLmot19nov18_Lamborghini_c.jpg&operation=CROP&offset=0x0&resize=1800x1010",
  "https://cache.bmwusa.com/cosy.arox?BKGND=TRANSPARENT&HEIGHT=100p&WIDTH=100p&angle=60&brand=WBBI&client=byo&date=20180306&fabric=FNKFD&paint=P0C23&pov=walkaround&resp=png&sa=S027K%2CS02BQ%2CS0322%2CS04U1%2CS0508%2CS0610%2CS07Y9&vehicle=19IC",
  "https://imgix.ranker.com/node_img/26/511299/original/audi-r8-automobile-models-photo-1?w=650&q=50&fm=pjpg&fit=crop&crop=faces",
  "https://images-na.ssl-images-amazon.com/images/I/612z36b4PrL._SX425_.jpg",
  "https://www.telegraph.co.uk/content/dam/news/2017/11/11/Lam1_trans_NvBQzQNjv4BqnAdySV0BR-4fDN_-_p756cVfcy8zLGPV4EhRkjQy7tg.jpg?imwidth=450"
];
Future<List<BannerImage>> fetchPhotos(http.Client client) async {
  final response =
      await client.get(ApiHttp.urlListBannerVehicle);

  return compute(parseBanner, response.body);
}

List<BannerImage> parseBanner(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<BannerImage>((json) => BannerImage.fromJson(json)).toList();
}

class BannerVehicle extends StatefulWidget {
  @override
  _BannerVehicleState createState() => _BannerVehicleState();
}

class _BannerVehicleState extends State<BannerVehicle> {
  @override
  void initState() {
    fetchPhotos(http.Client());
    super.initState();
  }
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
