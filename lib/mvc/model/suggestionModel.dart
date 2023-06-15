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
  Suggestion({
    this.name,
    this.gender,
    this.dateOfBirth,
    this.email,
    this.maritalStatus,
    this.hometown,
    this.profileImage,
    this.address,
    this.uniqueUserId,
  });
  factory Suggestion.fromJson(Map<String, dynamic> json) {
    return Suggestion(
      name: json["name"],
      gender: json["gender"],
      dateOfBirth:json["dateOfBirth"],
      email: json["email"],
      maritalStatus: json["maritalStatus"],
      hometown: json["hometown"],
      profileImage: json["profileImage"],
      address: json["address"],
      uniqueUserId: json["uniqueUserID"],
    );
  }
  Map<String, dynamic> toJson() => {
        "name": name,
        "gender": gender,
        "dateOfBirth":dateOfBirth,
        "email": email,
        "maritalStatus": maritalStatus,
        "hometown": hometown,
        "profileImage": profileImage,
        "address": address,
        "uniqueUserID": uniqueUserId,
      };
}
