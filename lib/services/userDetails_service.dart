// import 'package:famlynk_version1/mvc/model/suggestion_model.dart';
// import 'package:famlynk_version1/utils/utils.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// import 'package:shared_preferences/shared_preferences.dart';

// class UserDetailsService {
//   String token = "";
//   Future<List<Suggestion>> getUserDetails() async {
//     final prefs = await SharedPreferences.getInstance();
//     token = prefs.getString('token') ?? '';
//     try {
//       final response = await http.get(
//         Uri.parse(FamlynkServiceUrl.allUser),
//         headers: {
//           "Content-Type": "application/json",
//           "Authorization": "Bearer $token",
//         },
//       );
//       if (response.statusCode == 200) {
//         final jsonData = json.decode(response.body);
//         if (jsonData is List) {
//           List<Suggestion> userDetails =
//               jsonData.map((json) => Suggestion.fromJson(json)).toList();
//           return userDetails;
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
