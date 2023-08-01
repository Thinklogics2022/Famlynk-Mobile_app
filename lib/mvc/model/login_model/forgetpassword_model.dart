import 'dart:convert';

ForgetPasswordModel ForgetPasswordModelFromJson(String str) =>
    ForgetPasswordModel.fromJson(json.decode(str));

String ForgetPasswordModelToJson(ForgetPasswordModel data) =>
    json.encode(data.toJson());

class ForgetPasswordModel {
  String? email;
  String? password;

  ForgetPasswordModel({
    this.email,
    this.password,
  });

  factory ForgetPasswordModel.fromJson(Map<String, dynamic> json) =>
      ForgetPasswordModel(
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}
