class AddMemberModel {
  AddMemberModel(
      {required this.userId,
      required this.name,
      required this.dob,
      required this.image,
      required this.relation,
      required this.gender,
      required this.mobileNo,
      required this.email,
      required this.uniqueUserID});
  String userId;
  String name;
  String dob;
  String image;
  String relation;
  String gender;
  String mobileNo;
  String email;
  String uniqueUserID;
  factory AddMemberModel.fromJson(Map<String, dynamic> json) => AddMemberModel(
        userId: json["userId"],
        name: json["name"],
        dob: json["dob"],
        image: json["image"],
        relation: json["relation"],
        gender: json["gender"],
        mobileNo: json["mobileNo"],
        email: json["email"],
        uniqueUserID : json["uniqueUserID"]
      );
  Map<String, dynamic> toJson() => {
        "userId": userId,
        "name": name,
        "dob": dob,
        "image": image,
        "relation": relation,
        "gender": gender,
        "mobileNo": mobileNo,
        "email": email,
        "uniqueUserID" : uniqueUserID
      };
}
