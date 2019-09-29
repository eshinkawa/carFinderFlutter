import 'package:flutter/material.dart';

import './parking.dart';
import './customize.dart';
import './map.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  int _currentIndex = 0;

  final List<Widget> _children = [Parking(), Customize(), Map()];

  @override
  void initState() {
    super.initState();
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex], // new
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.red,
        selectedItemColor: Colors.black54,
        unselectedItemColor: Colors.white,
        onTap: onTabTapped, // new
        currentIndex: _currentIndex, // new
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Início'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.perm_data_setting),
            title: Text('Crie'),
          ),
          new BottomNavigationBarItem(
              icon: Icon(Icons.map), title: Text('Mapa'))
        ],
      ),
    );
  }
}
