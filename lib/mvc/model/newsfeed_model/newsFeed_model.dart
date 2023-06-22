// To parse this JSON data, do
//
//     final newsFeedModel = newsFeedModelFromJson(jsonString);

import 'dart:convert';

NewsFeedModel newsFeedModelFromJson(String str) => NewsFeedModel.fromJson(json.decode(str));

String newsFeedModelToJson(NewsFeedModel data) => json.encode(data.toJson());

class NewsFeedModel {
    String name;
    String newsFeedId;
    String profilePicture;
    String userId;
    String vedio;
    String photo;
    int like;
    String description;
    String createdOn;

    NewsFeedModel({
        required this.name,
        required this.newsFeedId,
        required this.profilePicture,
        required this.userId,
        required this.vedio,
        required this.photo,
        required this.like,
        required this.description,
        required this.createdOn,
    });

    factory NewsFeedModel.fromJson(Map<String, dynamic> json) => NewsFeedModel(
        name: json["name"],
        newsFeedId: json["newsFeedId"],
        profilePicture: json["profilePicture"],
        userId: json["userId"],
        vedio: json["vedio"],
        photo: json["photo"],
        like: json["like"],
        description: json["description"],
        createdOn: json["createdOn"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "newsFeedId": newsFeedId,
        "profilePicture": profilePicture,
        "userId": userId,
        "vedio": vedio,
        "photo": photo,
        "like": like,
        "description": description,
        "createdOn": createdOn,
    };
}
