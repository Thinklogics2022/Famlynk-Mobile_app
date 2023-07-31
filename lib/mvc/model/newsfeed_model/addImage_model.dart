// To parse this JSON data, do
//
//     final AddImageNewsFeedMode = AddImageNewsFeedModeFromJson(jsonString);

import 'dart:convert';

AddImageNewsFeedMode addImageNewsFeedModeFromJson(String str) =>
    AddImageNewsFeedMode.fromJson(json.decode(str));

String addImageNewsFeedModeToJson(AddImageNewsFeedMode data) =>
    json.encode(data.toJson());

class AddImageNewsFeedMode {
  // String newsFeedId;
  String userId;
  String profilePicture;
  // String vedio;
  final String? photo;
  // int like;
  String description;
  String name;
  // String createdOn;
  // List<dynamic> userLikes;
  // List<dynamic> userLikeNames;
  // dynamic image;
  String uniqueUserID;
  // List<dynamic> mutualConnection;

  AddImageNewsFeedMode({
    // required this.newsFeedId,
    required this.userId,
    required this.profilePicture,
    // required this.vedio,
    this.photo,
    // required this.like,
    required this.description,
    required this.name,
    // required this.createdOn,
    // required this.userLikes,
    // required this.userLikeNames,
    // this.image,
    required this.uniqueUserID,
    // required this.mutualConnection,
  });

  factory AddImageNewsFeedMode.fromJson(Map<String, dynamic> json) =>
      AddImageNewsFeedMode(
        // newsFeedId: json["newsFeedId"],
        userId: json["userId"],
        profilePicture: json["profilePicture"],
        // vedio: json["vedio"],
        photo: json["photo"],
        // like: json["like"],
        description: json["description"],
        name: json["name"],
        // createdOn: json["createdOn"],
        // userLikes: List<dynamic>.from(json["userLikes"].map((x) => x)),
        // userLikeNames: List<dynamic>.from(json["userLikeNames"].map((x) => x)),
        // image: json["image"],
        uniqueUserID: json["uniqueUserID"],
        // mutualConnection: List<dynamic>.from(json["mutualConnection"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        // "newsFeedId": newsFeedId,
        "userId": userId,
        "profilePicture": profilePicture,
        // "vedio": vedio,
        "photo": photo,
        // "like": like,
        "description": description,
        "name": name,
        // "createdOn": createdOn,
        // "userLikes": List<dynamic>.from(userLikes.map((x) => x)),
        // "userLikeNames": List<dynamic>.from(userLikeNames.map((x) => x)),
        // "image": image,
        "uniqueUserID": uniqueUserID,
        // "mutualConnection": List<dynamic>.from(mutualConnection.map((x) => x)),
      };
}
