import 'package:cade_meu_carro/controllers/parking.controller.dart';
import 'package:cade_meu_carro/models/history_item.dart';
import 'package:cade_meu_carro/routes.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(HistoryItemAdapter());
  final Box<dynamic> db = await Hive.openBox<HistoryItem>('history');
  runApp(MyApp(database: db));
}

class MyApp extends StatelessWidget {
  final Box<dynamic> database;

  MyApp({this.database});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ParkingController(database)),
      ],
      child: Routes(),
    );
  }
}
