import 'dart:convert';
import 'package:famlynk_version1/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../mvc/model/newsfeed_model/newsFeed_model.dart';

class NewsFeedService {
  String token = '';

  Future<dynamic> postNewsFeed(NewsFeedModel newsFeedModel) async {
    var url = FamlynkServiceUrl.newsFeed;
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token') ?? '';

    Map<String, dynamic> obj = {
      "userId": newsFeedModel.userId,
      "name": newsFeedModel.name,
      "newsFeedId": newsFeedModel.newsFeedId,
      "profilePicture": newsFeedModel.profilePicture,
      "createdOn": newsFeedModel.createdOn,
      "vedio": newsFeedModel.vedio,
      "photo": newsFeedModel.photo,
      "like": newsFeedModel.like,
      "description": newsFeedModel.description
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        body: jsonEncode(obj),
        headers: {'Authorization': 'Bearer $token'},
      );
      print(token);
      if (response.statusCode == 200) {
        print('object');
        print(response.body);
        return response.body;
      } else {
        print('post request failed status:${response.statusCode}');
      }
    } catch (e) {
      print(e);
    }
  }
}
