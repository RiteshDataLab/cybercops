import 'package:cybercops/screensforjawan/attandance.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cybercops/model/police_data_constant.dart';
import 'package:cybercops/screensforjawan/assigned_cases.dart';
import 'package:cybercops/model/auth_token.dart';

class Police extends StatefulWidget {
  const Police({super.key});

  @override
  State<Police> createState() => _PoliceState();
}

class _PoliceState extends State<Police> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Police Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome, ${UserSession.fullname ?? 'Not available'}',
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            _buildCaseStatus(
              title: 'Total Cases',
              value: '${UserSession.totalCases ?? 'Not available'}',
              color: Colors.blue,
            ),
            _buildCaseStatus(
              title: 'Solved Cases',
              value: '${UserSession.solvedCases ?? 'Not available'}',
              color: Colors.green,
            ),
            _buildCaseStatus(
              title: 'Pending Cases',
              value: '${UserSession.pendingCases ?? 'Not available'}',
              color: Colors.orange,
            ),
            const SizedBox(height: 20),
            _buildGrid(),
          ],
        ),
      ),
    );
  }

  Widget _buildCaseStatus({
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGrid() {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: [
        _buildGridItem(
          text: 'Assigned Cases',
          icon: Icons.assignment,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AssignedCases()),
            );
          },
        ),
        _buildGridItem(
          text: 'Attendance',
          icon: Icons.check_circle_outline,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AttendanceScreen()),
            );
          },
        ),
        // Add more grid items as needed
      ],
    );
  }

  Widget _buildGridItem({
    required String text,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 48,
              color: Colors.blue,
            ),
            const SizedBox(height: 8),
            Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
