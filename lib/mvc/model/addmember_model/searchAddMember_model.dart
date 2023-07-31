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
  String uniqueUserID;
  String relation;
  String? createdOn;
  String? modifiedOn;
  // String address;
  // String homeTown;
  SearchAddMember(
      {required this.famid,
      required this.name,
      required this.gender,
      required this.dob,
      required this.email,
      required this.userId,
      required this.image,
      required this.mobileNo,
      required this.uniqueUserID,
      required this.relation,
      // required this.address,
      // required this.homeTown,
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
      uniqueUserID: json["uniqueUserID"],
      relation: json["relation"],
      createdOn: json["createdOn"],
      modifiedOn: json["modifiedOn"],
      // address: json["address"],
      // homeTown : json["homeTown"]
    );
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
        "uniqueUserID": uniqueUserID,
        "relation": relation,
        "createdOn": createdOn,
        "modifiedOn": modifiedOn,
        // "address": address,
        // "homeTown" : homeTown
      };
}
