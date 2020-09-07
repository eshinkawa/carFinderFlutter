import 'package:cade_meu_carro/controllers/parking.controller.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

import '../components/button.dart';
import '../components/dropItem.dart';
import '../components/sign.dart';

import '../utils/constants.dart';

class ParkingView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ParkingState();
}

class ParkingState extends State<ParkingView> {
  String _selectedFloor;
  String _selectedLetter;
  String _selectedNumber;
  String code;
  String timeStamp;
  bool showSaveButton = false;
  ParkingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ParkingController();
    _controller.repository.getDataFromStorage();
  }

  void setDataOnStorage(String propName, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(propName, value);
  }

  void getDataFromStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String codeAsync = prefs.getString('code');
    String timeStampAsync = prefs.getString('timeStamp');
    print(code);
    print(timeStamp);
    setState(() {
      code = codeAsync;
      timeStamp = timeStampAsync;
    });
  }

  void removeDataFromStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('code');
    prefs.remove('timeStamp');
    getDataFromStorage();
  }

  List<DropdownMenuItem<String>> _dropdownFloor() {
    List<String> ddl = ["SS1", "SS2", "SS3"];
    return ddl
        .map((value) => DropdownMenuItem(
              value: value,
              child: Text(value),
            ))
        .toList();
  }

  List<DropdownMenuItem<String>> _dropdownLetter() {
    List<String> ddl = ["A", "B", "C", "D", "E", "F"];
    return ddl
        .map((value) => DropdownMenuItem(
              value: value,
              child: Text(value),
            ))
        .toList();
  }

  List<DropdownMenuItem<String>> _dropdownNumber() {
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

  bool _isAllInfoFilled() {
    var floor = _selectedFloor != null;
    var letter = _selectedLetter != null;
    var number = _selectedNumber != null;
    return floor && letter && number;
  }

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
                _saveData(_selectedLetter, _selectedNumber, _selectedFloor,
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

  void _saveData(
      _selectedLetter, _selectedNumber, _selectedFloor, timeTobeRecorded) {
    setDataOnStorage(
        'code', '$_selectedLetter$_selectedNumber no $_selectedFloor');
    setDataOnStorage('timeStamp', timeTobeRecorded);
    setState(() {
      showSaveButton = false;
    });
    print(showSaveButton);
  }

  void _reset() {
    _selectedFloor = null;
    _selectedLetter = null;
    _selectedNumber = null;
    _selectedNumber = null;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    String timeTobeRecorded = DateFormat('dd/MM/yyyy HH:mm')
        .format(DateTime.parse(DateTime.now().toString()));
    return Scaffold(
        body: Center(
            child: Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Color(0xff2980b9), Color(0xff2c3e50)])),
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            PARKING_TITLE,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 40,
                color: Colors.white,
                letterSpacing: -1,
                fontWeight: FontWeight.w200),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 24, 0, 0),
            child: Theme(
              data: ThemeData.dark(),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  DropItem(
                    isEnabled: code == null,
                    dropHint: 'Andar',
                    items: _dropdownFloor(),
                    selectedValue: _selectedFloor,
                    onChanged: (String value) {
                      _selectedFloor = value;
                      setState(() {});
                    },
                  ),
                  DropItem(
                    isEnabled: code == null,
                    dropHint: 'Letra',
                    items: _dropdownLetter(),
                    selectedValue: _selectedLetter,
                    onChanged: (String value) {
                      _selectedLetter = value;
                      setState(() {});
                    },
                  ),
                  DropItem(
                    isEnabled: code == null,
                    dropHint: 'Número',
                    items: _dropdownNumber(),
                    selectedValue: _selectedNumber,
                    onChanged: (String value) {
                      _selectedNumber = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
          ),
          Sign(
            isAllInfoFilled: _isAllInfoFilled(),
            selectedFloor: _selectedFloor,
            selectedLetter: _selectedLetter,
            selectedNumber: _selectedNumber,
            code: code,
            timeStamp: timeStamp == null ? timeTobeRecorded : timeStamp,
          ),
          Button(
              showButton: _isAllInfoFilled(),
              onPressed: () => {
                    openDialog(context, _selectedLetter, _selectedNumber,
                        _selectedFloor, timeTobeRecorded)
                  },
              text: "Salvar",
              color: Colors.lightBlue),
          Button(
              showButton: true,
              onPressed: () => {_reset(), removeDataFromStorage()},
              text: "Resetar",
              color: Colors.redAccent),
        ],
      )),
    )));
  }
}
