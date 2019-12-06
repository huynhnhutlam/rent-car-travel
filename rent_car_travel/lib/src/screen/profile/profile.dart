import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rent_car_travel/src/screen/profile/update.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String name, avatar, email, address, birthday, phone;

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      avatar = preferences.getString("avatar");
      name = preferences.getString("name");
      email = preferences.getString("email");
      address = preferences.getString("address");
      birthday = preferences.getString("birthday");
      phone = preferences.getString("phone");
    });
  }

  @override
  void initState() {
    getPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          child: new Image.network(
            'https://backgrounddownload.com/wp-content/uploads/2018/09/free-background-information-2.jpg',
            fit: BoxFit.fitHeight,
            height: MediaQuery.of(context).size.height,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            centerTitle: true,
            elevation: 5,
            iconTheme: IconThemeData(color: Colors.blue),
            backgroundColor: Colors.white,
            automaticallyImplyLeading: true,
            title: Text(
              'Thông tin cá nhân',
              style: TextStyle(color: Colors.blue, fontSize: 18),
            ),
          ),
          body: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(16),
            child: SingleChildScrollView(child: _buildBody()),
          ),
        ),
      ],
    );
  }

  Widget _buildBody() {
    return Column(
      children: <Widget>[
        _avatar(avatar),
        SizedBox(height: 8),
        _name(name),
        SizedBox(height: 12),
        _info(email, context, title: 'Email'),
        SizedBox(height: 12),
        _info(address, context, title: 'Địa chỉ'),
        SizedBox(height: 12),
        _info(phone, context, title: 'Số điện thoại'),
        SizedBox(height: 12),
        _info(birthday, context, title: 'Ngày sinh'),
        SizedBox(height: 12),
        _buttonProfile('Sửa thông tin', icon: Icons.edit, onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (buidlder) => UpdateProfile(
                avatar: avatar,
                name: name,
                address: address,
                phone: phone,
                birthday: birthday,
                email: email,
              )));
        }),
        _buttonProfile('Đổi mật khẩu', icon: Icons.vpn_key, onPressed: () {}),
        _buttonProfile('Thoát', icon: Icons.exit_to_app, onPressed: () {}),
      ],
    );
  }

  Widget _avatar(String avatar) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: CachedNetworkImage(
        height: 100,
        width: 100,
        imageUrl: avatar == ''
            ? 'https://t4.ftcdn.net/jpg/02/68/29/79/500_F_268297980_bleTmBMJomIyWLanB4HrLpnDoEh4vboM.jpg'
            : avatar,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _name(String name) {
    TextStyle nameStyle = TextStyle(
        color: Color(0xFF000000), fontSize: 18, fontWeight: FontWeight.w500);
    return Text(name, style: nameStyle);
  }
}

Widget _info(String info, BuildContext context, {String title}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        title,
        style: TextStyle(
            color: Color(0xFF000000),
            fontSize: 16,
            fontWeight: FontWeight.w500),
      ),
      SizedBox(
        height: 8,
      ),
      Container(
        padding: EdgeInsets.all(12),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Color.fromRGBO(0, 0, 0, 1))),
        child: Text(
          info,
          style: TextStyle(color: Color(0xFF000000), fontSize: 14),
        ),
      ),
    ],
  );
}

Widget _buttonProfile(String titleButton, {IconData icon, Function onPressed}) {
  return InkWell(
    onTap: onPressed,
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            size: 20,
          ),
          SizedBox(
            width: 4,
          ),
          Text(
            titleButton,
            style: TextStyle(
                color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    ),
  );
}
