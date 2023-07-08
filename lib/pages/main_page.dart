import 'package:flutter/material.dart';
import 'package:my_team_manager/custom%20widgets/main_layout.dart';

import 'home.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  NavigationRailLabelType labelType = NavigationRailLabelType.all;
  int _selectedIndex = 0;
  List<Widget> pages = [Home(), Text('my players'), Text('Search'), Text('Profile')];



  @override
  Widget build(BuildContext context) {
    return MainLayout(
        body: IndexedStack(
      alignment: Alignment.bottomCenter,
      index: _selectedIndex,
      children: pages,
    ), selectedIndex: _selectedIndex, onDestinationSelected:  (int index) {
      setState(() {
        _selectedIndex = index;
      });
    }, labelType: labelType, title: "My Team Manager");
  }
}
