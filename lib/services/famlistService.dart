import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/utils.dart';
import 'package:famlynk_version1/mvc/model/famListModel.dart';

class PostListOfFamilyMemberService {
  String userId = "";
  String token = '';

  Future<List<FamListModel>> getFamilyList() async {
    var urls = FamlynkServiceUrl.getFamilyMember;
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userId') ?? '';
    token = prefs.getString("token") ?? '';
    try {
      final response = await http.get(
        Uri.parse(urls + userId),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData is List) {
          List<FamListModel> familyList =
              jsonData.map((json) => FamListModel.fromJson(json)).toList();
          return familyList;
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