
import 'dart:convert';

NewsFeedModel newsFeedModelFromJson(String str) => NewsFeedModel.fromJson(json.decode(str));

String newsFeedModelToJson(NewsFeedModel data) => json.encode(data.toJson());

class NewsFeedModel {
    String? userId;
    String? vedio;
    String? photo;
    int? like;
    String? description;
    

    NewsFeedModel({
         this.userId,
         this.vedio,
         this.photo,
         this.like,
         this.description,
        
    });

    factory NewsFeedModel.fromJson(Map<String, dynamic> json) => NewsFeedModel(
        userId: json["userId"],
        vedio: json["vedio"],
        photo: json["photo"],
        like: json["like"],
        description: json["description"],
        
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "vedio": vedio,
        "photo": photo,
        "like": like,
        "description": description,
        
    };
}
