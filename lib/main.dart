import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'views/splash_screen.view.dart';

Future<void> main() async {
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  runApp(MaterialApp(
    home: SplashScreenView(),
    debugShowCheckedModeBanner: false,
  ));
}
