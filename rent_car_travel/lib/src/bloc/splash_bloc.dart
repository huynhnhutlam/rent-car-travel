import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class SplashBloc extends ChangeNotifier {
  final goToPageController = StreamController<bool>.broadcast(); 
  Stream get getGoToPage => goToPageController.stream;

  SplashBloc();

  startTimer() {
    final timeout = const Duration(seconds: 3);
    Timer.periodic(timeout, (Timer t) {
      if(!goToPageController.isClosed){
        goToPageController.sink.add(true);
        goToPageController.close();
      }
      t.cancel();
      notifyListeners();
    });
  }

  @override
  void dispose() {
    goToPageController.close();
    super.dispose();
  }
}