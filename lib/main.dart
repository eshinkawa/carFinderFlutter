import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(fontFamily: 'IBMPlexSans'),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _selectedFloor;
  String _selectedLetter;
  String _selectedNumber;

  List<DropdownMenuItem<String>> _dropdownFloor() {
    List<String> ddl = ["SS1", "SS2", "SS3"];
    return ddl
        .map((value) => DropdownMenuItem(
              value: value,
              child: Text(value),
            ))
        .toList();
  }

  List<DropdownMenuItem<String>> _dropdownItem() {
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

  bool _allInfoFilled() {
    var floor = _selectedFloor != null;
    var letter = _selectedLetter != null;
    var number = _selectedNumber != null;

    // return '$letter $number no ${floor}';
    return floor && letter && number;
  }

  @override
  Widget build(BuildContext context) {
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
            'Aonde você deixou seu carro?',
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
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(color: Colors.redAccent),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        items: _dropdownFloor(),
                        value: _selectedFloor,
                        hint: Text('Andar',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'IBMPlexSans',
                                fontSize: 22,
                                color: Colors.white)),
                        onChanged: (String value) {
                          _selectedFloor = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(color: Colors.deepOrange),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        items: _dropdownItem(),
                        value: _selectedLetter,
                        hint: Text('Letra',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'IBMPlexSans',
                                fontSize: 22,
                                color: Colors.white)),
                        onChanged: (String value) {
                          _selectedLetter = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(color: Colors.deepPurple),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        items: _dropdownNumber(),
                        value: _selectedNumber,
                        hint: Text('Número',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'IBMPlexSans',
                                fontSize: 22,
                                color: Colors.white)),
                        onChanged: (String value) {
                          _selectedNumber = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 48, 0, 0),
            padding: EdgeInsets.all(24),
            decoration:
                _allInfoFilled() ? BoxDecoration(color: Colors.pink) : null,
            child: _allInfoFilled()
                ? Text(
                    '$_selectedLetter$_selectedNumber no $_selectedFloor',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 80, color: Colors.white),
                  )
                : null,
          )
        ],
      )),
    )));
  }
}
