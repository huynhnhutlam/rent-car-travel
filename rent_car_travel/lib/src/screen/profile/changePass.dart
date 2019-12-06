import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
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
                'Đổi mật khẩu',
                style: TextStyle(color: Colors.blue, fontSize: 18),
              ),
            ),
          body: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(16),
            child: SingleChildScrollView(child: Container()),
          ),
        ),
      ],
    );
  }
}