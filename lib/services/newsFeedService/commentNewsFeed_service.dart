import 'dart:convert';
import 'package:famlynk_version1/mvc/model/newsfeed_model/comment_model.dart';
import 'package:famlynk_version1/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CommentNewsFeedService {
  Future<dynamic> addComment(CommentModel commentModel) async {
    final prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');
    String? token = prefs.getString('token');

    userId ??= '';
    token ??= '';
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
}
