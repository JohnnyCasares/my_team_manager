import 'package:flutter/material.dart';

import '../navigation/nav_bar.dart';

class MainLayout extends StatefulWidget {
  final String title;
  final Widget body;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final NavigationRailLabelType labelType;
  const MainLayout(
      {super.key,
      required this.body,
      required this.selectedIndex,
      required this.onDestinationSelected,
      required this.labelType,
      required this.title});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  Map<String, Icon> menuOptions = const {
    "Home": Icon(Icons.home_outlined),
    "Players": Icon(Icons.compare_arrows),
    "Search": Icon(Icons.saved_search_outlined),
    "Profile": Icon(Icons.person)
  };
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) => Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Center(
              child: Text(
            widget.title,
            style: Theme.of(context).textTheme.displayMedium,
          )),
        ),
        bottomNavigationBar: orientation == Orientation.portrait
            ? BottomNavBar(
                menuParameters: MenuParameters(
                    selectedIndex: widget.selectedIndex,
                    onDestinationSelected: widget.onDestinationSelected,
                    menuOptions: menuOptions),
              )
            : null,
        body: Row(
          children: [
            orientation != Orientation.portrait
                ? SideNavBar(
                    menuParameters: MenuParameters(
                        selectedIndex: widget.selectedIndex,
                        onDestinationSelected: widget.onDestinationSelected,
                        menuOptions: menuOptions,
                        labelType: widget.labelType),
                  )
                : const SizedBox(),
            const VerticalDivider(
              width: 3,
              thickness: 2,
            ),
            Expanded(child: widget.body),
          ],
        ),
      ),
    );
  }
}
