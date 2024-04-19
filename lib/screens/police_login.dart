import 'dart:convert';
import 'package:cybercops/main_police.dart';
import 'package:cybercops/model/police_data_constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cybercops/model/auth_token.dart';
import 'package:cybercops/screensforjawan/jawan_main_page.dart';
import 'package:lottie/lottie.dart';
// Import UserSession class

class PoliceLogin extends StatefulWidget {
  const PoliceLogin({super.key});

  @override
  _PoliceLoginState createState() => _PoliceLoginState();
}

class _PoliceLoginState extends State<PoliceLogin> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    const String apiUrl = 'http://localhost:3000/api/jawan/login';
    final String email = _emailController.text;
    final String password = _passwordController.text;

    final Map<String, String> data = {
      'email': email,
      'password': password,
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      UserSession.setUserSession(responseData); // Store user session
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Police()),
      );
    } else {
      print('Failed to login: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 450,
                child: Column(children: [
                  Lottie.asset("assets/images/policelogin.json"),
                  const Center(
                    child: Text(
                      '🔐 Please enter your credentials to access the CyberCops Jawan login page 🔐',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Color.fromARGB(255, 0, 2, 3),
                      ),
                    ),
                  ),
                ]),
              ),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _login,
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(color: Colors.blue),
                    ),
                  ),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                  ),
                  textStyle: MaterialStateProperty.all<TextStyle>(
                    const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Text color
                    ),
                  ),
                  elevation: MaterialStateProperty.all<double>(3),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
