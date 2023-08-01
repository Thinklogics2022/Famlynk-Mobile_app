import 'dart:convert';
import 'package:famlynk_version1/mvc/model/profile_model/gallery_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/utils.dart';

class ShowGalleryService {
  String userId = "";
  String token = '';
  String uniqueUserID = "";

  Future<List<GalleryNewsFeedModel>> getPhotoList() async {
    var urls = FamlynkServiceUrl.gallery;
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userId') ?? '';
    token = prefs.getString("token") ?? '';
    uniqueUserID = prefs.getString("uniqueUserID") ?? '';
    try {
      final response = await http.get(
        Uri.parse(urls + userId + "/" + uniqueUserID),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData is List) {
          List<GalleryNewsFeedModel> PhotoList = jsonData
              .map((json) => GalleryNewsFeedModel.fromJson(json))
              .toList();
          return PhotoList;
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
