import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rent_car_travel/src/constants/api_http.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:rent_car_travel/src/models/route.dart';
import 'package:rent_car_travel/src/screen/manage/route/addRoute.dart';
import 'package:rent_car_travel/src/screen/manage/route/updateRoute.dart';

class RouteList extends StatefulWidget {
  final String title;

  RouteList(this.title);

  @override
  _RouteListState createState() => _RouteListState();
}
 Future<List<Routes>> fetchRoute(http.Client client) async {
  final response = await client.get(ApiHttp.urlListRoute);

  return compute(parseRoutes, response.body);
}

List<Routes> parseRoutes(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Routes>((json) => Routes.fromJson(json)).toList();
}
class _RouteListState extends State<RouteList> {
  double radius = 8;
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.blue),
        title: Text(widget.title, style: TextStyle(color: Colors.blue,fontSize: 18),),
         actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (builder) => AddRoute() ));
            },
            child: Text(
              'Thêm mới',
              style: TextStyle(color: Colors.blue),
            ),
          )
        ],
      ),
      body: _buildBody(),
    );
  }
  Widget _buildBody(){
    return FutureBuilder(
      future: fetchRoute(http.Client()),
      builder: (context, snapshot) {
        return snapshot.data != null
            ? Container(
                child: ListView.separated(
                  itemCount: snapshot.data.length,
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.all(16),
                  separatorBuilder: (context, index){
                    return SizedBox(height: 16,);
                  },
                  itemBuilder: (context, index) {
                    return _itemRouteList(snapshot, index);
                  },
                ),
              )
            : Center(child:CupertinoActivityIndicator());
      },
    );
  }
  Widget _itemRouteList(AsyncSnapshot snapshot, int index) {
    var data = snapshot.data[index];
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 4.0,
            offset: Offset(0, 1),
            color: Colors.grey,
            spreadRadius: 1.0,
          ),
        ],
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Row(
        children: <Widget>[
          _imageRoute(
            image: NetworkImage(data.image),
            chilld: Stack(
              children: <Widget>[
                Positioned(
                  top: 0,
                  right: 8,
                  child: _ratingRoute(data.rating),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _textNameRoute(data.nameRoute),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: _textDesriptionRout(data.description),
                  ),
                ],
              ),
            ),
          ),
           PopupMenuButton<int>(
             
              onSelected:(int value){
                if(value == 1){
                  Navigator.push(context, MaterialPageRoute(builder: (builder) => UpdateRoute(routes: data,)));
                }
                if(value == 2){
                  print('Xóa');
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 1,
                  child: Text("Cập nhật"),
                ),
                PopupMenuItem(
                  value: 2,
                  child: Text("Xóa"),
                ),
              ],
            )
        ],
      ),
    );
  }
}

Widget _textNameRoute(String nameRoute) {
  TextStyle styleNameRoute = TextStyle(
    color: colorNameRoute,
    fontSize: sizeName,
  );
  return Text(
    nameRoute,
    style: styleNameRoute,
  );
}

Widget _textDesriptionRout(String descriptionRoute) {
  TextStyle styleDescriptionRoute = TextStyle(
    color: colorDescription,
    fontSize: sizeDescription,
  );
  return Text(
    descriptionRoute,
    style: styleDescriptionRoute,
    maxLines: 3,
    overflow: TextOverflow.ellipsis,
  );
}

Widget _imageRoute({ImageProvider<dynamic> image, Widget chilld}) {
  return Container(
    width: 85,
    height: 85,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
      image: DecorationImage(image: image, fit: BoxFit.cover),
    ),
    child: chilld,
  );
}

Widget _ratingRoute(double rating) {
  return Container(
    decoration: _decorate,
    padding: EdgeInsets.all(2),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(vertical: 4),
          child: _rowStar(3),
        ),
        _textRating('${rating.toDouble()}'),
      ],
    ),
  );
}

Widget _rowStar(int length) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: List.generate(length, (index) {
      return InkWell(
        onTap: () {},
        child: Icon(
          Icons.star,
          color: Colors.white,
          size: 10,
        ),
      );
    }),
  );
}

Widget _textRating(String rating) {
  TextStyle styleRating = TextStyle(color: colorRating, fontSize: sizeRating);
  return Text(
    rating,
    style: styleRating,
  );
}

BoxDecoration _decorate = BoxDecoration(
  color: Colors.amber,
  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(4), bottomRight:  Radius.circular(4)),
  boxShadow: [
    BoxShadow(
        blurRadius: 4.0,
        offset: Offset(0, 1),
        color: Colors.black,
        spreadRadius: 0.0)
  ],
);
Color colorRating = Color(0xFFFFFFFF);
double sizeRating = 12;
double sizeName = 14;
double sizeDescription = 12;
Color colorNameRoute = Color(0xFF000000);
Color colorDescription = Color(0xFF737373);

