
import 'dart:convert';

NewsFeedModel newsFeedModelFromJson(String str) => NewsFeedModel.fromJson(json.decode(str));

String newsFeedModelToJson(NewsFeedModel data) => json.encode(data.toJson());

class NewsFeedModel {
    String userId;
    String vedio;
    String photo;
    String like;
    String description;
    String profilePicture;
    String name;

    NewsFeedModel({
        required this.userId,
        required this.vedio,
        required this.photo,
        required this.like,
        required this.description,
        required this.profilePicture,
        required this.name,
    });

    factory NewsFeedModel.fromJson(Map<String, dynamic> json) => NewsFeedModel(
        userId: json["userId"],
        vedio: json["vedio"],
        photo: json["photo"],
        like: json["like"],
        description: json["description"],
        profilePicture: json["profilePicture"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "vedio": vedio,
        "photo": photo,
        "like": like,
        "description": description,
        "profilePicture": profilePicture,
        "name": name,
    };
}
