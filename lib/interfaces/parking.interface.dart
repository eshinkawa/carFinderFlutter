import 'package:flutter/material.dart';

abstract class IParkingRepository {
  void setDataOnStorage(String propName, String value);

  void getDataFromStorage();

  void removeDataFromStorage();

  bool isAllInfoFilled(
      String selectedFloor, String selectedLetter, String selectedNumber);

  Future<void> openDialog(BuildContext context, String selectedLetter,
      String selectedNumber, String selectedFloor, String timeTobeRecorded);

  void saveData(String selectedLetter, String selectedNumber,
      String selectedFloor, String timeTobeRecorded);

  void reset();

  List<DropdownMenuItem<String>> dropdownFloor();

  List<DropdownMenuItem<String>> dropdownLetter();

  List<DropdownMenuItem<String>> dropdownNumber();
}
