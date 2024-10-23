import 'package:flutter/material.dart';
import 'package:gab_ai/login.dart';
import 'package:gab_ai/services_supabase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'preg/main_screen.dart';
import 'colors.dart';
import 'theme.dart'; // Import the theme

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseService().initializeSupabase();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme, // Apply the theme here
      home: const SplashScreen(),
      routes: {
        '/login': (context) => const LoginScreen(),
      },
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
    bool isLoggedIn = await _checkLoginStatus();
    if (isLoggedIn) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainScreen()));
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
    }
  }

  Future<bool> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SystemColors.bgColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Center(
            child: Image.asset(
              'assets/icons/fg.png',
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