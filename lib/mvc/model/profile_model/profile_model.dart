class ProfileUserModel {
  ProfileUserModel(
      {this.id,
      this.userId,
      this.uniqueUserID,
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
      this.mobileNo,
      this.verificationToken});
  String? id;
  String? userId;
  String? uniqueUserID;
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
  String? mobileNo;

  factory ProfileUserModel.fromJson(Map<String, dynamic> json) =>
      ProfileUserModel(
          id: json['id'],
          uniqueUserID: json['uniqueUserID'],
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
          mobileNo: json["mobileNo"],
          verificationToken: json["verificationToken"]);
  Map<String, dynamic> toJson() => {
        "id": id,
        "uniqueUserID": uniqueUserID,
        "userId": userId,
        "name": name,
        "gender": gender,
        "dateOfBirth": dateOfBirth,
        "password": password,
        "email": email,
        "profileImage": profileImage,
        "phoneNumber": phoneNumber,
        "address": address,
        "hometown": hometown,
        "maritalStatus": maritalStatus,
        "coverImage": coverImage,
        "otp": otp,
        "mobileNo" : mobileNo,
        "verificationToken": verificationToken
      };
}

























// class ProfileUserModel {
//   String? name;
//   String? email;
//   String? gender;
//   String? dateOfBirth;
//   String? mobileNo;
//   String? maritalStatus;
//   String? hometown;
//   String? profileImage;
//   String? address;
//   String? uniqueUserID;
//   String? userId;

//   ProfileUserModel(
//       {this.name,
//       this.email,
//       this.gender,
//       this.dateOfBirth,
//       this.mobileNo,
//       this.maritalStatus,
//       this.hometown,
//       this.profileImage,
//       this.address,
//       this.uniqueUserID,
//       this.userId
//       });

//   factory ProfileUserModel.fromJson(Map<String, dynamic> json) {
//     return ProfileUserModel(
//         name: json['name'],
//         email: json['email'],
//         gender: json['gender'],
//         dateOfBirth: json['dateOfBirth'],
//         mobileNo: json['mobileNo'],
//         maritalStatus: json['maritalStatus'],
//         hometown: json['hometown'],
//         profileImage: json['profileImage'],
//         address: json['address'],
//         uniqueUserID: json['uniqueUserID'],
//         userId : json['userId']
//         );
//   }
// }



















// // import 'dart:convert';

// // ProfileUser ProfileUserFromJson(String str) =>
// //     ProfileUser.fromJson(json.decode(str));

// // String ProfileUserToJson(ProfileUser data) => json.encode(data.toJson());

// // class ProfileUser {
// //    ProfileUser(
// //       { this.name,
// //        this.gender,
// //        this.dateOfBirth,
// //        this.email,
// //        this.maritalStatus,
// //        this.hometown,
// //        this.profileImage,
// //        this.address,
// //        this.mobileNo,
// //        this.uniqueUserID,
// //        this.userId});
// //   String? name;
// //   String? gender;
// //   String? dateOfBirth;
// //   String? email;
// //   String? maritalStatus;
// //   String? hometown;
// //   String? profileImage;
// //   String? address;
// //   String? mobileNo;
// //   String? uniqueUserID;
// //   String? userId;

 

// //   factory ProfileUser.fromJson(Map<String, dynamic> json) => ProfileUser(
// //       name: json["name"],
// //       gender: json["gender"],
// //       dateOfBirth: json["dateOfBirth"],
// //       email: json["email"],
// //       maritalStatus: json["maritalStatus"],
// //       hometown: json["hometown"],
// //       profileImage: json["profileImage"],
// //       address: json["address"],
// //       mobileNo: json["mobileNo"],
// //       uniqueUserID: json["uniqueUserID"],
// //       userId: json["userId"]);
// //       Map<String, dynamic> toJson() => {
// //         "name": name,
// //         "gender": gender,
// //         "dateOfBirth": dateOfBirth,
// //         "email": email,
// //         "maritalStatus": maritalStatus,
// //         "hometown": hometown,
// //         "profileImage": profileImage,
// //         "address": address,
// //         "mobileNo": mobileNo,
// //         "uniqueUserID": uniqueUserID,
// //         "userId": userId
// //       };
// // }
























// // // class User {
// // //   String id;
// // //   String profileImageUrl;
// // //   String name;
// // //   String email;
// // //   String gender;
// // //   String dob;
// // //   String mobileNumber;

// // //   User({
// // //     required this.id,
// // //     required this.profileImageUrl,
// // //     required this.name,
// // //     required this.email,
// // //     required this.gender,
// // //     required this.dob,
// // //     required this.mobileNumber,
// // //   });
// // // }



