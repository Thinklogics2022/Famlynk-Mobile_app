class UpdateRegisterModel {
  UpdateRegisterModel(
      {required this.name,
      required this.gender,
      required this.dateOfBirth,
      required this.password,
      required this.email,
      required this.phoneNumber});

  String name;
  String gender;
  String dateOfBirth;
  String password;
  String email;
  String phoneNumber; 

  factory UpdateRegisterModel.fromJson(Map<String, dynamic> json) =>
      UpdateRegisterModel(
          name: json["name"],
          gender: json["gender"],
          dateOfBirth: json["dateOfBirth"],
          password: json["password"],
          email: json["email"],
          phoneNumber: json["phoneNumber"]);

  Map<String, dynamic> toJson() => {
        "name": name,
        "gender": gender,
        "dateOfBirth": dateOfBirth,
        "password": password,
        "email": email,
        "phoneNumber": phoneNumber
      };
}
