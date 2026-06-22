import 'package:cade_meu_carro/models/history_item.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ParkingController extends ChangeNotifier {
  final Box<HistoryItem> _db;

  ParkingController(this._db) {
    getDataFromStorage();
  }

  String? selectedFloor;
  String? selectedLetter;
  String? selectedNumber;
  String? code;
  String? timeStamp;
  bool showSaveButton = true;

  String timeTobeRecorded =
      DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now());

  void setCode(String? value) {
    code = value;
  }

  void setTimeStamp(String? value) {
    timeStamp = value;
  }

  void setShowSaveButton(bool value) {
    showSaveButton = value;
    notifyListeners();
  }

  void setFloor(String? value) {
    selectedFloor = value;
    if (isAllInfoFilled()) {
      setShowSaveButton(true);
    }
    notifyListeners();
  }

  void setLetter(String? value) {
    selectedLetter = value;
    if (isAllInfoFilled()) {
      setShowSaveButton(true);
    }
    notifyListeners();
  }

  void setNumber(String? value) {
    selectedNumber = value;
    if (isAllInfoFilled()) {
      setShowSaveButton(true);
    }
    notifyListeners();
  }

  void setDataOnStorage(String propName, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(propName, value);
  }

  void getDataFromStorage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setCode(prefs.getString('code'));
    setTimeStamp(prefs.getString('timeStamp'));
    notifyListeners();
  }

  void removeDataFromStorage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('code');
    await prefs.remove('timeStamp');
    getDataFromStorage();
  }

  List<DropdownMenuItem<String>> dropdownFloor() {
    const List<String> ddl = ["SS1", "SS2", "SS3"];
    return ddl
        .map((value) => DropdownMenuItem(
              value: value,
              child: Text(value),
            ))
        .toList();
  }

  List<DropdownMenuItem<String>> dropdownLetter() {
    const List<String> ddl = ["A", "B", "C", "D", "E", "F"];
    return ddl
        .map((value) => DropdownMenuItem(
              value: value,
              child: Text(value),
            ))
        .toList();
  }

  List<DropdownMenuItem<String>> dropdownNumber() {
    final List<String> list = [];
    for (var i = 1; i < 31; i++) {
      list.add(i.toString());
    }
    return list
        .map((value) => DropdownMenuItem(
              value: value,
              child: Text(value),
            ))
        .toList();
  }

  void addHistoryItem(HistoryItem historyItem) {
    _db.add(historyItem);
  }

  void deleteHistoryItem(int index) {
    _db.deleteAt(index);
  }

  void saveData(
      String? selectedLetter,
      String? selectedNumber,
      String? selectedFloor,
      String? timeTobeRecorded) {
    final parkingSpot = '$selectedLetter$selectedNumber no $selectedFloor';
    setDataOnStorage('code', parkingSpot);
    setDataOnStorage('timeStamp', timeTobeRecorded ?? '');
    setShowSaveButton(false);
  }

  bool isAllInfoFilled() =>
      selectedFloor != null &&
      selectedLetter != null &&
      selectedNumber != null;

  void reset() {
    setFloor(null);
    setLetter(null);
    setNumber(null);
    notifyListeners();
  }
}
