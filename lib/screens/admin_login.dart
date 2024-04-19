// ignore_for_file: avoid_print

import 'package:cybercops/main_admin.dart';
import 'package:cybercops/model/auth_token.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'dart:convert';

import '../model/globals.dart';
import '../model/user_model.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AdminLoginState createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    try {
      final response = await adminLogin(
        _emailController.text,
        _passwordController.text,
      );
      print('Response: $response');

      if (response['status'] == 200) {
        final jwtToken = response['jwtToken'] as String;
        AuthToken.setToken(jwtToken); // Set JWT token

        final userData = response['user_data'];
        final user = User.fromJson(userData);
        globalUser = user;

        _showMessageDialog("Login Successful");
        print("Navigating to Admin page...");
        Navigator.push(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(builder: (context) => const Admin()),
        );
      } else {
        _showMessageDialog("Login Failed: ${response['message']}");
      }
    } catch (e) {
      print("Error during login: $e");
      _showMessageDialog("Failed to login: $e");
    }
  }

  void _showMessageDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Login Status"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SingleChildScrollView(
                child: SizedBox(
                  height: 450,
                  child: Column(
                    children: [
                      Lottie.asset(
                          "assets/images/Animation - 1700730664551.json"),
                      const Center(
                        child: Text(
                          '🔐 Please enter your credentials to access the CyberCops admin login page 🔐',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Color.fromARGB(255, 0, 2, 3),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 10.0),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        prefixIcon: const Icon(Icons.email),
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        prefixIcon: const Icon(Icons.lock),
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 50),
                        backgroundColor:
                            const Color.fromARGB(255, 99, 108, 217),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<Map<String, dynamic>> adminLogin(String email, String password) async {
  final response = await http.post(
    Uri.parse('http://localhost:3000/api/admin/login'),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'password': password,
    }),
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to login: ${response.statusCode}');
  }
}
