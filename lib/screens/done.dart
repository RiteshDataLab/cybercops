import 'package:cybercops/main_admin.dart';
import 'package:cybercops/screens/add_jawan.dart';
import 'package:cybercops/screens/cases/add_cases.dart';
import 'package:cybercops/screens/cases/all_cases.dart';
import 'package:cybercops/screens/cases/update_and_delete_cases.dart';
import 'package:cybercops/screensforjawan/jawanlist.dart';
import 'package:flutter/material.dart';
import 'package:cybercops/model/auth_token.dart';
import '../model/globals.dart';

class Done extends StatefulWidget {
  const Done({super.key});

  @override
  State<Done> createState() => _DoneState();
}

class _DoneState extends State<Done> {
  @override
  Widget build(BuildContext context) {
    // Access user data from globalUser variable
    String email =
        globalUser?.email ?? 'N/A'; // Default to 'N/A' if email is null
    int phone = globalUser?.phone ?? 0;
    String name = globalUser?.name ?? 'N/A'; // Default to 'N/A' if name is null

    // Access JWT token from AuthToken class
    String jwtToken = AuthToken.jwtToken ?? 'N/A';

    return Scaffold(
      appBar: AppBar(
        title: const Text("Done"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Email: $email',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Text(
              'Phone: $phone',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'Name: $name',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Text(
              'JWT Token: $jwtToken',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const JawanList()),
                );
              },
              child: const Text('jawan list'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddJawan()),
                );
              },
              child: const Text('Add Jawan'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AllCases()),
                );
              },
              child: const Text('ALL Cases '),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddCases()),
                );
              },
              child: const Text('ADD Cases '),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UpdateDeleteCase()),
                );
              },
              child: const Text('Update/Delete Case'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Admin()),
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
