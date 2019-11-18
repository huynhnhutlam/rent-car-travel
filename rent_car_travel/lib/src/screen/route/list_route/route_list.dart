import 'package:flutter/material.dart';

class RouteList extends StatefulWidget {
  @override
  _RouteListState createState() => _RouteListState();
}
double radius = 8;
class _RouteListState extends State<RouteList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.builder(
        itemCount: 5,
        physics: ScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16.0,
            crossAxisSpacing: 24.0,
            childAspectRatio: 2 / 3),
        itemBuilder: (context, index) {
          return _itemRouteList(
            nameRoute: 'Cà Mau',
            description: 'Description',
            image: 'https://cdn2.ivivu.com/2018/03/20/17/mui-ca-mau.jpg'
          );
        },
      ),
    );
  }

  Widget _itemRouteList({String nameRoute, String description, String image}) {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: _imageRoute(
              image: NetworkImage(
                  image),
              chilld: Stack(
                children: <Widget>[
                  Positioned(
                    top: 8,
                    right: 8,
                    child: _ratingRoute(),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _textNameRoute(nameRoute),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: _textDesriptionRout(description),
                  ),
                ],
              ),
            ),
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
    maxLines: 2,
    overflow: TextOverflow.ellipsis,
  );
}

Widget _imageRoute({ImageProvider<dynamic> image, Widget chilld}) {
  return Container(
    width: 240,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radius), topRight: Radius.circular(radius)),
      image: DecorationImage(image: image, fit: BoxFit.cover),
    ),
    child: chilld,
  );
}

Widget _ratingRoute() {
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
        _textRating('3.0'),
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
  borderRadius: BorderRadius.circular(4),
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
