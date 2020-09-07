import 'package:cade_meu_carro/interfaces/parking.interface.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ParkingRepository implements IParkingRepository {
  @override
  void setDataOnStorage(String propName, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(propName, value);
  }

  @override
  void getDataFromStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String codeAsync = prefs.getString('code');
    String timeStampAsync = prefs.getString('timeStamp');
    // setState(() {
    //   code = codeAsync;
    //   timeStamp = timeStampAsync;
    // });
  }

  @override
  void removeDataFromStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('code');
    prefs.remove('timeStamp');
    getDataFromStorage();
  }

  @override
  List<DropdownMenuItem<String>> dropdownFloor() {
    List<String> ddl = ["SS1", "SS2", "SS3"];
    return ddl
        .map((value) => DropdownMenuItem(
              value: value,
              child: Text(value),
            ))
        .toList();
  }

  @override
  List<DropdownMenuItem<String>> dropdownLetter() {
    List<String> ddl = ["A", "B", "C", "D", "E", "F"];
    return ddl
        .map((value) => DropdownMenuItem(
              value: value,
              child: Text(value),
            ))
        .toList();
  }

  @override
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

  @override
  Future<void> openDialog(BuildContext context, _selectedLetter,
      _selectedNumber, _selectedFloor, timeTobeRecorded) async {
    var _showDialog = showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar local de estacionamento?'),
          content: Text('$_selectedLetter$_selectedNumber no $_selectedFloor'),
          actions: <Widget>[
            FlatButton(
              child: Text('SALVAR'),
              onPressed: () {
                saveData(_selectedLetter, _selectedNumber, _selectedFloor,
                    timeTobeRecorded);
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text('CANCELAR'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
    return _showDialog;
  }

  @override
  void saveData(
      _selectedLetter, _selectedNumber, _selectedFloor, timeTobeRecorded) {
    setDataOnStorage(
        'code', '$_selectedLetter$_selectedNumber no $_selectedFloor');
    setDataOnStorage('timeStamp', timeTobeRecorded);
    // setState(() {
    //   showSaveButton = false;
    // });
    // print(showSaveButton);
  }

  @override
  bool isAllInfoFilled(
      String selectedFloor, String selectedLetter, String selectedNumber) {
    var floor = selectedFloor != null;
    var letter = selectedLetter != null;
    var number = selectedNumber != null;
    return floor && letter && number;
  }

  @override
  void reset() {
    // TODO: implement reset
  }
}
