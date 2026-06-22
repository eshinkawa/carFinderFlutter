import 'dart:io';

import 'package:cade_meu_carro/controllers/parking.controller.dart';
import 'package:cade_meu_carro/models/history_item.dart';
import 'package:cade_meu_carro/views/home.view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

bool _hiveInitialized = false;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Box<HistoryItem> box;

  setUp(() async {
    if (!_hiveInitialized) {
      final dir = Directory.systemTemp.createTempSync('carfinder_test_');
      Hive.init(dir.path);
      Hive.registerAdapter(HistoryItemAdapter());
      _hiveInitialized = true;
    }
    box = await Hive.openBox<HistoryItem>('test_history');
  });

  tearDown(() async {
    await box.close();
    await Hive.deleteBoxFromDisk('test_history');
  });

  Widget buildTestApp() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ParkingController(box)),
      ],
      child: const MaterialApp(home: HomeView()),
    );
  }

  testWidgets('renders parking view with title', (tester) async {
    await tester.pumpWidget(buildTestApp());
    await tester.pumpAndSettle();

    expect(find.text('Where did you park your car?'), findsOneWidget);
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('History'), findsOneWidget);
  });

  testWidgets('dropdowns appear when no parking saved', (tester) async {
    await tester.pumpWidget(buildTestApp());
    await tester.pumpAndSettle();

    expect(find.text('Floor'), findsOneWidget);
    expect(find.text('Section'), findsOneWidget);
    expect(find.text('Number'), findsOneWidget);
  });
}
