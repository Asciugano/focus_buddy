import 'package:flutter/material.dart';
import 'package:focus_buddy/data/constaints.dart';
import 'package:focus_buddy/views/pages/settings_page.dart';

class SectionFullScreen extends StatelessWidget {
  const SectionFullScreen({
    super.key,
    required this.title,
    required this.list,
    required this.itemBuilder,
    required this.add,
  });

  final String title;
  final List<dynamic> list;
  final Widget Function(dynamic items) itemBuilder;
  final Widget add;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KAppBar.appBar(title, [
        IconButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SettingsPage()),
          ),
          icon: Icon(Icons.settings),
        ),
      ]),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: list.length,
        itemBuilder: (context, index) {
          final dynamic item = list[index];
          return itemBuilder(item);
        },
      ),
      floatingActionButton: add,
    );
  }
}