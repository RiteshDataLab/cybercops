import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cybercops/model/auth_token.dart';

class AllCases extends StatefulWidget {
  const AllCases({Key? key}) : super(key: key);

  @override
  State<AllCases> createState() => _AllCasesState();
}

class _AllCasesState extends State<AllCases> {
  late List<Map<String, dynamic>> _casesData = [];

  @override
  void initState() {
    super.initState();
    _fetchCasesData();
  }

  Future<void> _fetchCasesData() async {
    const apiUrl = 'http://localhost:3000/api/admin/cases';

    final response = await http.get(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Authorization': AuthToken.jwtToken ?? '',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      setState(() {
        _casesData = List<Map<String, dynamic>>.from(jsonData['data']);
      });
    } else {
      print('Failed to fetch cases data: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Cases'),
      ),
      body: _casesData.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _casesData.length,
              itemBuilder: (context, index) {
                final caseData = _casesData[index];
                return _buildCaseCard(caseData);
              },
            ),
    );
  }

  Widget _buildCaseCard(Map<String, dynamic> caseData) {
    return Card(
      margin: const EdgeInsets.all(10),
      elevation: 4,
      color: caseData['completed'] == '1' ? Colors.green : Colors.red,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              caseData['title'],
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Category: ${caseData['caseCategory']}',
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            Text(
              'Location: ${caseData['location']}',
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            Text(
              'Date: ${caseData['dateTime']}',
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            // Add more information here as needed
          ],
        ),
      ),
    );
  }
}
