// // import 'package:famlynk_version1/mvc/model/profile_model/profile_model.dart';

// // class ProfileService {
// //   Future<User> fetchUserProfile(String userId) async {
// //     await Future.delayed(Duration(seconds: 2));

// //     return User(
// //       id: userId,
// //       profileImageUrl: 'assets/profile_image.png',
// //       name: 'John Doe',
// //       email: 'johndoe@example.com',
// //       gender: 'Male',
// //       dob: '1990-01-01',
// //       mobileNumber: '+1234567890',
// //     );
// //   }


import 'dart:convert';
import 'package:famlynk_version1/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../mvc/model/profile_model/profile_model.dart';
// import 'MemberModel.dart';
class ProfileUserService {
  String userId = "";
  String token = '';
  Future<List<ProfileUserModel>> fetchMembersByUserId() async {
    var urls = FamlynkServiceUrl.profileUser;
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userId') ?? '';
    token = prefs.getString("token") ?? '';
    try {
      final response = await http.get(Uri.parse(urls + userId),
          headers: {'Authorization': 'Bearer $token'});
      if (response.statusCode == 200) {
        print(response.body);
        final jsonData = json.decode(response.body);
        if (jsonData is List) {
          List<ProfileUserModel> members =
              jsonData.map((json) => ProfileUserModel.fromJson(json)).toList();
          return members;
        } else {
          throw Exception('Invalid response format: expected a JSON array');
        }
      } else {
        throw Exception('Failed to fetch data from the backend');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  }
}
