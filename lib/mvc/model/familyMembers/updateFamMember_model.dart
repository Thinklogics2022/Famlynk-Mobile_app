import 'dart:convert';

UpdateFamMemberModel UpdateFamMemberModelFromJson(String str) =>
    UpdateFamMemberModel.fromJson(json.decode(str));

String UpdateFamMemberModelToJson(UpdateFamMemberModel data) =>
    json.encode(data.toJson());

class UpdateFamMemberModel {
  String? famid;
  String? userId;
  String? name;
  String? dob;
  String? image;
  String? relation;
  String? gender;
  String? mobileNo;
  String? email;
  String? uniqueUserID;

  UpdateFamMemberModel({
    this.famid,
    this.userId,
    this.name,
    this.dob,
    this.image,
    this.relation,
    this.gender,
    this.mobileNo,
    this.email,
    this.uniqueUserID,
  });

  factory UpdateFamMemberModel.fromJson(Map<String, dynamic> json) =>
      UpdateFamMemberModel(
        famid: json["famid"],
        userId: json["userId"],
        name: json["name"],
        dob: json["dob"],
        image: json["image"],
        relation: json["relation"],
        gender: json["gender"],
        mobileNo: json["mobileNo"],
        email: json["email"],
        uniqueUserID: json["uniqueUserID"],
      );

  Map<String, dynamic> toJson() => {
        "famid": famid,
        "userId": userId,
        "name": name,
        "dob": dob,
        "image": image,
        "relation": relation,
        "gender": gender,
        "mobileNo": mobileNo,
        "email": email,
        "uniqueUserID": uniqueUserID,
      };
}
