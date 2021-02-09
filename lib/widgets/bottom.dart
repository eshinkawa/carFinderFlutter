import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return (BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: 0,
      items: [
        BottomNavigationBarItem(
          icon: new Icon(Icons.home),
          title: new Text(
            'início',
            style: TextStyle(
              color: Colors.black54,
            ),
          ),
        ),
        BottomNavigationBarItem(
          icon: new Icon(Icons.crop_square),
          title: new Text(
            'meu time',
            style: TextStyle(
              color: Colors.black54,
            ),
          ),
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.today),
            title: Text(
              'agenda',
              style: TextStyle(
                color: Colors.black54,
              ),
            )),
        BottomNavigationBarItem(
            icon: Icon(Icons.format_list_numbered),
            title: Text(
              'tabelas',
              style: TextStyle(
                color: Colors.black54,
              ),
            )),
      ],
    ));
  }
}
