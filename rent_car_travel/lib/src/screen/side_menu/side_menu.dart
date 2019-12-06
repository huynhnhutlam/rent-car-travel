import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rent_car_travel/src/constants/contants.dart';
import 'package:rent_car_travel/src/screen/history/history.dart';
import 'package:rent_car_travel/src/screen/side_menu/tabbarSideMenu.dart';
import 'package:rent_car_travel/src/screen/sign_in/sign_in_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SideMenu extends StatefulWidget {
  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  String name = '', avatar = '', userId;

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      avatar = preferences.getString("avatar");
      name = preferences.getString("name");
      userId =  preferences.getString("id");
    });
  }
  signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setString("name", null);
      preferences.setString("email", null);
      preferences.setString("id", null);
      preferences.setString("role_id", null);
      preferences.setString("avatar", null);
      preferences.setString("phone", null);
      preferences.setString("address", null);
      preferences.setString("birthday", null);
      preferences.commit();
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (builder) => SignInPage()), (Route<dynamic> route) => false);
    });
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          child: ListView(
        children: <Widget>[TabbarSideMenu(name, avatar), MenuItem(signOut,userId)],
      )),
    );
  }
}

class MenuItem extends StatefulWidget {
  final VoidCallback signOut;
  final String userId;
  MenuItem(this.signOut, this.userId);

  @override
  _MenuItemState createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  TextStyle styleTitle = TextStyle(color: Color(0xFF737373));

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(
              Icons.home,
              color: Colors.deepPurple,
            ),
            title: Text(
              'Trang chủ',
              style: styleTitle,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: SvgPicture.asset('lib/res/icon/vehicle.svg',
              width: 24,
              height: 24,
              color: Colors.amber,
            ),
            title: Text('Danh sách xe', style: styleTitle),
            onTap: () {
              Navigator.pushNamed(context, Constants.vehicle_list);
            },
          ),
          ListTile(
            leading: SvgPicture.asset(
              'lib/res/icon/route.svg',
              width: 24,
              height: 24,
              color: Colors.orange,
            ),
            title: Text('Tuyến đường', style: styleTitle),
            onTap: () {
              Navigator.pushNamed(context, Constants.route_list);
            },
          ),
           ListTile(
            leading: SvgPicture.asset(
              'lib/res/icon/service.svg',
              width: 24,
              height: 24,
              color: Colors.blue,
            ),
            title: Text('Lịch sử', style: styleTitle),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (builder) => HistoryBooking(userId: widget.userId,)));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.favorite,
              color: Colors.red,
            ),
            title: Text('Yêu thích', style: styleTitle),
            onTap: () {
              Navigator.pushNamed(context, Constants.vehicle_list);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              color: Colors.grey,
            ),
            title: Text(
              'Cài đặt',
              style: styleTitle,
            ),
            onTap: () {
              Navigator.pushNamed(context, Constants.vehicle_list);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.exit_to_app,
              color: Colors.grey,
            ),
            title: Text(
              'Đăng xuất',
              style: styleTitle,
            ),
            onTap: () {
              widget.signOut();
            },
          ),
        ],
      ),
    );
  }
}
