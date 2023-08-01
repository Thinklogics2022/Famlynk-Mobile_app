import 'dart:convert';
import 'package:famlynk_version1/mvc/model/addmember_model/searchAddMember_model.dart';
import 'package:http/http.dart' as http;
import 'package:famlynk_version1/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchAddMemberService {
  String userId = '';
  String token = '';

  Future<dynamic> searchAddMemberPost(
      SearchAddMember searchAddMemberModel) async {
    var urls = FamlynkServiceUrl.searchAddMember;
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userId') ?? '';
    token = prefs.getString('token') ?? '';
    final url = Uri.parse(urls +
        userId +
        "/" +
        searchAddMemberModel.uniqueUserID +
        "/" +
        searchAddMemberModel.relation);

    Map<String, dynamic> requestBody = {
      "famid": searchAddMemberModel.famid,
      "name": searchAddMemberModel.name,
      "gender": searchAddMemberModel.gender,
      "dob": searchAddMemberModel.dob,
      "email": searchAddMemberModel.email,
      "userId": searchAddMemberModel.userId,
      "image": searchAddMemberModel.image,
      "mobileNo": searchAddMemberModel.mobileNo,
      "uniqueUserID": searchAddMemberModel.uniqueUserID,
      "relation": searchAddMemberModel.relation,
      // "createdOn": searchAddMemberModel.createdOn,
      // "modifiedOn": searchAddMemberModel.modifiedOn,
    };

    try {
      print(url);
      final response = await http.post(
        url,
        body: jsonEncode(requestBody),
        headers: {'Authorization': 'Bearer $token'},
      );
      print(response.statusCode);

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('POST request successful');
        // print(response.body);
        return response.body;
      } else {
        print('POST request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
    }
  }
}
