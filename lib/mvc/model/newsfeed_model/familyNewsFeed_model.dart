import 'dart:convert';

List<FamilyNewsFeedModel> familyNewsFeedModelFromJson(String str) =>
    List<FamilyNewsFeedModel>.from(
        json.decode(str).map((x) => FamilyNewsFeedModel.fromJson(x)));

String familyNewsFeedModelToJson(List<FamilyNewsFeedModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FamilyNewsFeedModel {
  String newsFeedId;
  String userId;
  dynamic profilePicture;
  dynamic vedio;
  String? photo;
  int like;
  String description;
  String name;
  DateTime createdOn;
  List<String> userLikes;
  List<String> userLikeNames;
  dynamic image;
  String uniqueUserID;
  List<dynamic> mutualConnection;

  FamilyNewsFeedModel({
    required this.newsFeedId,
    required this.userId,
    this.profilePicture,
    this.vedio,
    this.photo,
    required this.like,
    required this.description,
    required this.name,
    required this.createdOn,
    required this.userLikes,
    required this.userLikeNames,
    this.image,
    required this.uniqueUserID,
    required this.mutualConnection,
  });

  factory FamilyNewsFeedModel.fromJson(Map<String, dynamic> json) =>
      FamilyNewsFeedModel(
        newsFeedId: json["newsFeedId"],
        userId: json["userId"],
        profilePicture: json["profilePicture"],
        vedio: json["vedio"],
        photo: json["photo"],
        like: json["like"],
        description: json["description"],
        name: json["name"],
        createdOn: DateTime.parse(json["createdOn"]),
        userLikes: List<String>.from(json["userLikes"].map((x) => x)),
        userLikeNames: List<String>.from(json["userLikeNames"].map((x) => x)),
        image: json["image"],
        uniqueUserID: json["uniqueUserID"],
        mutualConnection:
            List<dynamic>.from(json["mutualConnection"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "newsFeedId": newsFeedId,
        "userId": userId,
        "profilePicture": profilePicture,
        "vedio": vedio,
        "photo": photo,
        "like": like,
        "description": description,
        "name": name,
        "createdOn": createdOn.toIso8601String(),
        "userLikes": List<dynamic>.from(userLikes.map((x) => x)),
        "userLikeNames": List<dynamic>.from(userLikeNames.map((x) => x)),
        "image": image,
        "uniqueUserID": uniqueUserID,
        "mutualConnection": List<dynamic>.from(mutualConnection.map((x) => x)),
      };
}
