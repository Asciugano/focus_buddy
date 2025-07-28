import 'package:flutter/material.dart';
import 'package:focus_buddy/data/constaints.dart';
import 'package:focus_buddy/data/notifiers.dart';
import 'package:focus_buddy/views/pages/home_page.dart';
// import 'package:focus_buddy/views/pages/profile_page.dart';
import 'package:focus_buddy/views/pages/settings_page.dart';
import 'package:focus_buddy/views/pages/sounds_page.dart';
import 'package:focus_buddy/views/pages/stats_page.dart';
import 'package:focus_buddy/views/pages/timer_page.dart';
import 'package:focus_buddy/views/widgets/navbar_widget.dart';

const List<Widget> pages = [
  HomePage(),
  // ProfilePage(),
  TimerPage(),
  SoundsPage(),
  StatsPage(),
];

class WidgetTree extends StatelessWidget {
  const WidgetTree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KAppBar.appBar('Focus Buddy', [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SettingsPage()),
            ),
            icon: Icon(Icons.settings),
          ),
      ]),
      // appBar: AppBar(
      //   toolbarHeight: 80,
      //   title: const Text('Focus Buddy', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
      //   actions: [
      //     IconButton(
      //       onPressed: () => Navigator.push(
      //         context,
      //         MaterialPageRoute(builder: (context) => SettingsPage()),
      //       ),
      //       icon: Icon(Icons.settings),
      //     ),
      //   ],
      // ),
      bottomNavigationBar: NavbarWidget(),
      body: ValueListenableBuilder(
        valueListenable: currentPageNotifier,
        builder: (context, currentPage, child) {
          return pages[currentPageNotifier.value];
        },
      ),
    );
  }
}