import 'package:flutter/material.dart';

import 'package:focus_buddy/data/notifiers.dart';

class NavbarWidget extends StatelessWidget {
  const NavbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentPageNotifier,
      builder: (context, currenPage, child) {
        return NavigationBar(
          destinations: [
            NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
            // NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
            NavigationDestination(icon: Icon(Icons.timer), label: 'Timer'),
            NavigationDestination(icon: Icon(Icons.volume_up), label: 'Souni'),
            NavigationDestination(icon: Icon(Icons.edit), label: 'Diario'),
          ],
          selectedIndex: currenPage,
          onDestinationSelected: (value) {
            currentPageNotifier.value = value;
          },
        );
      },
    );
  }
}