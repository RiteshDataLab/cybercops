import 'dart:convert';
import 'package:cybercops/model/auth_token.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class JawanList extends StatefulWidget {
  const JawanList({super.key});

  @override
  State<JawanList> createState() => _JawanListState();
}

class _JawanListState extends State<JawanList> {
  late List<Map<String, dynamic>> _jawansData = [];

  @override
  void initState() {
    super.initState();
    _fetchJawansData();
  }

  Future<void> _fetchJawansData() async {
    const apiUrl = 'http://localhost:3000/api/admin/jawans';

    final response = await http.get(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Authorization': AuthToken.jwtToken ?? '',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      setState(() {
        _jawansData = List<Map<String, dynamic>>.from(jsonData['data']);
      });
    } else {
      print('Failed to fetch jawans data: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jawan List'),
      ),
      body: _jawansData.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _jawansData.length,
              itemBuilder: (context, index) {
                final jawan = _jawansData[index];
                return _buildJawanCard(jawan);
              },
            ),
    );
  }

  Widget _buildJawanCard(Map<String, dynamic> jawan) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              jawan['fullname'],
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Email: ${jawan['email']}'),
            Text('Total Cases: ${jawan['totalCases']}'),
            Text('Solved Cases: ${jawan['solvedCases']}'),
            Text('Pending Cases: ${jawan['pendingCases']}'),
          ],
        ),
      ),
    );
  }
}
