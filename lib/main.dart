import 'package:flutter/material.dart';
import 'package:gab_ai/login.dart';
import 'preg/p_homepage.dart';
import 'nutri/n_homepage.dart';
import 'colors.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _navigateToNextPage();
  }

  void _navigateToNextPage() async {
    // Simulate checking login status
    await Future.delayed(const Duration(seconds: 2)); // Simulate loading time
    bool isLoggedIn = false; // Replace with actual login check

    if (isLoggedIn) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  HomePage()));
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  LoginApp()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SystemColors.secondaryColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Center(
            child: Image.asset(
              'assets/BG.png',
              width: constraints.maxWidth * 0.8, // Adjust the width based on screen size
              height: constraints.maxHeight * 0.8, // Adjust the height based on screen size
              fit: BoxFit.contain, // Adjust the image fit
            ),
          );
        },
      ),
    );
  }
}