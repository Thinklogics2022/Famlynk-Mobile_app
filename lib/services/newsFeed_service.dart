import 'dart:convert';

import 'package:famlynk_version1/mvc/model/newsfeed_model/newsFeed_model.dart';
import 'package:famlynk_version1/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class NewsFeedService {
  String token = '';

  Future<void> postNewsFeed(NewsFeedModel newsFeedModel) async {
    var postNewsFeedUrl = FamlynkServiceUrl.postNewsFeed;
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token') ?? '';
    try {
      final response = await http.post(
        Uri.parse(postNewsFeedUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer $token",
        },
        body: jsonEncode(newsFeedModel.toJson()),
      );
      if (response.statusCode == 200) {
        print('News feed posted successfully');
      } else {
        print('Failed to post news feed');
      }
    } catch (e) {
      print('Exception occurred while posting news feed: $e');
    }
  }
}