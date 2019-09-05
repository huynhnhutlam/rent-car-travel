import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rent_car_travel/src/bloc/splash_bloc.dart';
import 'package:rent_car_travel/src/constants/contants.dart';
class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  var bloc;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (bloc == null) {
      bloc = Provider.of<SplashBloc>(context);
      bloc.startTimer();
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!bloc.goToPageController.isClosed) {
      bloc.goToPageController.stream.listen((data) {
        if (data) {
          Navigator.pushReplacementNamed(context, Constants.getStatedScreen);
        }
      }, onDone: () {
      }, onError: (error) {
        print(error);
      });
    }

    return Scaffold(
      body: Container(
        alignment: FractionalOffset.center,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Image.asset(
            'lib/res/images/splash.png',
            fit: BoxFit.cover
          )
        )
      )
    );
  }
}