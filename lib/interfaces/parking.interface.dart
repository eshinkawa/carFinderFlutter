import 'package:flutter/material.dart';

abstract class IParkingRepository {
  void setDataOnStorage(String propName, String value);

  void getDataFromStorage();

  void removeDataFromStorage();

  bool isAllInfoFilled(
      String selectedFloor, String selectedLetter, String selectedNumber);

  Future<void> openDialog(BuildContext context, _selectedLetter,
      _selectedNumber, _selectedFloor, timeTobeRecorded);

  void saveData(
      _selectedLetter, _selectedNumber, _selectedFloor, timeTobeRecorded);

  void reset();

  List<DropdownMenuItem<String>> dropdownFloor();

  List<DropdownMenuItem<String>> dropdownLetter();

  List<DropdownMenuItem<String>> dropdownNumber();
}
