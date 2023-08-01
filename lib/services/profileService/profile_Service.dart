import 'dart:convert';

import 'package:famlynk_version1/mvc/model/profile_model/profile_model.dart';
import 'package:famlynk_version1/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProfileUserService {
  String userId = '';
  String token = '';
  Future<dynamic> fetchMembersByUserId() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userId') ?? '';
    token = prefs.getString("token") ?? '';
    try {
      http.Response response;
      response = await http.get(
          Uri.parse(FamlynkServiceUrl.profileUser + userId),
          headers: {'Authorization': 'Bearer $token'});
      dynamic returnObject;
      if (response.statusCode == 200) {
        print(response.body);
        returnObject = profileUserModelFromJson(response.body);
      }
      return returnObject;
    } catch (e) {
      print(e);
    }
  }
}