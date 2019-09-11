import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:rent_car_travel/src/constants/contants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rent_car_travel/src/models/loginModel.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final loginModel = LoginModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _usernameController.addListener(() {
      loginModel.usernameSink.add(_usernameController.text);
    });
    _passwordController.addListener(() {
      loginModel.passwordSink.add(_passwordController.text);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
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
                      Navigator.pushNamed(context, Constants.homeScreen);
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
          decoration: InputDecoration(
              hintText: 'Username',
              hintStyle: style,
              border: InputBorder.none,
              errorText: snapshot.data,
              icon: Icon(
                Icons.account_circle,
                color: Colors.white,
              )),
        );
      },
    );
    final textPassword = new StreamBuilder<String>(
      stream: loginModel.passwordStream,
      builder: (context, snapshot) {
        return TextFormField(
          obscureText: true,
          controller: _passwordController,
          textInputAction: TextInputAction.go,
          decoration: InputDecoration(
              hintText: 'Password',
              hintStyle: style,
              border: InputBorder.none,
              errorText: snapshot.data,
              icon: Icon(
                Icons.lock,
                color: Colors.white,
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
                          style:
                              TextStyle(color: Color(0xff606470), fontSize: 16),
                          children: <TextSpan>[
                            TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushNamed(context, Constants.signUpScreen);
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
        )
      ],
    );
  }
}
