import 'dart:convert';

import 'package:famlynk_version1/mvc/model/profile_model/profile_model.dart';
import 'package:famlynk_version1/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class EditProfileService {
  String userId = '';
  Future<dynamic> editProfile(ProfileUserModel data) async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userId') ?? '';
    Map<String, dynamic> editProfile = {
      "name": data.name,
      "gender": data.gender,
      "email": data.email,
      "address ": data.address,
      "maritalStatus": data.maritalStatus,
      "mobileNo": data.mobileNo,
      "profileImage": data.profileImage,
      "dateOfBirth": data.dateOfBirth,
      "hometown": data.hometown,
      // "userId": data.userId,
      "uniqueUserID": data.uniqueUserID
    };
    try {
      var response = await http.put(
        Uri.parse(FamlynkServiceUrl.editProfile + data.userId.toString()),
        body: jsonEncode(editProfile),
        headers: {
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode == 200) {
        print(response.body);
        return response.body;
      } else {
        print("Update request failed with : ${response.statusCode}");
      }
    } catch (e) {
      print(e);
    }
  }
}
