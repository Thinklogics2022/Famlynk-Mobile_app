import 'dart:convert';
import 'package:famlynk_version1/mvc/model/newsfeed_model/familyNewsFeed_model.dart';
import 'package:famlynk_version1/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// class FamilyNewsFeedService {
//   Future<List<FamilyNewsFeedModel>> getFamilyNewsFeed(
//       ) async {
//     final prefs = await SharedPreferences.getInstance();
//     String? userId = prefs.getString('userId');
//     String? token = prefs.getString('token');

//     userId ??= '';
//     token ??= '';

//     var url = FamlynkServiceUrl.getFamilyNewsFeed;
//     try {
//       final response = await http.get(
//         Uri.parse('$url$userId'),
//         headers: {'Authorization': 'Bearer $token'},
//       );

//       if (response.statusCode == 200) {
//         final jsonData = json.decode(response.body);

//         if (jsonData != null) {
//           var familyNewsFeed = List<FamilyNewsFeedModel>.from(
//             jsonData['content'].map((i) => FamilyNewsFeedModel.fromJson(i)),
//           );

//           return familyNewsFeed;
//         } else {
//           throw Exception('Invalid response format: expected a JSON array');
//         }
//       } else {
//         throw Exception('Failed to fetch data from the backend');
//       }
//     } catch (e) {
//       throw Exception('Failed to connect to the server: $e');
//     }
//   }
// }

class FamilyNewsFeedService {
  Future<List<FamilyNewsFeedModel>> getFamilyNewsFeed() async {
    final prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');
    String? token = prefs.getString('token');

    userId ??= '';
    token ??= '';

    var url = FamlynkServiceUrl.getFamilyNewsFeed;
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        if (jsonData != null) {
          var familyNewsFeed = List<FamilyNewsFeedModel>.from(
            jsonData['content'].map((i) => FamilyNewsFeedModel.fromJson(i)),
          );

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
