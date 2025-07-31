import 'package:flutter/material.dart';
import 'package:focus_buddy/data/constaints.dart';
import 'package:focus_buddy/views/widget_tree.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KAppBar.appBar('Benvenuti', []),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/lotties/welcome.json'),
            FittedBox(
              child: Text(
                'FOCUS BUDDY',
                style: TextStyle(
                  color: Colors.deepPurpleAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 50,
                  letterSpacing: 50,
                ),
              ),
            ),
            Expanded(child: Container()),
            SafeArea(
              child: FilledButton(
                onPressed: () async {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => WidgetTree()),
                    (route) => false,
                  );
                  
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setBool(KKeys.showWelcomePage, false);
                },
                style: FilledButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text('Avanti'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}