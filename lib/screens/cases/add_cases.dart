// ignore: file_names
// ignore_for_file: unused_local_variable, unused_import, avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cybercops/model/auth_token.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddCases extends StatefulWidget {
  const AddCases({super.key});

  @override
  State<AddCases> createState() => _AddCasesState();
}

class _AddCasesState extends State<AddCases> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _remarksController = TextEditingController();
  final TextEditingController _completedController = TextEditingController();
  final TextEditingController _assignedJawanController =
      TextEditingController();
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  bool _isLoading = false;

  Future<void> _addCase() async {
    setState(() {
      _isLoading = true;
    });

    const apiUrl = 'http://localhost:3000/api/admin/addcase';

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': AuthToken.jwtToken ?? '',
      },
      body: jsonEncode({
        "title": _titleController.text,
        "caseCategory": _categoryController.text,
        "location": _locationController.text,
        "dateTime": _selectedDate.toIso8601String(),
        "assignedJawan": "65faf3f9fd0b958b7fa97d17",
        "chargeTakenDateTime": _selectedTime.format(context),
        "caseRecords": [],
        "remarks": _remarksController.text,
        "completed": _completedController.text,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      _showSuccessDialog();
    } else {
      print('Failed to add case: ${response.statusCode}');
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Success'),
          content: const Text('Case added successfully!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Case'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildRoundedTextField(
                    controller: _titleController,
                    label: 'Title',
                  ),
                  const SizedBox(height: 20),
                  _buildRoundedTextField(
                    controller: _categoryController,
                    label: 'Case Category',
                  ),
                  const SizedBox(height: 20),
                  _buildRoundedTextField(
                    controller: _locationController,
                    label: 'Location',
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () => _selectDate(context),
                        child: const Text('Select Date'),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () => _selectTime(context),
                        child: const Text('Select Time'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildRoundedTextField(
                    controller: _assignedJawanController,
                    label: 'Assigned Jawan ID',
                  ),
                  const SizedBox(height: 20),
                  _buildRoundedTextField(
                    controller: _remarksController,
                    label: 'Remarks',
                  ),
                  const SizedBox(height: 20),
                  _buildRoundedTextField(
                    controller: _completedController,
                    label: 'Completed',
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: _addCase,
                    child: const Text('Add Case'),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildRoundedTextField({
    required TextEditingController controller,
    required String label,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
