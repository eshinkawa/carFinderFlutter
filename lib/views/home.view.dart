import 'package:flutter/material.dart';

import '../utils/constants.dart';
import 'history.view.dart';
import 'parking.view.dart';

class HomeView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<HomeView> {
  int _currentIndex = 0;

  final List<Widget> _children = [ParkingView(), HistoryView()];

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
        backgroundColor: Color(0xff372549),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.blueGrey,
        onTap: onTabTapped, // new
        currentIndex: _currentIndex, // new
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: BOTTOM_TAB_HOME,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.query_builder),
            label: BOTTOM_TAB_HISTORIC,
          ),
        ],
      ),
    );
  }
}
