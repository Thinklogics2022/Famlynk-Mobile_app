// import 'package:famlynk_version1/mvc/model/suggestion_model.dart';
// import 'package:famlynk_version1/utils/utils.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// import 'package:shared_preferences/shared_preferences.dart';

// class SuggestionService {
//   String userId = '';
//   String token = '';

//   Future<List<Suggestion>> getAllSuggestions() async {
//     var url = FamlynkServiceUrl.searchAllUser;
//     final prefs = await SharedPreferences.getInstance();
//     userId = prefs.getString('userId') ?? '';
//     token = prefs.getString('token') ?? '';

//     try {
//       final response = await http.get(
//         Uri.parse('$url$userId'),
//         headers: {'Authorization': 'Bearer $token'},
//       );

//       if (response.statusCode == 200) {
//         final jsonData = json.decode(response.body);

//         if (jsonData != null) {
//           var suggestions = List<Suggestion>.from(
//             jsonData['content'].map((i) => Suggestion.fromJson(i)),
//           );

//           return suggestions;
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

import 'package:famlynk_version1/mvc/model/familyMembers/suggestion_model.dart';
import 'package:famlynk_version1/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SuggestionService {
  String userId = '';
  String token = '';

  Future<List<Suggestion>> getAllSuggestions() async {
    var url = FamlynkServiceUrl.searchAllUser;
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userId') ?? '';
    token = prefs.getString('token') ?? '';

    try {
      final response = await http.get(
        Uri.parse('$url$userId'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        if (jsonData != null && jsonData is List) {
          var suggestions = List<Suggestion>.from(
            jsonData.map((i) => Suggestion.fromJson(i)),
          );

          return suggestions;
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
