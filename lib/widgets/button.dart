import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  Button(
      {@required this.text,
      @required this.onPressed,
      @required this.color,
      @required this.showButton});

  final String text;
  final Function onPressed;
  final Color color;
  final bool showButton;

  @override
  Widget build(BuildContext context) {
    return showButton
        ? Container(
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(0, 16, 0, 0),
            child: ElevatedButton(
              child: Container(
                padding: EdgeInsets.all(14),
                child: Text(
                  text,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              onPressed: onPressed,
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(color)),
            ),
          )
        : SizedBox(
            height: 0,
          );
  }
}
