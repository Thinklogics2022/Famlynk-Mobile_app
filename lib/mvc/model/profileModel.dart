// import 'dart:convert';

// List<ProfileModel> profileModelFromJson(String str) => List<ProfileModel>.from(
//     json.decode(str).map((x) => ProfileModel.fromJson(x)));

// String profileModelToJson(List<ProfileModel> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class ProfileModel {
//   String? name;
//   String? profileImage;
//   String? gender;
//   String? dateOfBirth;
//   String? email;

//   ProfileModel({
//     this.name,
//     this.profileImage,
//     this.gender,
//     this.dateOfBirth,
//     this.email,
//   });

//   factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
//         name: json["name"],
//         profileImage: json["profileImage"],
//         gender: json["gender"],
//         dateOfBirth: json["dateOfBirth"],
//         email: json["email"],
//       );

//   Map<String, dynamic> toJson() => {
//         "name": name,
//         "profileImage": profileImage,
//         "gender": gender,
//         "dateOfBirth": dateOfBirth,
//         "email": email,
//       };
// }


class User {
  String id;
  String profileImageUrl;
  String name;
  String email;
  String gender;
  String dob;
  String mobileNumber;

  User({
    required this.id,
    required this.profileImageUrl,
    required this.name,
    required this.email,
    required this.gender,
    required this.dob,
    required this.mobileNumber,
  });
}