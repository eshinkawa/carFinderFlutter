import 'package:flutter/material.dart';
import 'dart:async';

import 'views/parking.dart';
import './components/fader.dart';

void main() {
  runApp(MaterialApp(
    home: SplashScreen(),
    debugShowCheckedModeBanner: false,
  ));
}
class SplashScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    loadData();
  }

  Future<Timer> loadData() async {
    return new Timer(Duration(seconds: 3), onDoneLoading);
  }

  onDoneLoading() async {
    // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Parking()));
    Navigator.push(context, FadeRoute(page: Parking()));

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/imgs/splash.png'),
            fit: BoxFit.cover
        ) ,
      ),
    );
  }
}