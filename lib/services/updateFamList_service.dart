import 'dart:convert';
import 'package:famlynk_version1/mvc/model/updateFamMember_model.dart';
import 'package:famlynk_version1/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class UpdateFamListService {
  String token = "";
  Future<dynamic> putMethod(UpdateFamMemberModel data) async {
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token') ?? '';
    Map<String, dynamic> updatefam = {
      "name": data.name,
      "gender": data.gender,
      "mobileNo": data.mobileNo,
      "email": data.email,
      "relation": data.relation,
      "dob": data.dob,
      "image": data.image,
      "famid": data.famid
    };

    try {
      var response = await http.put(
        Uri.parse(FamlynkServiceUrl.updateFamilyMember + data.famid.toString()),
        body: jsonEncode(updatefam),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      print(token);

      if (response.statusCode == 200 || response.statusCode == 202) {
        print('updated sucessfully');
        print(response.request);
        return response;
      } else {
        print("Update request failed with : ${response.statusCode}");
      }
    } catch (e) {
      print(e);
    }
  }
}
