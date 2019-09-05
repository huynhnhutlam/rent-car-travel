import 'dart:async';
import 'package:flutter/widgets.dart';

class HomeBloc extends ChangeNotifier{
  int _number;
  HomeBloc(this._number);
  get number => this._number;
  startCount(){
    final duration = const Duration(milliseconds: 1000);
    Timer.periodic(duration, (timer) {
      this._number++;
      notifyListeners();
  });
  }
}