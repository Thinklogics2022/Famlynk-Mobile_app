import 'dart:convert';
import 'package:famlynk_version1/mvc/model/login_model/register_model.dart';
import 'package:http/http.dart' as http;
import '../utils/utils.dart';

class RegisterService {

  Future<dynamic> AddPostMethod(RegisterModel registerModel) async {
    Map<String, dynamic> obj1 = {
      "name": registerModel.name,
      "gender": registerModel.gender,
      "dateOfBirth": registerModel.dateOfBirth,
      "password": registerModel.password,
      "email": registerModel.email,                
       // "profileImage": registerModel.profileImage,
      "phoneNumber": registerModel.phoneNumber

    };
    try {
      var response = await http.post(
        Uri.parse(FamlynkServiceUrl.createUser),
        body: jsonEncode(obj1),
        headers: {"Content-Type": "application/json ; charset=UTF-8"},
      );
      // print(response.body);
      return response.body;
    } catch (e) {
      print(e);
      throw Exception('Failed to load API Data'); 
    }
  }
}
