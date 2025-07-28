import 'package:flutter/material.dart';
import 'package:focus_buddy/data/constaints.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Home Page', style: KTextStyle.titleText()));
  }
}
