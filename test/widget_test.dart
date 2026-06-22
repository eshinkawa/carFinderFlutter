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

  late Box<HistoryItem> historyBox;
  late Box settingsBox;

  setUp(() async {
    if (!_hiveInitialized) {
      final dir = Directory.systemTemp.createTempSync('carfinder_test_');
      Hive.init(dir.path);
      Hive.registerAdapter(HistoryItemAdapter());
      _hiveInitialized = true;
    }
    historyBox = await Hive.openBox<HistoryItem>('test_history');
    settingsBox = await Hive.openBox('test_settings');
  });

  tearDown(() async {
    await historyBox.close();
    await settingsBox.close();
    await Hive.deleteBoxFromDisk('test_history');
    await Hive.deleteBoxFromDisk('test_settings');
  });

  Widget buildTestApp() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ParkingController(historyBox, settingsBox),
        ),
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

  testWidgets('controller initializes with empty state', (tester) async {
    await tester.pumpWidget(buildTestApp());
    await tester.pumpAndSettle();

    final controller = Provider.of<ParkingController>(
      tester.element(find.byType(HomeView)),
      listen: false,
    );

    expect(controller.code, isNull);
    expect(controller.timeStamp, isNull);
    expect(controller.showSaveButton, isTrue);
  });

  testWidgets('navigates to history tab shows empty state', (tester) async {
    await tester.pumpWidget(buildTestApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('History'));
    await tester.pumpAndSettle();

    expect(find.text('No history'), findsOneWidget);
  });

  test('confirming parking persists to Hive', () async {
    final controller = ParkingController(historyBox, settingsBox);

    controller.setFloor('SS1');
    controller.setLetter('A');
    controller.setNumber('1');
    await controller.confirmParking();

    expect(settingsBox.get('parking_code'), 'A1 no SS1');
    expect(settingsBox.get('parking_time'), isNotNull);
    expect(historyBox.values.length, 1);
    expect(historyBox.values.first.description, 'A1 no SS1');
  });
}
