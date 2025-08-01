import 'package:flutter/material.dart';
import 'package:focus_buddy/data/classes/services/services.dart';
import 'package:focus_buddy/data/constaints.dart';
import 'package:focus_buddy/views/pages/welcome_page.dart';
import 'package:focus_buddy/views/widget_tree.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    Future.delayed(const Duration(milliseconds: 2500), () async {
      if (!mounted) return;

      bool showWelcomePage = await SharedPreferencesService.showWelcomePage();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              showWelcomePage ? const WelcomePage() : const WidgetTree(),
        ),
      );
    });
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RotationTransition(
              turns: _controller,
              child: Icon(
                Icons.hourglass_top_rounded,
                size: 80,
                color: Colors.deepPurpleAccent,
              ),
            ),
            const SizedBox(height: 20),
            Text('Focus Buddy', style: KTextStyle.titleText()),
          ],
        ),
      ),
    );
  }
}