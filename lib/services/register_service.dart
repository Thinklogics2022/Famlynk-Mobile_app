import 'dart:convert';
import 'package:famlynk_version1/mvc/model/login_model/register_model.dart';
import 'package:http/http.dart' as http;
import '../utils/utils.dart';

class RegisterService {
  Future<dynamic> addRegister(RegisterModel registerModel) async {
    Map<String, dynamic> obj1 = {
      "id": registerModel.id,
      "userId": registerModel.userId,
      "uniqueUserID": registerModel.uniqueUserID,
      "name": registerModel.name,
      "gender": registerModel.gender,
      "dateOfBirth": registerModel.dateOfBirth,
      "password": registerModel.password,
      "email": registerModel.email,
      "profileImage": registerModel.profileImage,
      "mobileNo": registerModel.mobileNo,
      "address": registerModel.address,
      "hometown": registerModel.hometown,
      "maritalStatus": registerModel.maritalStatus,
      "coverImage": registerModel.coverImage,
      "otp": registerModel.otp,
      "verificationToken": registerModel.verificationToken
    };
    try {
      var response = await http.post(
        Uri.parse(FamlynkServiceUrl.createUser),
        body: jsonEncode(obj1),
        headers: {"Content-Type": "application/json ; charset=UTF-8"},
      );
      print(response.body);
      return response.body;
    } catch (e) {
      print(e);
      throw Exception(' Register : Failed to load API Data');
    }
  }
}
