import 'dart:convert';
import 'package:famlynk_version1/utils/utils.dart';
import 'package:http/http.dart' as http;
import '../mvc/model/newsFeedModel.dart';

class NewsFeedService {

  List<NewsFeedModel> _posts = [];

  List<NewsFeedModel> get posts => _posts;

  Future<void> fetchPosts() async {
    final response = await http.get(Uri.parse(FamlynkServiceUrl.addMember));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      _posts = jsonData.map((data) => NewsFeedModel.fromJson(data)).toList();
    } else {
      throw Exception('Failed to fetch posts');
    }
  }

  void addPost(NewsFeedModel post) {
    _posts.add(post);
  }

  void deletePost(int index) {
    if (index >= 0 && index < _posts.length) {
      _posts.removeAt(index);
    }
  }
}

