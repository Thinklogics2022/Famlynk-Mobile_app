

// import 'package:famlynk_version1/mvc/model/familyMembers/famlist_modelss.dart';
// import 'package:famlynk_version1/utils/utils.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

// class FamDetailsService {
//   String token = '';
//   Future<dynamic> famDetails(String userId) async {
//     final prefs = await SharedPreferences.getInstance();
//     token = prefs.getString('token') ?? '';
//     try {
//       http.Response response;
//       response = await http.get(Uri.parse(FamlynkServiceUrl.getFamilyMember + userId),
//           headers: {'Authorization': 'Bearer $token'});
//       dynamic returnObject;
//       if (response.statusCode == 200) {
//         print(response.body);
//         returnObject = famListModelFromJson(response.body);
//       }
//       return returnObject;
//     } catch (e) {
//       print(e);
//     }
//   }
// }
