import 'package:cade_meu_carro/models/history_item.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ParkingController extends ChangeNotifier {
  Box<dynamic> _db;

  ParkingController(Box<dynamic> db) {
    _db = db;
    getDataFromStorage();
  }
  String selectedFloor;
  String selectedLetter;
  String selectedNumber;
  String code;
  String timeStamp;
  bool showSaveButton = true;

  String timeTobeRecorded = DateFormat('dd/MM/yyyy HH:mm')
      .format(DateTime.parse(DateTime.now().toString()));

  void setCode(String value) {
    code = value;
    // notifyListeners();
  }

  void setTimeStamp(String value) {
    timeStamp = value;
    // notifyListeners();
  }

  void setShowSaveButton(bool value) {
    showSaveButton = value;
    notifyListeners();
  }

  void setFloor(String value) {
    selectedFloor = value;
    if (isAllInfoFilled()) {
      setShowSaveButton(true);
    }
    notifyListeners();
  }

  void setLetter(String value) {
    selectedLetter = value;
    if (isAllInfoFilled()) {
      setShowSaveButton(true);
    }
    notifyListeners();
  }

  void setNumber(String value) {
    selectedNumber = value;
    if (isAllInfoFilled()) {
      setShowSaveButton(true);
    }
    notifyListeners();
  }

  void setDataOnStorage(String propName, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(propName, value);
  }

  void getDataFromStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setCode(prefs.getString('code'));
    setTimeStamp(prefs.getString('timeStamp'));
    print(code);
    print(timeStamp);
    notifyListeners();
  }

  void removeDataFromStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('code');
    prefs.remove('timeStamp');
    getDataFromStorage();
  }

  List<DropdownMenuItem<String>> dropdownFloor() {
    List<String> ddl = ["SS1", "SS2", "SS3"];
    return ddl
        .map((value) => DropdownMenuItem(
              value: value,
              child: Text(value),
            ))
        .toList();
  }

  List<DropdownMenuItem<String>> dropdownLetter() {
    List<String> ddl = ["A", "B", "C", "D", "E", "F"];
    return ddl
        .map((value) => DropdownMenuItem(
              value: value,
              child: Text(value),
            ))
        .toList();
  }

  List<DropdownMenuItem<String>> dropdownNumber() {
    List<String> list = [];
    for (var i = 1; i < 31; i++) {
      list.add(i.toString());
    }
    return list
        .map((value) => DropdownMenuItem(
              value: value,
              child: Text(value.toString()),
            ))
        .toList();
  }

  void addHistoryItem(HistoryItem historyItem) {
    _db.add(historyItem);
  }

  void deleteHistoryItem(int index) {
    _db.deleteAt(index);
    reset();
  }

  void saveData(
      selectedLetter, selectedNumber, selectedFloor, timeTobeRecorded) {
    final parkingSpot = '$selectedLetter$selectedNumber no $selectedFloor';
    setDataOnStorage('code', parkingSpot);
    setDataOnStorage('timeStamp', timeTobeRecorded);
    setShowSaveButton(false);
  }

  bool isAllInfoFilled() =>
      selectedFloor != null && selectedLetter != null && selectedNumber != null;

  void reset() {
    setFloor(null);
    setLetter(null);
    setNumber(null);
    notifyListeners();
  }
}
