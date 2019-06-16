import 'package:flutter/material.dart';

class DropItem extends StatelessWidget {
  DropItem(
      {@required this.isEnabled,
      @required this.onChanged,
      @required this.items,
      @required this.selectedValue,
      @required this.dropHint});
  final bool isEnabled;
  final Function onChanged;
  final List<DropdownMenuItem<String>> items;
  final String selectedValue;
  final String dropHint;

  @override
  Widget build(BuildContext context) {
    return isEnabled
        ? Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(color: Colors.redAccent),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                items: items,
                value: selectedValue,
                hint: Text(dropHint,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'IBMPlexSans',
                        fontSize: 22,
                        color: Colors.white)),
                onChanged: onChanged,
              ),
            ),
          )
        : Container(
            height: 0,
          );
  }
}
