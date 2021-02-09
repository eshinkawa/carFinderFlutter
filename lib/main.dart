import 'package:cade_meu_carro/models/history_item.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'views/splash_screen.view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(HistoryItemAdapter());
  await Hive.openBox<HistoryItem>('history');

  runApp(MaterialApp(
    home: SplashScreenView(),
    debugShowCheckedModeBanner: false,
  ));
}
