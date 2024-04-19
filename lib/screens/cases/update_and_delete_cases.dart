import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cybercops/model/auth_token.dart';
import 'package:cybercops/screens/cases/all_cases.dart';

class UpdateDeleteCase extends StatefulWidget {
  const UpdateDeleteCase({Key? key}) : super(key: key);

  @override
  _UpdateDeleteCaseState createState() => _UpdateDeleteCaseState();
}

class _UpdateDeleteCaseState extends State<UpdateDeleteCase> {
  List<Map<String, dynamic>> cases = [];

  TextEditingController titleController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController dateTimeController = TextEditingController();
  TextEditingController jawanController = TextEditingController();
  TextEditingController chargeTakenController = TextEditingController();
  TextEditingController remarksController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchCases();
  }

  Future<void> _fetchCases() async {
    final apiUrl = 'http://localhost:3000/api/admin/cases';
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': AuthToken.jwtToken ?? '',
      },
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      if (responseData['data'] != null) {
        setState(() {
          cases = List<Map<String, dynamic>>.from(responseData['data']);
        });
      }
    } else {
      print('Failed to fetch cases: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update/Delete Case'),
      ),
      body: ListView.builder(
        itemCount: cases.length,
        itemBuilder: (context, index) {
          final caseData = cases[index];
          return Card(
            margin: const EdgeInsets.all(8),
            elevation: 4,
            child: ListTile(
              title: Text(
                caseData['title'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              subtitle: Text('Category: ${caseData['caseCategory']}'),
              onTap: () {
                _showActionDialog(caseData);
              },
            ),
          );
        },
      ),
    );
  }

  void _showActionDialog(Map<String, dynamic> caseData) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Update/Delete Case'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController..text = caseData['title'],
                  decoration: const InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  controller: categoryController
                    ..text = caseData['caseCategory'],
                  decoration: const InputDecoration(labelText: 'Category'),
                ),
                TextField(
                  controller: locationController..text = caseData['location'],
                  decoration: const InputDecoration(labelText: 'Location'),
                ),
                TextField(
                  controller: dateTimeController..text = caseData['dateTime'],
                  decoration: const InputDecoration(labelText: 'Date Time'),
                ),
                TextField(
                  controller: jawanController..text = caseData['assignedJawan'],
                  decoration:
                      const InputDecoration(labelText: 'Assigned Jawan'),
                ),
                TextField(
                  controller: chargeTakenController
                    ..text = caseData['chargeTakenDateTime'],
                  decoration:
                      const InputDecoration(labelText: 'Charge Taken DateTime'),
                ),
                TextField(
                  controller: remarksController..text = caseData['remarks'],
                  decoration: const InputDecoration(labelText: 'Remarks'),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _updateCase(caseData);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue),
                      child: const Text('Update'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _deleteCase(caseData);
                      },
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      child: const Text('Delete'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _updateCase(Map<String, dynamic> caseData) async {
    final apiUrl =
        'http://localhost:3000/api/admin/updatecase/${caseData['_id']}';

    Map<String, dynamic> updatedData = {
      "title": titleController.text,
      "caseCategory": categoryController.text,
      "location": locationController.text,
      "dateTime": dateTimeController.text,
      "assignedJawan": jawanController.text,
      "chargeTakenDateTime": chargeTakenController.text,
      "remarks": remarksController.text,
    };

    try {
      final response = await http.put(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': AuthToken.jwtToken ?? '',
        },
        body: jsonEncode(updatedData),
      );

      if (response.statusCode == 200) {
        _fetchCases();
        Navigator.pop(context); // Close dialog
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Case updated successfully'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        print('Failed to update case: ${response.statusCode}');
        final responseData = jsonDecode(response.body);
        if (responseData['message'] != null) {
          print('Error message: ${responseData['message']}');
        }
      }
    } catch (e) {
      print('Error updating case: $e');
    }
  }

  Future<void> _deleteCase(Map<String, dynamic> caseData) async {
    final apiUrl =
        'http://localhost:3000/api/admin/deletecase/${caseData['_id']}';

    try {
      final response = await http.delete(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': AuthToken.jwtToken ?? '',
        },
      );

      if (response.statusCode == 200) {
        _fetchCases();
        Navigator.pop(context); // Close dialog
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Case deleted successfully'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        print('Failed to delete case: ${response.statusCode}');
        final responseData = jsonDecode(response.body);
        if (responseData['message'] != null) {
          print('Error message: ${responseData['message']}');
        }
      }
    } catch (e) {
      print('Error deleting case: $e');
    }
  }
}
