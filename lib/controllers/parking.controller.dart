import 'package:cade_meu_carro/models/history_item.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

const _kStorageCode = 'parking_code';
const _kStorageTime = 'parking_time';

class ParkingController extends ChangeNotifier {
  final Box<HistoryItem> _historyBox;
  final Box _settingsBox;

  ParkingController(this._historyBox, this._settingsBox) {
    _init();
  }

  String? selectedFloor;
  String? selectedLetter;
  String? selectedNumber;
  String? code;
  String? timeStamp;
  bool showSaveButton = true;

  String get timeToBeRecorded =>
      DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now());

  ValueListenable<Box<HistoryItem>> get historyListenable =>
      _historyBox.listenable();

  void _init() {
    try {
      code = _settingsBox.get(_kStorageCode) as String?;
      timeStamp = _settingsBox.get(_kStorageTime) as String?;
      notifyListeners();
    } catch (e) {
      debugPrint('Failed to load saved parking: $e');
    }
  }

  void setFloor(String? value) {
    selectedFloor = value;
    if (_isAllInfoFilled()) showSaveButton = true;
    notifyListeners();
  }

  void setLetter(String? value) {
    selectedLetter = value;
    if (_isAllInfoFilled()) showSaveButton = true;
    notifyListeners();
  }

  void setNumber(String? value) {
    selectedNumber = value;
    if (_isAllInfoFilled()) showSaveButton = true;
    notifyListeners();
  }

  Future<void> confirmParking() async {
    try {
      final spot = '$selectedLetter$selectedNumber no $selectedFloor';
      final now = timeToBeRecorded;

      final historyItem = HistoryItem(description: spot, date: now);
      await _historyBox.add(historyItem);
      await _settingsBox.put(_kStorageCode, spot);
      await _settingsBox.put(_kStorageTime, now);

      code = spot;
      timeStamp = now;
      showSaveButton = false;
      notifyListeners();
    } catch (e) {
      debugPrint('Failed to confirm parking: $e');
    }
  }

  Future<void> reset() async {
    try {
      await _settingsBox.delete(_kStorageCode);
      await _settingsBox.delete(_kStorageTime);
    } catch (e) {
      debugPrint('Failed to clear settings: $e');
    }
    code = null;
    timeStamp = null;
    selectedFloor = null;
    selectedLetter = null;
    selectedNumber = null;
    notifyListeners();
  }

  void deleteHistoryItem(int index) {
    try {
      _historyBox.deleteAt(index);
    } catch (e) {
      debugPrint('Failed to delete history item: $e');
    }
  }

  bool _isAllInfoFilled() =>
      selectedFloor != null &&
      selectedLetter != null &&
      selectedNumber != null;

  List<DropdownMenuItem<String>> dropdownFloor() {
    const ddl = ["SS1", "SS2", "SS3"];
    return ddl
        .map((v) => DropdownMenuItem(value: v, child: Text(v)))
        .toList();
  }

  List<DropdownMenuItem<String>> dropdownLetter() {
    const ddl = ["A", "B", "C", "D", "E", "F"];
    return ddl
        .map((v) => DropdownMenuItem(value: v, child: Text(v)))
        .toList();
  }

  List<DropdownMenuItem<String>> dropdownNumber() {
    final list = List.generate(30, (i) => (i + 1).toString());
    return list
        .map((v) => DropdownMenuItem(value: v, child: Text(v)))
        .toList();
  }
}
