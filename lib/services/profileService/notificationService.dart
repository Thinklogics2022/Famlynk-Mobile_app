import 'dart:convert';
import 'package:famlynk_version1/mvc/model/profile_model/notificationModel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/utils.dart';

class NotificationService {
  String uniqueUserID = "";
  String token = '';

  Future<List<NotificationModel>> notificationService() async {
    var urls = FamlynkServiceUrl.notification;
    final prefs = await SharedPreferences.getInstance();
    uniqueUserID = prefs.getString('uniqueUserID') ?? '';
    token = prefs.getString("token") ?? '';
    try {
      final response = await http.get(
        Uri.parse(urls + uniqueUserID),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        print("notification : ${response.body}");
        
        final jsonData = json.decode(response.body);
        if (jsonData is List) {
          List<NotificationModel> notifications =
              jsonData.map((json) => NotificationModel.fromJson(json)).toList();
          return notifications;
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
