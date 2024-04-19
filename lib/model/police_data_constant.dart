import 'package:flutter/material.dart';

class UserSession {
  static String? jwtToken;
  static String? fullname;
  static String? email;
  static int? phone;
  static String? address;
  static String? aadharCard; // Corrected variable name
  static int? totalCases;
  static int? solvedCases;
  static int? pendingCases;
  static String? profilePhoto;
  static String? userId;

  static void setUserSession(Map<String, dynamic> userData) {
    jwtToken = userData['jwtToken'];
    fullname = userData['user_data']['fullname'];
    email = userData['user_data']['email'];
    phone = userData['user_data']['phone'] as int?;
    address = userData['user_data']['address'];
    // Handling Aadhaar card field
    final aadharCardData = userData['user_data']['addharCard'];
    if (aadharCardData is String) {
      aadharCard = aadharCardData;
    } else if (aadharCardData is int) {
      aadharCard = aadharCardData.toString();
    }
    totalCases = userData['user_data']['totalCases'] as int?;
    solvedCases = userData['user_data']['solvedCases'] as int?;
    pendingCases = userData['user_data']['pendingCases'] as int?;
    profilePhoto = userData['user_data']['profilePhoto'];
    userId = userData['user_data']['_id'];
  }
}
