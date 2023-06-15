class RegisterModel {
  RegisterModel(
      {required this.name,
      required this.gender,
      required this.dateOfBirth,
      required this.password,
      required this.email,
      // required this.profileImage,
      required this.phoneNumber});

  String name;
  String gender;
  String dateOfBirth;
  String password;
  String email;
  // String profileImage;
  String phoneNumber;

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
        name: json["name"],
        gender: json["gender"],
        dateOfBirth: json["dateOfBirth"],
        password: json["password"],
        email: json["email"],
        // profileImage: json["profileImage"],
        phoneNumber: json["phoneNumber"]
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "gender": gender,
        "dateOfBirth": dateOfBirth,
        "password": password,
        "email": email,
        // "profileImage": profileImage,
        "phoneNumber" : phoneNumber
      };
}
