import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class AppBottomNavigationBar extends StatelessWidget {
  final void Function(int?) onDestinationSelected;
  final int currentPageIndex;
  const AppBottomNavigationBar(
      {super.key,
      required this.onDestinationSelected,
      required this.currentPageIndex});

  @override
  Widget build(BuildContext context) {
    return NavigationBarTheme(
      data: NavigationBarThemeData(
        labelTextStyle: MaterialStateProperty.resolveWith<TextStyle>(
          (Set<MaterialState> states) => states.contains(MaterialState.selected)
              ? const TextStyle(color: Colors.white)
              : const TextStyle(color: Colors.grey),
        ),
      ),
      child: NavigationBar(
          height: 80,
          backgroundColor: Colors.black,
          indicatorColor: Colors.transparent,
          surfaceTintColor: Colors.black,
          onDestinationSelected: onDestinationSelected,
          selectedIndex: currentPageIndex,
          destinations: const [
            NavigationDestination(
              icon: Icon(
                Ionicons.home_outline,
                color: Colors.grey,
              ),
              selectedIcon: Icon(Ionicons.home_outline, color: Colors.white),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(
                Ionicons.tv_outline,
                color: Colors.grey,
              ),
              selectedIcon: Icon(Ionicons.tv_outline, color: Colors.white),
              label: 'My List',
            ),
          ]),
    );
  }
}
