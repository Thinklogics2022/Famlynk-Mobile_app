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
      this.uniqueUserID,
      this.famid,
      this.secondLevelrelation,
      this.thirdLevelrelation,
      this.createdOn,
      this.modifiedOn,
      this.notification,
      this.maritalStatus,
      this.hometown,
      this.address});
  String userId;
  String name;
  String dob;
  String image;
  String relation;
  String gender;
  String mobileNo;
  String email;
  String? uniqueUserID;
  String? secondLevelrelation;
  String? thirdLevelrelation;
  String? famid;
  String? createdOn;
  String? notification;
  String? maritalStatus;
  String? modifiedOn;
  String? hometown;
  String? address;
  factory AddMemberModel.fromJson(Map<String, dynamic> json) => AddMemberModel(
      userId: json["userId"],
      name: json["name"],
      dob: json["dob"],
      image: json["image"],
      relation: json["relation"],
      gender: json["gender"],
      mobileNo: json["mobileNo"],
      email: json["email"],
      uniqueUserID: json["uniqueUserID"],
      secondLevelrelation: json["secondLevelrelation"],
      thirdLevelrelation: json["thirdLevelrelation"],
      createdOn: json["createdOn"],
      modifiedOn: json["modifiedOn"],
      notification: json["notification"],
      maritalStatus: json["maritalStatus"],
      hometown: json["hometown"],
      address: json["address"],
      famid: json["famid"]);
  Map<String, dynamic> toJson() => {
        "userId": userId,
        "name": name,
        "dob": dob,
        "image": image,
        "relation": relation,
        "gender": gender,
        "mobileNo": mobileNo,
        "email": email,
        "uniqueUserID": uniqueUserID,
        "secondLevelrelation": secondLevelrelation,
        "thirdLevelrelation": thirdLevelrelation,
        "createdOn": createdOn,
        "modifiedOn": modifiedOn,
        "maritalStatus": maritalStatus,
        "notification": notification,
        "hometown": hometown,
        "address": address,
        "famid": famid
      };
}
