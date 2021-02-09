import 'package:flutter/material.dart';

class Sign extends StatelessWidget {
  Sign(
      {@required this.isAllInfoFilled,
      @required this.selectedLetter,
      @required this.selectedNumber,
      @required this.selectedFloor,
      @required this.code,
      @required this.timeStamp});

  final bool isAllInfoFilled;
  final String selectedLetter;
  final String selectedNumber;
  final String selectedFloor;
  final String code;
  final String timeStamp;
  @override
  Widget build(BuildContext context) {
    return isAllInfoFilled || code != null
        ? Container(
            margin: EdgeInsets.fromLTRB(0, 24, 0, 0),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xffa3bded),
                      Color(0xff6991c7),
                    ])),
            child: Column(
              children: <Widget>[
                Text(
                  code != null
                      ? code
                      : '$selectedLetter$selectedNumber no $selectedFloor',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 60, color: Colors.white),
                ),
                Text(
                  'Horário: $timeStamp',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                  ),
                )
              ],
            ),
          )
        : Container(height: 0);
  }
}
