// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:leafguard/screens/WelcomePage.dart';
import 'package:leafguard/screens/onBoardingScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

var prefs;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final showHome = prefs.getBool('viewHome') ?? false;

  runApp(MainApp(showHome: showHome));
}

class MainApp extends StatelessWidget {
  bool showHome;
  MainApp({required this.showHome});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: showHome ? WelcomePage() : OnboardingScreen(),
    );
  }
}
