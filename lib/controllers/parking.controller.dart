import 'package:cade_meu_carro/models/history_item.dart';
import 'package:cade_meu_carro/repository/parking.repository.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'parking.controller.g.dart';

class ParkingController = ParkingControllerBase with _$ParkingController;

abstract class ParkingControllerBase with Store {
  ParkingRepository repository;

  ParkingControllerBase() {
    repository = ParkingRepository();
  }

  @observable
  String selectedFloor;

  @observable
  String selectedLetter;

  @observable
  String selectedNumber;

  @observable
  String code;

  @observable
  String timeStamp;

  @observable
  bool showSaveButton = true;

  String timeTobeRecorded = DateFormat('dd/MM/yyyy HH:mm')
      .format(DateTime.parse(DateTime.now().toString()));

  @action
  void setCode(String value) => code = value;

  @action
  void setTimeStamp(String value) => code = value;

  @action
  void setShowSaveButton(bool value) => showSaveButton = value;

  @action
  void setFloor(String value) => selectedFloor = value;

  @action
  void setLetter(String value) => selectedLetter = value;

  @action
  void setNumber(String value) => selectedNumber = value;

  void setDataOnStorage(String propName, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(propName, value);
  }

  void getDataFromStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('Code: ${prefs.getString('code')}');
    print('TimeStamp: ${prefs.getString('timeStamp')}');
    setCode(prefs.getString('code'));
    setTimeStamp(prefs.getString('timeStamp'));
  }

  void removeDataFromStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('code');
    prefs.remove('timeStamp');
    getDataFromStorage();
  }

  void addContact(HistoryItem item) {
    Box<HistoryItem> historyBox = Hive.box<HistoryItem>('history');
    historyBox.add(item);
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
    Box<HistoryItem> historyBox = Hive.box<HistoryItem>('history');
    historyBox.add(historyItem);
  }

  void saveData(
      selectedLetter, selectedNumber, selectedFloor, timeTobeRecorded) {
    final parkingSpot = '$selectedLetter$selectedNumber no $selectedFloor';
    setDataOnStorage('code', parkingSpot);
    setDataOnStorage('timeStamp', timeTobeRecorded);
    final newHistoryItem =
        HistoryItem(description: parkingSpot, date: timeTobeRecorded);
    addHistoryItem(newHistoryItem);
    setShowSaveButton(false);
    print(showSaveButton);
  }

  bool isAllInfoFilled() =>
      selectedFloor != null && selectedLetter != null && selectedNumber != null;

  void reset() {
    setFloor(null);
    setLetter(null);
    setNumber(null);
  }
}
