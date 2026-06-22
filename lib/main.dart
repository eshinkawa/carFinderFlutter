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
  final historyBox = await Hive.openBox<HistoryItem>('history');
  final settingsBox = await Hive.openBox('settings');
  runApp(MyApp(historyBox: historyBox, settingsBox: settingsBox));
}

class MyApp extends StatelessWidget {
  final Box<HistoryItem> historyBox;
  final Box settingsBox;

  const MyApp({super.key, required this.historyBox, required this.settingsBox});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ParkingController(historyBox, settingsBox),
        ),
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
