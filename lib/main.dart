import 'package:flutter/material.dart';
import 'package:focus_buddy/data/constaints.dart';
import 'package:focus_buddy/views/pages/welcome_page.dart';
import 'package:focus_buddy/views/widget_tree.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const App());
}

Future<Widget> _showWelcomePage() async {
  final prefs = await SharedPreferences.getInstance();
  final showWelcomePage = prefs.getBool(KKeys.showWelcomePage);
  if(showWelcomePage != null) {
    return showWelcomePage ? WelcomePage() : WidgetTree();
  }
  
  return WelcomePage();
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: false,
        appBarTheme: KAppBar.appBarTheme(Colors.deepPurpleAccent, Colors.white),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: false,
        appBarTheme: KAppBar.appBarTheme(Colors.deepPurpleAccent, Colors.white),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
      ),
      themeMode: ThemeMode.system,
      home: FutureBuilder(future: _showWelcomePage(), builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: KAppBar.appBar("Caricamento", []),
            body: Center(child: CircularProgressIndicator(),),
          );
        } else if(snapshot.hasError) {
          return Scaffold(
            appBar: KAppBar.appBar('Errore', []),
            body: Center(child: Text('ERRORE'),),
          );
        } else {
          return snapshot.data!;
        }
      }),
    );
  }
}