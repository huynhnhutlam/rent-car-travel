import 'dart:async';

import 'package:rent_car_travel/src/stream/validation.dart';
import 'package:rxdart/rxdart.dart';

class LoginModel {
  final usernameSubject = BehaviorSubject<String>();
  final passwordSubject = BehaviorSubject<String>();
  final btnLoginSubject = BehaviorSubject<bool>();

  var usernameValidation = StreamTransformer<String, String>.fromHandlers(
      handleData: (username, sink) {
    sink.add(Validation.validateUsername(username));
  });
   var passwordValidation = StreamTransformer<String, String>.fromHandlers(
      handleData: (pass, sink) {
    sink.add(Validation.validateUsername(pass));
  });

  Stream<String> get usernameStream => usernameSubject.stream.transform(usernameValidation);
  Sink<String> get usernameSink => usernameSubject.sink;

  Stream<String> get passwordStream => passwordSubject.stream.transform(passwordValidation);
  Sink<String> get passwordSink => passwordSubject.sink;

  Stream<bool> get btnLoginStrem => btnLoginSubject.stream;
  Sink<bool> get btnLoginSink => btnLoginSubject.sink;

  LoginModel() {
    Observable.combineLatest2(usernameSubject, passwordSubject,
        (username, password) {
      return Validation.validateUsername(username) == null &&
          Validation.validatePass(password) == null;
    }).listen((enable) {
      btnLoginSink.add(enable);
    });
  }

  dispose() {
    usernameSubject.close();
    passwordSubject.close();
    btnLoginSubject.close();
  }
}
