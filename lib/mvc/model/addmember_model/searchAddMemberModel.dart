import 'dart:convert';

SearchAddMember searchAddMemberFromJson(String str) =>
    SearchAddMember.fromJson(json.decode(str));
String searchAddMemberToJson(SearchAddMember data) =>
    json.encode(data.toJson());

class SearchAddMember {
  String famid;
  String name;
  String gender;
  String dob;
  String email;
  String userId;
  String image;
  String mobileNo;
  String uniqueUserId;
  String relation;
  DateTime? createdOn;
  DateTime? modifiedOn;
  SearchAddMember(
      {required this.famid,
      required this.name,
      required this.gender,
      required this.dob,
      required this.email,
      required this.userId,
      required this.image,
      required this.mobileNo,
      required this.uniqueUserId,
      required this.relation,
      this.createdOn,
      this.modifiedOn});
  factory SearchAddMember.fromJson(Map<String, dynamic> json) {
    return SearchAddMember(
        famid: json["famid"],
        name: json["name"],
        gender: json["gender"],
        dob: json["dob"],
        email: json["email"],
        userId: json["userId"],
        image: json["image"],
        mobileNo: json["mobileNo"],
        uniqueUserId: json["uniqueUserID"],
        relation: json["relation"],
        createdOn: json["createdOn"],
        modifiedOn: json["modifiedOn"]);
  }
  Map<String, dynamic> toJson() => {
        "famid": famid,
        "name": name,
        "gender": gender,
        "dob": dob,
        "email": email,
        "userId": userId,
        "image": image,
        "mobileNo": mobileNo,
        "uniqueUserID": uniqueUserId,
        "relation": relation,
        "createdOn": createdOn,
        "modifiedOn": modifiedOn,
      };
}
