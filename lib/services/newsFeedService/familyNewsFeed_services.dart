import 'dart:convert';
import 'package:famlynk_version1/mvc/model/newsfeed_model/familyNewsFeed_model.dart';
import 'package:famlynk_version1/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FamilyNewsFeedService {
  String userId = '';
  String token = '';

  // Future<List<FamilyNewsFeedModel>> getFamilyNewsFeed() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   userId = prefs.getString('userId') ?? '';
  //   token = prefs.getString('token') ?? '';

  //   var url = FamlynkServiceUrl.getFamilyNewsFeed;
  //   try {
  //     final response = await http.get(
  //       Uri.parse(url + userId),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer $token'
  //       },
  //     );
  //     if (response.statusCode == 200) {
  //       final jsonData = json.decode(response.body);
  //       if (jsonData['content'] != null) {
  //         List<FamilyNewsFeedModel> familyNewsFeed =
  //             (jsonData['content'] as List)
  //                 .map((data) => FamilyNewsFeedModel.fromJson(data))
  //                 .toList();
  //         return familyNewsFeed;
  //       } else {
  //         throw Exception('Invalid response format: expected a JSON array');
  //       }
  //     } else {
  //       throw Exception('Failed to fetch data from the backend');
  //     }
  //   } catch (e) {
  //     throw Exception('Failed to connect to the server: $e');
  //   }
  // }

  Future<List<FamilyNewsFeedModel>?> getFamilyNewsFeed() async {
  final prefs = await SharedPreferences.getInstance();
  userId = prefs.getString('userId') ?? '';
  token = prefs.getString('token') ?? '';

  var url = FamlynkServiceUrl.getFamilyNewsFeed;
  try {
    final response = await http.get(
      Uri.parse(url + userId),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      if (jsonData is List) {
        List<FamilyNewsFeedModel> familyNewsFeed =
            jsonData.map((data) => FamilyNewsFeedModel.fromJson(data)).toList();
        return familyNewsFeed;
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
