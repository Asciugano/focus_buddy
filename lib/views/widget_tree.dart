import 'package:flutter/material.dart';
import 'package:focus_buddy/data/notifiers.dart';
import 'package:focus_buddy/views/pages/home_page.dart';
import 'package:focus_buddy/views/pages/profile_page.dart';
import 'package:focus_buddy/views/widgets/navbar_widget.dart';

List<Widget> pages = [HomePage(), ProfilePage()];

class WidgetTree extends StatelessWidget {
  const WidgetTree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Focus Buddy'),
        actions: [
          IconButton(onPressed: () => print('impostazioni'), icon: Icon(Icons.settings))
        ],
      ),
      bottomNavigationBar: NavbarWidget(),
      body: ValueListenableBuilder(valueListenable: currentPageNotifier, builder: (context, currentPage, child) {
        return pages[currentPageNotifier.value];
      }),
    );
  }
}