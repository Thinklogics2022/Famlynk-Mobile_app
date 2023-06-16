import 'dart:convert';

Suggestion suggestionFromJson(String str) =>
    Suggestion.fromJson(json.decode(str));
String suggestionToJson(Suggestion data) => json.encode(data.toJson());

class Suggestion {
  String? name;
  String? gender;
  String? dateOfBirth;
  String? email;
  String? maritalStatus;
  String? hometown;
  String? profileImage;
  String? address;
  String? uniqueUserId;
  String? mobileNo;
  Suggestion({
    required this.name,
    required this.gender,
    required this.dateOfBirth,
    required this.email,
    required this.maritalStatus,
    required this.hometown,
    required this.profileImage,
    required this.address,
    required this.uniqueUserId,
    required this.mobileNo,
  });
  factory Suggestion.fromJson(Map<String, dynamic> json) {
    return Suggestion(
      name: json["name"],
      gender: json["gender"],
      dateOfBirth: json["dateOfBirth"],
      email: json["email"],
      maritalStatus: json["maritalStatus"],
      hometown: json["hometown"],
      profileImage: json["profileImage"],
      address: json["address"],
      uniqueUserId: json["uniqueUserID"],
      mobileNo: json["mobileNo"],
    );
  }
  Map<String, dynamic> toJson() => {
        "name": name,
        "gender": gender,
        "dateOfBirth": dateOfBirth,
        "email": email,
        "maritalStatus": maritalStatus,
        "hometown": hometown,
        "profileImage": profileImage,
        "address": address,
        "uniqueUserID": uniqueUserId,
        "mobileNo": mobileNo
      };
}
