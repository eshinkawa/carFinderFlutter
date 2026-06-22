import 'package:cade_meu_carro/controllers/parking.controller.dart';
import 'package:cade_meu_carro/models/history_item.dart';
import 'package:cade_meu_carro/utils/theme.dart';
import 'package:cade_meu_carro/views/home.view.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(HistoryItemAdapter());
  final Box<HistoryItem> db = await Hive.openBox<HistoryItem>('history');
  runApp(MyApp(database: db));
}

class MyApp extends StatelessWidget {
  final Box<HistoryItem> database;

  const MyApp({super.key, required this.database});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ParkingController(database)),
      ],
      child: MaterialApp(
        title: "Where's My Car?",
        theme: AppTheme.theme,
        debugShowCheckedModeBanner: false,
        home: const HomeView(),
      ),
    );
  }
}
