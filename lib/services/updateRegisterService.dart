import 'dart:convert';
import 'package:famlynk_version1/mvc/view/FamilyTimeLine/profile/updateRegister.dart';
import 'package:http/http.dart' as http;

import '../mvc/model/updateRegisterModel.dart';
import '../utils/utils.dart';


class UpdateRegisterService {
  Future<dynamic> putMethod(UpdateRegisterModel updateRegisterModel) async {
    Map<String, dynamic> mapObj = {
      
      "name" : updateRegisterModel.name,
      "dateOfbirth" : updateRegisterModel.dateOfBirth,
      "gender" : updateRegisterModel.gender,
      "phoneNumber" : updateRegisterModel.phoneNumber,
      "email" : updateRegisterModel.email,
      "password" : updateRegisterModel.password
    };

    try {
      var response = await http.put(
        Uri.parse(FamlynkServiceUrl.updateRegister),
        body: jsonEncode(mapObj),
        headers: {"Content-Type": "application/json ; charset=UTF-8"},
      );

      return response;
    } catch (e) {
      print(e);
    }
  }
}
