import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/cursor_widget.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Cyber Cops',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 4,
        actions: [
          PopupMenuButton<String>(
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'admin',
                  child: Text('Login as Admin'),
                ),
                const PopupMenuItem<String>(
                  value: 'police',
                  child: Text('Login as Police'),
                ),
              ];
            },
            onSelected: (String value) {
              // Handle selection based on value
              if (value == 'admin') {
                Navigator.pushNamed(context, '/adminLogin');
              } else if (value == 'police') {
                Navigator.pushNamed(context, '/PoliceLogin');
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 5),
          Center(child: CursorWidget()),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              children: [
                _buildGridItem(
                  context,
                  'National Cyber Crime Reporting Portal',
                  'https://cybervolunteer.mha.gov.in/webform/Volunteer_AuthoLogin.aspx',
                  Icons.security,
                  Colors.blue,
                ),
                _buildGridItem(
                  context,
                  'Request for blocking lost/stolen mobile',
                  'https://www.ceir.gov.in/Request/CeirUserBlockRequestDirect.jsp',
                  Icons.phone_android,
                  Colors.green,
                ),
                _buildGridItem(
                  context,
                  'National Cybercrime Reporting Portal (NCRP)',
                  'https://i4c.mha.gov.in/ncrp.aspx',
                  Icons.report,
                  Colors.orange,
                ),
                _buildGridItem(
                  context,
                  'Internet Crime Complaint Center',
                  'https://www.ic3.gov/',
                  Icons.dangerous,
                  const Color.fromARGB(255, 98, 0, 255),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _openChatbot(context);
        },
        child: const Icon(Icons.chat),
      ),
    );
  }

  Widget _buildGridItem(BuildContext context, String title, String url,
      IconData icon, Color color) {
    return GestureDetector(
      onTap: () => _openWebPage(context, url),
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: color.withOpacity(0.8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40,
              color: Colors.white,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openChatbot(BuildContext context) async {
    const url =
        'https://mediafiles.botpress.cloud/5365e88e-1fd7-463d-a05b-b65f2a848a2e/webchat/bot.html';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }

  void _openWebPage(BuildContext context, String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }
}
