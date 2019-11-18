import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rent_car_travel/app.dart';
import 'package:rent_car_travel/src/bloc/place_notifer.dart';

void main() => runApp(MultiProvider(providers: [
      ChangeNotifierProvider.value(
        value: AppState(),
      )
    ], child: MyApp()));
