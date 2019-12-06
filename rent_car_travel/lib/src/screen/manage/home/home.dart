import 'package:flutter/material.dart';
import 'package:rent_car_travel/src/screen/manage/booking/booking.dart';
import 'package:rent_car_travel/src/screen/manage/route/route.dart';
import 'package:rent_car_travel/src/screen/manage/vehicle/vehicle.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomPageManage extends StatefulWidget {
  @override
  _HomPageManageState createState() => _HomPageManageState();
}

class _HomPageManageState extends State<HomPageManage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.blue),
        actionsIconTheme: IconThemeData(color: Colors.blue),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Trang chủ',
          style: TextStyle(color: Colors.blue, fontSize: 18),
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return GridView.builder(
        itemCount: home.length,
        padding: EdgeInsets.all(16),
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              if (home[index]['id'] == 1) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (builder) =>
                            BookingList(home[index]['title'])));
              }
              if (home[index]['id'] == 2) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => CarList(home[index]['title'])));
              }
              if (home[index]['id'] == 3) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => RouteList(home[index]['title'])));
              }
              if (home[index]['id'] == 4) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (builder) =>
                            BookingList(home[index]['title'])));
              }
              if (home[index]['id'] == 5) {
                
              }
            },
            child: _itemGrid(home[index]['title'], home[index]['image']),
          );
        });
  }
}

Widget _itemGrid(String title, String image) {
  return Card(
    elevation: 5,
    child: Container(
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.white,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4), topRight: Radius.circular(4)),
              child: CachedNetworkImage(
                height: 100,
                imageUrl: image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Expanded(
              child: Text(
            title,
            style: TextStyle(
                color: Color(0xFf737373),
                fontSize: 14,
                fontWeight: FontWeight.w600),
          ))
        ],
      ),
    ),
  );
}

List home = [
  {
    "id": 1,
    "image":
        "https://cdn0.iconfinder.com/data/icons/transportation-icons-3/110/Car-List-512.png",
    "title": "Danh sách đặt xe"
  },
  {
    "id": 2,
    "image":
        "https://img.pngio.com/cartoon-car-png-blue-color-transparent-background-image-high-cartoon-car-png-900_900.png",
    "title": "Danh sách xe"
  },
  {
    "id": 3,
    "image":
        "https://media.istockphoto.com/vectors/highway-roadmap-with-pins-car-road-direction-gps-route-pin-road-trip-vector-id1165547251?k=6&m=1165547251&s=170667a&w=0&h=CmqsC1bvOxpfQpOGEIEPNFSWx6NxRoOpE9JsLXS1lsY=",
    "title": "Danh sách tuyến đường"
  },
  {
    "id": 4,
    "image":
        "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcS33uA8P_kF66jRxKuGDqmHrz_U1Z43OuSExXbkCXAEDhDS2Nkq",
    "title": "Cài đặt"
  },
  {"id": 5, "image": "https://png.pngtree.com/png-vector/20190225/ourlarge/pngtree-vector-logout-icon-png-image_702463.jpg", "title": "Thoát"},
];
