import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rent_car_travel/src/constants/api_http.dart';
import 'package:rent_car_travel/src/constants/contants.dart';
import 'package:rent_car_travel/src/utils/line.dart';
import 'package:http/http.dart' as http;

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController controllerUser = TextEditingController();
  TextEditingController controllerPass = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerReTypePass = TextEditingController();

  _signUpToServer() async {
    final response = await http.post(ApiHttp.urlRegister, body: {
      "username": controllerUser.text,
      "password": controllerPass.text,
      "email": controllerEmail.text,
    });
    final data = jsonDecode(response.body);
    if(data['value'] == 202){
      showDialog(
          context: context,
        builder: (context){
            return AlertDialog(
              title: Text("Đăng kí"),
              content: Text(
                'Đăng kí thành công!! Chuyển sang giao diện đăng nhập.'
              ),
              actions: <Widget>[
                FlatButton(
                  onPressed: (){

                    Navigator.pushNamed(context, Constants.signInScreen);
                  },
                  child: Text('Xác nhận'),
                )
              ],
            );
        }
      );
    }
    else {
      showDialog(
          context: context,
          builder: (context){
            return AlertDialog(
              title: Text("Đăng kí"),
              content: Text(
                  'Đăng kí thất bại!!Nhập lại.'
              ),
              actions: <Widget>[
                FlatButton(
                  onPressed: (){
                    Navigator.pop(context);
                    controllerUser.text = '';
                    controllerEmail.text = '';
                    controllerPass.text = '';
                    controllerReTypePass.text = '';
                  },
                  child: Text('Xác nhận'),
                )
              ],
            );
          }
      );
    }
  }

  check() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Đăng nhập"),
          content: new Row(
            children: [
              new CircularProgressIndicator(),
              new Text("Loading.."),
            ],
          ),
        );
      },
    );
    new Future.delayed(new Duration(seconds: 3), () {
      //pop dialog
      _signUpToServer();
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          child: new Image.asset(
            'lib/res/images/splash.png',
            fit: BoxFit.fitHeight,
            height: MediaQuery.of(context).size.height,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.black.withOpacity(0.5),
          body: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(14),
            child: SingleChildScrollView(
              child: _signUp(context),
            ),
          ),
        )
      ],
    );
  }

  Widget _signUp(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: controllerUser,
              textInputAction: TextInputAction.done,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Username',
                prefixIcon: Icon(
                  Icons.account_circle,
                  size: 20,
                ),
                hintStyle: TextStyle(color: Colors.white, fontSize: 16),
                border: InputBorder.none,
              ),
            ),
          ),
          //Line
          Line(),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: controllerEmail,
              textInputAction: TextInputAction.done,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Email',
                prefixIcon: Icon(
                  Icons.mail,
                  size: 20,
                ),
                hintStyle: TextStyle(color: Colors.white, fontSize: 16),
                border: InputBorder.none,
              ),
            ),
          ),
          //Line
          Line(),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: controllerPass,
              textInputAction: TextInputAction.done,
              style: TextStyle(color: Colors.white),
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Password',
                prefixIcon: Icon(
                  FontAwesomeIcons.key,
                  size: 18,
                ),
                hintStyle: TextStyle(color: Colors.white, fontSize: 16),
                border: InputBorder.none,
              ),
            ),
          ),
          //Line
          Line(),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: controllerReTypePass,
              textInputAction: TextInputAction.go,
              style: TextStyle(color: Colors.white),
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Confirm Password',
                prefixIcon: Icon(
                  FontAwesomeIcons.key,
                  size: 18,
                ),
                hintStyle: TextStyle(color: Colors.white, fontSize: 16),
                border: InputBorder.none,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(top: 12, bottom: 14),
            color: Colors.green,
            child: MaterialButton(
              onPressed: () {
                check();
              },
              child: Text('Sign Up'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
            child: RichText(
              text: TextSpan(
                  text: "Already Account ?? ",
                  style: TextStyle(color: Color(0xff606470), fontSize: 16),
                  children: <TextSpan>[
                    TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(
                                context, Constants.signInScreen);
                          },
                        text: "Sign in now.",
                        style:
                            TextStyle(color: Color(0xffffffff), fontSize: 16))
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
