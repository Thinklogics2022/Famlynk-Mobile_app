import 'dart:convert';
import 'package:famlynk_version1/mvc/model/newsfeed_model/comment_model.dart';
import 'package:famlynk_version1/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CommentNewsFeedService {
  String userId = '';
  String token = '';
  Future<dynamic> addComment(CommentModel commentModel) async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userId') ?? '';
    token = prefs.getString('token') ?? '';

    Map<String, dynamic> obj1 = {
      'userId': userId,
      // 'id': commentModel.id,
      'name': commentModel.name,
      'profilePicture': commentModel.profilePicture,
      'newsFeedId': commentModel.newsFeedId,
      'comment': commentModel.comment,
    };

    var url = FamlynkServiceUrl.addComment;
    try {
      final response = await http.post(
        Uri.parse('$url'),
        headers: {
          'Authorization': 'Bearer $token',
          'content-Type': 'application/json'
        },
        body: jsonEncode(obj1),
      );
      if (response.statusCode == 200) {
      } else {
        throw Exception('Failed to add comment');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  }

  Future<List<CommentModel>> getComment(String newsFeedId) async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userId') ?? '';
    token = prefs.getString('token') ?? '';

    var url = FamlynkServiceUrl.getComment + newsFeedId;
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(response.body);
        List<CommentModel> comments =
            jsonData.map((data) => CommentModel.fromJson(data)).toList();
        return comments;
      } else {
        throw Exception(
            'Failed to fetch comments. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  }
}
