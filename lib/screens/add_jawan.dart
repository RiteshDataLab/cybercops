// ignore_for_file: unused_local_variable, avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cybercops/model/auth_token.dart';

class AddJawan extends StatefulWidget {
  const AddJawan({super.key});

  @override
  State<AddJawan> createState() => _AddJawanState();
}

class _AddJawanState extends State<AddJawan> {
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _aadharController = TextEditingController();
  final TextEditingController _profilePhotoController = TextEditingController();

  bool _isLoading = false;

  Future<void> _addJawan() async {
    setState(() {
      _isLoading = true;
    });

    const apiUrl = 'http://localhost:3000/api/admin/addjawan';

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': AuthToken.jwtToken ?? '',
      },
      body: jsonEncode({
        "fullname": _fullnameController.text,
        "email": _emailController.text,
        "password": _passwordController.text,
        "phone": _phoneController.text,
        "address": _addressController.text,
        "addharCard": _aadharController.text,
        "profilePhoto": _profilePhotoController.text,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      _showSuccessDialog();
    } else {
      // Handle error response, show error message or retry logic
      print('Failed to add Jawan: ${response.statusCode}');
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
          content: const Text('Jawan added successfully!'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Jawan'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildTextField(_fullnameController, 'Full Name'),
                  const SizedBox(height: 10),
                  _buildTextField(_emailController, 'Email'),
                  const SizedBox(height: 10),
                  _buildTextField(_passwordController, 'Password'),
                  const SizedBox(height: 10),
                  _buildTextField(_phoneController, 'Phone'),
                  const SizedBox(height: 10),
                  _buildTextField(_addressController, 'Address'),
                  const SizedBox(height: 10),
                  _buildTextField(_aadharController, 'Aadhar Card'),
                  const SizedBox(height: 10),
                  _buildTextField(_profilePhotoController, 'Profile Photo'),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _addJawan,
                    child: const Text('Add Jawan'),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
