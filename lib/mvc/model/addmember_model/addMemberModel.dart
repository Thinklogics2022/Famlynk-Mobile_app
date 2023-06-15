
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
      });
  String userId;
  String name;
  String dob;
  String image;
  String relation;
  String gender;
  String mobileNo;
  String email;

  factory AddMemberModel.fromJson(Map<String, dynamic> json) => AddMemberModel(
      userId: json["userId"],
      name: json["name"],
      dob: json["dob"],
      image: json["image"],
      relation: json["relation"],
      gender: json["gender"],
      mobileNo: json["mobileNo"],
      email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "name": name,
        "dob": dob,
        "image": image,
        "relation": relation,
        "gender": gender,
        "mobileNo": mobileNo,
        "email": email
      };
}