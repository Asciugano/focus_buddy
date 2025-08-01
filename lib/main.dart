import 'package:flutter/material.dart';
import 'package:focus_buddy/data/constaints.dart';
import 'package:focus_buddy/views/splash_screen.dart';
import 'package:focus_buddy/data/classes/services/services.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initAsync();
  }
  
  void _initAsync() async {
    await SharedPreferencesService.getTodo();
  }
  
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _disposeAsync();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if(state == AppLifecycleState.paused || state == AppLifecycleState.inactive) {
    SharedPreferencesService.saveTodo();
    }
    super.didChangeAppLifecycleState(state);
  }

  void _disposeAsync() async {
    await SharedPreferencesService.saveTodo();
  }

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
      home: SplashScreen(),
    );
  }
}