import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:rent_car_travel/src/constants/api_http.dart';
import 'package:rent_car_travel/src/constants/contants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rent_car_travel/src/models/loginModel.dart';
import 'package:http/http.dart' as http;
import 'package:rent_car_travel/src/screen/manage/home/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

String username = "";
enum LoginStatus { notSignIn, signIn }

class _SignInPageState extends State<SignInPage> {
  LoginStatus _loginStatus = LoginStatus.notSignIn;
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final loginModel = LoginModel();
  String msg = '';
  final _key = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _usernameController.addListener(() {
      loginModel.usernameSink.add(_usernameController.text);
    });
    _passwordController.addListener(() {
      loginModel.passwordSink.add(_passwordController.text);
    });
  }

  check() {
    final form = _key.currentState;
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
      if (form.validate()) {
        form.save();
        //pop dialog
        _login();
        Navigator.pop(context);
      }
    });
  }

  _login() async {
    final response = await http.post(ApiHttp.urlLogin, body: {
      "username": _usernameController.text,
      "password": _passwordController.text,
    });
    final data = jsonDecode(response.body);
    String name = data['name'];
    String email = data['email'];
    String id = data['user_id'];
    String roleId = data['role_id'];
    String avatar = data['avatar'];
    String phone = data['phone'];
    String address = data['address'];
    String birthday = data['birthday'];

    if (data['loi'] == 'user sai') {
      setState(() {
        msg = "Sai thông tin tài khoản ";
      });
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
              title: Text('Đăng nhập'),
              content: Text(msg),
              actions: <Widget>[
                new FlatButton(
                  child: Text('Xác nhận'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            );
          });
    } else {
      if (data['role_id'] == '1') {
        setState(() {
          savePref(email, name, id, roleId, avatar, phone, address, birthday);
          Navigator.push(context, MaterialPageRoute(builder: (build)=> HomPageManage()));
        });
      } else if (data['role_id'] == '2') {
        setState(() {
          _loginStatus = LoginStatus.signIn;
          savePref(email, name, id, roleId, avatar, phone, address, birthday);
        });
        Navigator.pushNamed(context, Constants.homeScreen);
      }
    }
  }

  savePref(String email, String name, String id, String roleId, String avatar,
      String phone, String address, String birthday) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setString("name", name);
      preferences.setString("email", email);
      preferences.setString("id", id);
      preferences.setString("role_id", roleId);
      preferences.setString("avatar", avatar);
      preferences.setString("phone", phone);
      preferences.setString("address", address);
      preferences.setString("birthday", birthday);
      preferences.commit();
    });
  }

  @override
  void dispose() {
    super.dispose();
    loginModel.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    final style = TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.w300,
    );
    final buttonSignIn = new StreamBuilder<bool>(
      stream: loginModel.btnLoginStrem,
      builder: (context, snapshot) {
        return Container(
            margin: EdgeInsets.only(bottom: 10),
            child: MaterialButton(
              height: 45,
              minWidth: width,
              color: Colors.blueAccent,
              onPressed: snapshot.data == true
                  ? () {
                      check();
                    }
                  : null,
              child: Text('Sign In', style: style),
            ));
      },
    );
    final textUsername = new StreamBuilder<String>(
      stream: loginModel.usernameStream,
      builder: (context, snapshot) {
        return TextFormField(
          textInputAction: TextInputAction.done,
          controller: _usernameController,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Username',
            hintStyle: style,
            border: InputBorder.none,
            errorText: snapshot.data,
            prefixIcon: Icon(
              Icons.account_circle,
              size: 24,
            ),
          ),
        );
      },
    );
    final textPassword = new StreamBuilder<String>(
      stream: loginModel.passwordStream,
      builder: (context, snapshot) {
        return TextField(
          obscureText: true,
          controller: _passwordController,
          textInputAction: TextInputAction.go,
          style: TextStyle(color: Colors.white),
          onSubmitted: (value) {
            check();
          },
          decoration: InputDecoration(
              hintText: 'Password',
              hintStyle: style,
              border: InputBorder.none,
              errorText: snapshot.data,
              prefixIcon: Icon(
                Icons.lock,
                size: 24,
              )),
        );
      },
    );
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
              child: Form(
                key: _key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 10, top: 10),
                      height: height / 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                              child: Text(
                            'Car Travel',
                            style: style,
                          )),
                          textUsername,
                          Container(
                            height: 1,
                            color: Colors.white,
                            margin: EdgeInsets.all(10),
                          ),
                          textPassword,
                          InkWell(
                            onTap: () {},
                            child: Text('Forgot Password'),
                          )
                        ],
                      ),
                    ),
                    buttonSignIn,
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                      child: RichText(
                        text: TextSpan(
                            text: "Don't Account ?? ",
                            style: TextStyle(
                                color: Color(0xff606470), fontSize: 16),
                            children: <TextSpan>[
                              TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.pushNamed(
                                          context, Constants.signUpScreen);
                                    },
                                  text: "Sign up for a new account",
                                  style: TextStyle(
                                      color: Color(0xffffffff), fontSize: 16))
                            ]),
                      ),
                    ),
                    //Line
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              gradient: new LinearGradient(
                                  colors: [
                                    Colors.white10,
                                    Colors.white,
                                  ],
                                  begin: const FractionalOffset(0.0, 0.0),
                                  end: const FractionalOffset(1.0, 1.0),
                                  stops: [0.0, 1.0],
                                  tileMode: TileMode.clamp),
                            ),
                            width: 100.0,
                            height: 1.0,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 15.0, right: 15.0),
                            child: Text(
                              "Or",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              gradient: new LinearGradient(
                                  colors: [
                                    Colors.white,
                                    Colors.white10,
                                  ],
                                  begin: const FractionalOffset(0.0, 0.0),
                                  end: const FractionalOffset(1.0, 1.0),
                                  stops: [0.0, 1.0],
                                  tileMode: TileMode.clamp),
                            ),
                            width: 100.0,
                            height: 1.0,
                          ),
                        ],
                      ),
                    ),
                    //Button Facebook and Google
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 10.0, right: 40.0),
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: const EdgeInsets.all(15.0),
                              decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: new Icon(
                                FontAwesomeIcons.facebookF,
                                color: Color(0xFF0084ff),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: const EdgeInsets.all(15.0),
                              decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: new Icon(
                                FontAwesomeIcons.google,
                                color: Color(0xFF0084ff),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
