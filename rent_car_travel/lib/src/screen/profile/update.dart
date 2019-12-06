import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UpdateProfile extends StatefulWidget {
  final String avatar;
  final String name;
  final String email;
  final String address;
  final String phone;
  final String birthday;

  const UpdateProfile({Key key, this.avatar, this.name, this.email, this.address, this.phone, this.birthday}) : super(key: key);
  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _controllerName = TextEditingController(text: widget.name);
    TextEditingController _controllerEmail = TextEditingController(text: widget.email);
    TextEditingController _controllerAddress = TextEditingController(text: widget.address);
    TextEditingController _controllerPhone = TextEditingController(text: widget.phone);
    TextEditingController _controllerBirthday = TextEditingController(text: widget.birthday);
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
              'Cập nhật thông tin cá nhân',
              style: TextStyle(color: Colors.blue, fontSize: 18),
            ),
          ),
          body: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(16),
            child: SingleChildScrollView(child: Column(
              children: <Widget>[
                _avatar(widget.avatar),
                _textfeildInfo('Tên',_controllerName),
                 _textfeildInfo('Email',_controllerEmail),
                  _textfeildInfo('Địa chỉ',_controllerAddress),
                   _textfeildInfo('Số điện thoại',_controllerPhone),
                    _textfeildInfo('Ngày sinh',_controllerBirthday),
                    _buttonConfirm(onPressed: (){})
              ],
            )),
          ),
        ),
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

Widget _textfeildInfo(String title, TextEditingController controller) {
  return Container(
    margin: EdgeInsets.only(bottom: 12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          child: Text(
            title,
            style: TextStyle(
                color: Color(0xFF000000),
                fontSize: 14,
                fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(
          height: 8,
        ),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(12),
            enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Color.fromRGBO(0, 0, 0, 1))),
            border: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Color.fromRGBO(0, 0, 0, 1))),
          ),
        )
      ],
    ),
  );
}
Widget _buttonConfirm({Function onPressed}) {
  return FlatButton(
    onPressed: onPressed,
    color: Colors.white,
    child: Text('Xác nhận', style: TextStyle(color: Colors.blue)),
  );
}
