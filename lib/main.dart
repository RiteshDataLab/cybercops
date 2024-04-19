import 'package:cybercops/screensforjawan/attandance.dart';
import 'package:flutter/material.dart';
import 'package:cybercops/screens/admin_login.dart'; // Import your admin login screen
import 'package:cybercops/screens/police_login.dart';

import 'components/onboardingscreen.dart'; // Import your police login screen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Police App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const OnBoardingScreen(),
        '/adminLogin': (context) => const AdminLogin(),
        '/PoliceLogin': (context) => const PoliceLogin(),
      },
      onUnknownRoute: (settings) {
        // Handle unknown routes here, for example:
        return MaterialPageRoute(
            builder: (context) => const AttendanceScreen());
      },
    );
  }
}
