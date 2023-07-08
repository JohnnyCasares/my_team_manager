import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  final MenuParameters menuParameters;
  const BottomNavBar(
      {super.key, required this.menuParameters,
        });

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  List<BottomNavigationBarItem> _destinations = [];

  @override
  void initState() {
    super.initState();
    // Generate the list of NavigationDestination widgets
    _destinations = widget.menuParameters.menuOptions.entries
        .map((entry) => BottomNavigationBarItem(
      icon: entry.value,
      label: entry.key,
    ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type:_destinations.length>3? BottomNavigationBarType.fixed:null,
        currentIndex: widget.menuParameters.selectedIndex,
        onTap: widget.menuParameters.onDestinationSelected,
        items: _destinations);
  }
}//end of bottom nav bar


class SideNavBar extends StatefulWidget {
  final MenuParameters menuParameters;
  const SideNavBar(
      {super.key, required this.menuParameters,
       });

  @override
  State<SideNavBar> createState() => _SideNavBarState();
}

class _SideNavBarState extends State<SideNavBar> {
  List<NavigationRailDestination> _destinations = [];
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _destinations = widget.menuParameters.menuOptions.entries
        .map((entry) => NavigationRailDestination(
      icon: entry.value,
      label: Text(entry.key),
    ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
        selectedIndex: widget.menuParameters.selectedIndex,
        onDestinationSelected: widget.menuParameters.onDestinationSelected,
        minWidth: 5,
        labelType: widget.menuParameters.labelType,
        destinations: _destinations);
  }
}

class MenuParameters{
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final Map<String, Icon> menuOptions;
  final NavigationRailLabelType? labelType;
  MenuParameters(
      {required this.selectedIndex,
      required this.onDestinationSelected,
      required this.menuOptions,
      this.labelType});
}