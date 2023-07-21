class RegisterModel {
  RegisterModel({
    this.id,
    this.userId,
    this.uniqueUserId,
    this.name,
    this.gender,
    this.dateOfBirth,
    this.password,
    this.email,
    this.profileImage,
    this.phoneNumber,
    this.address,
    this.coverImage,
    this.hometown,
    this.maritalStatus,
    this.otp,
    this.verificationToken
  });
  String? id;
  String? userId;
  String? uniqueUserId;
  String? name;
  String? gender;
  String? dateOfBirth;
  String? password;
  String? email;
  String? profileImage;
  String? phoneNumber;
  String? address;
  String? hometown;
  String? maritalStatus;
  String? coverImage;
  String? otp;
  String? verificationToken;

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
      id: json['id'],
      uniqueUserId: json['uniqueUserId'],
      userId: json['userId'],
      name: json["name"],
      gender: json["gender"],
      dateOfBirth: json["dateOfBirth"],
      password: json["password"],
      email: json["email"],
      profileImage: json["profileImage"],
      phoneNumber: json["phoneNumber"],
      address: json["address"],
      hometown: json["hometown"],
      maritalStatus: json["maritalStatus"],
      coverImage: json["coverImage"],
      otp: json["otp"],
      verificationToken: json["verificationToken"]
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "uniqueUserId": uniqueUserId,
        "userId": userId,
        "name": name,
        "gender": gender,
        "dateOfBirth": dateOfBirth,
        "password": password,
        "email": email,
        "profileImage": profileImage,
        "phoneNumber": phoneNumber,
        "address" : address,
        "hometown" : hometown,
        "maritalStatus" : maritalStatus,
        "coverImage" : coverImage,
        "otp" : otp,
        "verificationToken" : verificationToken
      };
}
