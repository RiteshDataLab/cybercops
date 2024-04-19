import 'dart:convert';
import 'package:cybercops/model/police_data_constant.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({Key? key});

  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  String _location = '';
  String _checkInTime = '';
  String _checkOutTime = '';
  bool _isCheckedIn = false;

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  Future<void> _getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      setState(() {
        _location = '${position.latitude}, ${position.longitude}';
      });
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  Future<void> _markAttendance() async {
    try {
      final url = Uri.parse('http://localhost:3000/api/jawan/mark_attendence');
      final response = await http.post(
        url,
        headers: {
          'Authorization': UserSession.jwtToken ?? '',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "jawan_id": "65faf3f9fd0b958b7fa97d17",
          "jawan_name": UserSession.fullname ?? '',
          "date": DateFormat('yyyy-MM-dd').format(DateTime.now()),
          "check_in_detail":
              DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ').format(DateTime.now()),
          "latitude": _location.split(',')[0],
          "longitude": _location.split(',')[1],
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        print(responseData); // Print API response
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Attendance Marked'),
              content: Text(responseData['message']),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        throw Exception('Failed to mark attendance');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Attendance',
          style: TextStyle(
            color: Colors.black, // Changed text color for better visibility
            fontFamily: "NexaRegular",
            fontSize: 26,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              'Welcome, ${UserSession.fullname ?? 'Not available'}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            _buildStatusCard(
              title: 'Total Cases',
              value: '${UserSession.totalCases ?? 'Not available'}',
              color: Colors.blue,
            ),
            _buildStatusCard(
              title: 'Solved Cases',
              value: '${UserSession.solvedCases ?? 'Not available'}',
              color: Colors.green,
            ),
            _buildStatusCard(
              title: 'Pending Cases',
              value: '${UserSession.pendingCases ?? 'Not available'}',
              color: Colors.orange,
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.only(top: 12, bottom: 32),
              height: 150,
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 10,
                    offset: Offset(2, 2),
                  )
                ],
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Check In",
                          style: TextStyle(
                            fontFamily: "NexaRegular",
                            fontWeight: FontWeight.w800,
                            fontSize: 20,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 150,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            _isCheckedIn ? _checkInTime : "--:--:--",
                            style: const TextStyle(
                              fontFamily: "NexaRegular",
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Location",
                          style: TextStyle(
                            fontFamily: "NexaRegular",
                            fontWeight: FontWeight.w800,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          _location.isNotEmpty
                              ? "Location: $_location"
                              : "Location not available",
                          style: const TextStyle(
                            fontFamily: "NexaRegular",
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            StreamBuilder(
              stream: Stream.periodic(const Duration(seconds: 1)),
              builder: (context, snapshot) {
                return Container(
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    text: TextSpan(
                      text: DateFormat('hh:mm:ss a').format(DateTime.now()),
                      style: const TextStyle(
                        color: Color.fromARGB(255, 255, 96, 96),
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.only(top: 12),
              child: Builder(builder: (context) {
                final GlobalKey<SlideActionState> key = GlobalKey();

                return SlideAction(
                  text:
                      _isCheckedIn ? "Slide to Check Out" : "Slide to Check In",
                  key: key,
                  onSubmit: () {
                    if (_isCheckedIn) {
                      _checkOutTime =
                          DateFormat('hh:mm:ss a').format(DateTime.now());
                      print('Checked Out at $_location at $_checkOutTime');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'Checked out at $_location at $_checkOutTime'),
                        ),
                      );
                      setState(() {
                        _isCheckedIn = false; // Update check-in status
                      });
                    } else {
                      _checkInTime =
                          DateFormat('hh:mm:ss a').format(DateTime.now());
                      print('Checked In at $_location at $_checkInTime');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              Text('Checked in at $_location at $_checkInTime'),
                        ),
                      );
                      _markAttendance(); // Call API to mark attendance
                      setState(() {
                        _isCheckedIn = true; // Update check-in status
                      });
                    }
                  },
                );
              }),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard({
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black, // Adjusted to make text more visible
            ),
          ),
          Text(
            value.isNotEmpty ? value : "--:--:--",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black, // Adjusted to make text more visible
            ),
          ),
        ],
      ),
    );
  }
}
