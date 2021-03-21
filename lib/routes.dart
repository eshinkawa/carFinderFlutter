import 'views/history.view.dart';
import 'views/parking.view.dart';
import 'views/splash_screen.view.dart';
import 'package:flutter/material.dart';

class Routes extends StatefulWidget {
  @override
  _RoutesState createState() => _RoutesState();
}

class _RoutesState extends State<Routes> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreenView(),
        '/parking': (context) => ParkingView(),
        '/history': (context) => HistoryView(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
