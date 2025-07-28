import 'package:flutter/material.dart';
import 'package:focus_buddy/data/constaints.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KAppBar.appBar('Settings', []),
      body: Center(child: Text('Settings Page', style: KTextStyle.titleText(),),),
    );
  }
}