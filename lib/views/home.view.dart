import 'package:flutter/material.dart';

import '../utils/strings.dart';
import 'history.view.dart';
import 'parking.view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => HomeState();
}

class HomeState extends State<HomeView> {
  int _currentIndex = 0;

  final List<Widget> _children = const [ParkingView(), HistoryView()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        child: _children[_currentIndex],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() => _currentIndex = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.local_parking),
            selectedIcon: Icon(Icons.local_parking, size: 28),
            label: AppStrings.tabHome,
          ),
          NavigationDestination(
            icon: Icon(Icons.schedule),
            selectedIcon: Icon(Icons.schedule, size: 28),
            label: AppStrings.tabHistory,
          ),
        ],
      ),
    );
  }
}
