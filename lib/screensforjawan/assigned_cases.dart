import 'dart:convert';
import 'package:cybercops/model/police_data_constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AssignedCases extends StatefulWidget {
  const AssignedCases({super.key});

  @override
  State<AssignedCases> createState() => _AssignedCasesState();
}

class _AssignedCasesState extends State<AssignedCases> {
  List<dynamic> _assignedCases = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchAssignedCases();
  }

  Future<void> _fetchAssignedCases() async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://localhost:3000/api/jawan/jawancases/65faf3f9fd0b958b7fa97d17'),
        headers: {
          'Authorization': UserSession.jwtToken ?? 'No token available',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        setState(() {
          _assignedCases = responseData['data'];
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to fetch assigned cases');
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  // String getToken() {
  //   // Implement method to get token from AuthToken class or wherever it's stored
  //   return 'your_jwt_token_here';
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assigned Cases'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _assignedCases.length,
              itemBuilder: (context, index) {
                final caseData = _assignedCases[index];
                return _buildCaseCard(caseData);
              },
            ),
    );
  }

  Widget _buildCaseCard(Map<String, dynamic> caseData) {
    Color backgroundColor =
        caseData['completed'] == '1' ? Colors.green : Colors.red;
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 4,
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              caseData['title'],
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(height: 8),
            Text(
              'Category: ${caseData['caseCategory']}',
              style: TextStyle(color: Colors.white),
            ),
            Text(
              'Location: ${caseData['location']}',
              style: TextStyle(color: Colors.white),
            ),
            Text(
              'Assigned Date: ${caseData['dateTime']}',
              style: TextStyle(color: Colors.white),
            ),
            // Add more data as needed
          ],
        ),
      ),
    );
  }
}
