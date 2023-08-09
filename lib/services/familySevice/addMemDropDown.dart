// import 'dart:convert';
// import 'package:famlynk_version1/mvc/model/addmember_model/addMember_model.dart';
// import 'package:famlynk_version1/utils/utils.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

// class DrpDwnAddMembeService {
//   String token = '';
//   Future<dynamic> drpdown(relation) async {
//     var urls = FamlynkServiceUrl.drpdwnAddMember;

//     final prefs = await SharedPreferences.getInstance();
//     token = prefs.getString('token') ?? '';
//     try {
//       final response = await http.get(
//         Uri.parse(urls + relation),
//         headers: {'Authorization': 'Bearer $token'},
//       );
//       if (response.statusCode == 200) {
//         print(response.body);
//         final jsonData = json.decode(response.body);
//         if (jsonData is List) {
//           List<AddMemberModel> dropdown =
//               jsonData.map((json) => AddMemberModel.fromJson(json)).toList();
//           return dropdown;
//         } 
//       } else {
//         throw Exception('Failed to fetch data from the backend');
//       }
//     } catch (e) {
//       throw Exception('Failed to connect to the server: $e');
//     }
//   }
// }
