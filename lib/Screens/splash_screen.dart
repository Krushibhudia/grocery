import 'package:grocery/Screens/authentication/login_screen.dart';
import 'package:grocery/Screens/service/Auth_Service.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'intro_screen.dart';
import 'mainHomeScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _startSplashScreenTimer();
  }

  void _startSplashScreenTimer() {
    // Wait for 3 seconds before performing checks
    Timer(const Duration(seconds: 3), _checkFirstTimeOpen);
  }

  Future<void> _checkFirstTimeOpen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

    if (isFirstTime) {
      // Set isFirstTime to false
      await prefs.setBool('isFirstTime', false);
      _navigateToIntroScreen();
    } else {
      // Check if the user is logged in
      bool isLoggedIn = await AuthService().isUserLoggedIn();
      if (isLoggedIn) {
        _navigateToMainHomeScreen();
      } else {
        _navigateToLoginScreen();
      }
    }
  }

  void _navigateToIntroScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => IntroScreen()),
    );
  }

  void _navigateToMainHomeScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MainHomeScreen()),
    );
  }

  void _navigateToLoginScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const PhoneNumberInputScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade300,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo image
            Image.asset(
              'assets/images/logo.png', // Replace with your logo image URL
              height: MediaQuery.of(context).size.width * 0.5, // Responsive height
              width: MediaQuery.of(context).size.width * 0.5,  // Responsive width
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}
