import 'package:cybercops/main_police.dart';
import 'package:cybercops/model/police_data_constant.dart';
import 'package:cybercops/screensforjawan/assigned_cases.dart';
import 'package:cybercops/screensforjawan/attandance.dart';
import 'package:flutter/material.dart';
import 'package:cybercops/model/auth_token.dart'; // Import the UserSession class

class JwainMain extends StatefulWidget {
  const JwainMain({super.key});

  @override
  State<JwainMain> createState() => _JwainMainState();
}

class _JwainMainState extends State<JwainMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome to the New Page'),
            Text('Fullname: ${UserSession.fullname ?? 'Not available'}'),
            Text('Email: ${UserSession.email ?? 'Not available'}'),
            Text('JWT Token: ${UserSession.jwtToken ?? 'No token available'}'),
            Text('Phone: ${UserSession.phone ?? 'Not available'}'),
            Text('Address: ${UserSession.address ?? 'Not available'}'),
            Text('Aadhar Card: ${UserSession.aadharCard ?? 'Not available'}'),
            Text('Total Cases: ${UserSession.totalCases ?? 'Not available'}'),
            Text('Solved Cases: ${UserSession.solvedCases ?? 'Not available'}'),
            Text(
                'Pending Cases: ${UserSession.pendingCases ?? 'Not available'}'),
            Text(
                'Profile Photo: ${UserSession.profilePhoto ?? 'Not available'}'),
            ElevatedButton(
              onPressed: () {
                // Navigate to the AssignedCases page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AssignedCases()),
                );
              },
              child: const Text('Go to Assigned Cases'),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to the AssignedCases page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AttendanceScreen()),
                );
              },
              child: const Text('Attandance'),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to the AssignedCases page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Police()),
                );
              },
              child: const Text('main'),
            ),
          ],
        ),
      ),
    );
  }
}
