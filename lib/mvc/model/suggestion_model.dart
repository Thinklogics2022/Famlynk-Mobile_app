import 'dart:convert';

List<Suggestion> suggestionFromJson(String str) =>
    List<Suggestion>.from(json.decode(str).map((x) => Suggestion.fromJson(x)));

String suggestionToJson(List<Suggestion> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Suggestion {
  String id;
  String userId;
  String name;
  Gender gender;
  String dateOfBirth;
  String password;
  String email;
  DateTime? createdOn;
  DateTime? modifiedOn;
  bool? status;
  Role? role;
  bool? enabled;
  String? verificationToken;
  String? mobileNo;
  String? otp;
  String? profileImage;
  String uniqueUserID;
  String? coverImage;
  String? maritalStatus;
  String? hometown;
  String? address;

  Suggestion({
    required this.id,
    required this.userId,
    required this.name,
    required this.gender,
    required this.dateOfBirth,
    required this.password,
    required this.email,
    required this.createdOn,
    this.modifiedOn,
    required this.status,
    required this.role,
    required this.enabled,
    required this.verificationToken,
    this.mobileNo,
    this.otp,
    this.profileImage,
    required this.uniqueUserID,
    this.coverImage,
    this.maritalStatus,
    this.hometown,
    this.address,
  });

  factory Suggestion.fromJson(Map<String, dynamic> json) {
    return Suggestion(
      id: json["id"].toString(),
      userId: json["userId"].toString(),
      name: json["name"].toString(),
      gender: genderValues.map[json["gender"].toString().toLowerCase()]!,
      dateOfBirth: json["dateOfBirth"].toString(),
      password: json["password"].toString(),
      email: json["email"].toString(),
      createdOn: DateTime.parse(json["createdOn"].toString()),
      modifiedOn: json["modifiedOn"] == null
          ? null
          : DateTime.parse(json["modifiedOn"].toString()),
      status: json["status"] as bool?,
      role: roleValues.map[json["role"].toString().toUpperCase()]!,
      enabled: json["enabled"] as bool?,
      verificationToken: json["verificationToken"].toString(),
      mobileNo: json["mobileNo"].toString(),
      otp: json["otp"].toString(),
      profileImage: json["profileImage"].toString(),
      uniqueUserID: json["uniqueUserID"].toString(),
      coverImage: json["coverImage"].toString(),
      maritalStatus: json["maritalStatus"].toString(),
      hometown: json["hometown"].toString(),
      address: json["address"].toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "name": name,
        "gender": genderValues.reverse[gender],
        "dateOfBirth": dateOfBirth,
        "password": password,
        "email": email,
        "createdOn": createdOn?.toIso8601String(),
        "modifiedOn": modifiedOn?.toIso8601String(),
        "status": status,
        "role": roleValues.reverse[role],
        "enabled": enabled,
        "verificationToken": verificationToken,
        "mobileNo": mobileNo,
        "otp": otp,
        "profileImage": profileImage,
        "uniqueUserID": uniqueUserID,
        "coverImage": coverImage,
        "maritalStatus": maritalStatus,
        "hometown": hometown,
        "address": address,
      };
}

enum Gender { FEMALE, MALE }

final genderValues = EnumValues({"female": Gender.FEMALE, "male": Gender.MALE});

enum Role { USER }

final roleValues = EnumValues({"USER": Role.USER});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
