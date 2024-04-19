import 'package:cybercops/components/onboardingscreen.dart';
import 'package:flutter/material.dart';
import 'package:cybercops/screens/add_jawan.dart';
import 'package:cybercops/screens/cases/add_cases.dart';
import 'package:cybercops/screens/cases/all_cases.dart';
import 'package:cybercops/screens/cases/update_and_delete_cases.dart';
import 'package:cybercops/screensforjawan/jawanlist.dart';
import 'package:cybercops/model/auth_token.dart';
import '../model/globals.dart';

class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  @override
  Widget build(BuildContext context) {
    String email = globalUser?.email ?? 'N/A';
    int phone = globalUser?.phone ?? 0;
    String name = globalUser?.name ?? 'N/A';
    // ignore: unused_local_variable
    String jwtToken = AuthToken.jwtToken ?? 'N/A';

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 12, bottom: 32),
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 10,
                    offset: Offset(2, 2),
                  )
                ],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            name,
                            style: const TextStyle(
                              fontFamily: "NexaRegular",
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 47, 36, 36),
                              fontSize: 30,
                            ),
                          ),
                        ),
                        Text(
                          email,
                          style: const TextStyle(
                            fontFamily: "NexaRegular",
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "$phone",
                          style: const TextStyle(
                            fontFamily: "NexaRegular",
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                children: [
                  _buildGridItem('Add Jawan', 'assets/images/police1.png', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AddJawan()),
                    );
                  }),
                  _buildGridItem('Add Case', 'assets/images/police2.png', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AddCases()),
                    );
                  }),
                  _buildGridItem('All Cases', 'assets/images/police3.png', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AllCases()),
                    );
                  }),
                  _buildGridItem(
                      'Update/Delete Case', 'assets/images/police4.png', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UpdateDeleteCase()),
                    );
                  }),
                  _buildGridItem('View Jawans', 'assets/images/police5.png',
                      () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const JawanList()),
                    );
                  }),
                  _buildGridItem('Logout', 'assets/images/police1.png', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OnBoardingScreen(),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridItem(String title, String imagePath, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              width: 64,
              height: 64,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontFamily: "NexaRegular",
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
