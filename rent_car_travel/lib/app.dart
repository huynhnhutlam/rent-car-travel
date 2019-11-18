import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:rent_car_travel/src/bloc/home_bloc.dart';
import 'package:rent_car_travel/src/bloc/splash_bloc.dart';
import 'package:rent_car_travel/src/constants/contants.dart';
import 'package:rent_car_travel/src/screen/booking/ariport_booking/ariport_booking_page.dart';
import 'package:rent_car_travel/src/screen/booking/selected_date/selected_date_page.dart';
import 'package:rent_car_travel/src/screen/booking/travel/travel_booking_page.dart';
import 'package:rent_car_travel/src/screen/booking/wedding_booking/wedding_booking_page.dart';
import 'package:rent_car_travel/src/screen/home/home_page.dart';
import 'package:rent_car_travel/src/screen/map/map.dart';
import 'package:rent_car_travel/src/screen/route/list_route/route_page.dart';
import 'package:rent_car_travel/src/screen/sign_in/sign_in_page.dart';
import 'package:rent_car_travel/src/screen/sign_up/sign_up.dart';
import 'package:rent_car_travel/src/screen/splash/splash_page.dart';
import 'package:rent_car_travel/src/screen/start_screen/get_started.dart';
import 'package:rent_car_travel/src/screen/vehicle/detailCar/detailCar_home_page.dart';
import 'package:rent_car_travel/src/screen/vehicle/list_vehicle/vehicle_page.dart';
import 'package:rent_car_travel/src/utils/application.dart';
import 'package:rent_car_travel/src/utils/translations.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SpecificLocalizationDelegate _localizationDelegate;

  @override
  void initState() {
    super.initState();
    _localizationDelegate = new SpecificLocalizationDelegate(Locale('vi'));
    applic.onLocaleChanged = onLocalChange;
  }

  onLocalChange(Locale locale) {
    setState(() {
      _localizationDelegate = new SpecificLocalizationDelegate(locale);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SplashBloc>(
          builder: (_) => SplashBloc(),
        ),
        ChangeNotifierProvider<HomeBloc>(
          builder: (_) => HomeBloc(0),
        )
      ],
      child: MaterialApp(
        localizationsDelegates: [
          _localizationDelegate,
          const TranslationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        theme: ThemeData.light(),
        onGenerateRoute: routes,
      ),
    );
  }

  Route routes(RouteSettings settings) {
    switch (settings.name) {
      case Constants.splashScreen:
        return new MaterialPageRoute(builder: (context) => SplashPage());
      case Constants.homeScreen:
        return new MaterialPageRoute(builder: (context) => HomePage());
      case Constants.getStatedScreen:
        return new MaterialPageRoute(builder: (context) => GetStartPage());
      case Constants.signInScreen:
        return new MaterialPageRoute(builder: (context) => SignInPage());
      case Constants.signUpScreen:
        return new MaterialPageRoute(builder: (context) => SignUpPage());
      case Constants.detailCar:
        return new MaterialPageRoute(
            builder: (context) => DetailCar(
                  vehicle: settings.arguments,
                ));
      case Constants.wedding_booking:
        return new MaterialPageRoute(
            builder: (context) => WeddingBookingPage());
      case Constants.select_date:
        return new MaterialPageRoute(builder: (context) => SelectDatePage());
      case Constants.map_page:
        return new MaterialPageRoute(builder: (context) => MapSample());
      case Constants.vehicle_list:
        return new MaterialPageRoute(builder: (context) => VehiclePage());
      case Constants.route_list:
        return new MaterialPageRoute(builder: (context) => RoutePage());
      case Constants.airport_booking:
        return new MaterialPageRoute(
            builder: (context) => AirportBookingPage());
      case Constants.travel_booking:
        return new MaterialPageRoute(builder: (context) => TravelBookingPage());
        break;
      default:
        return null;
    }
  }
}
