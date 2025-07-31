import 'package:flutter/material.dart';

class KAppBar {
  static AppBarTheme appBarTheme(Color bg_color, Color fg_color) => AppBarTheme(
    color: bg_color,
    foregroundColor: fg_color,
    centerTitle: true,
  );

  static AppBar appBar(String title, List<Widget> actions) => AppBar(
    toolbarHeight: 80,
    title: Text(
      title,
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    ),
    actions: actions,
  );
}

class KTextStyle {
  static TextStyle titleText([Color? color]) => TextStyle(
    color: color ?? Colors.deepPurpleAccent,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
  
  static TextStyle descriptionText() => TextStyle(
    fontSize: 16,
  );
}

class KKeys {
  static final String showWelcomePage = 'showWelcomePage';
}