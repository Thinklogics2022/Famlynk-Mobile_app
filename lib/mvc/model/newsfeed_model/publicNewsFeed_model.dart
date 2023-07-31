import 'dart:convert';

PublicNewsFeedModel publicNewsFeedModelFromJson(String str) =>
    PublicNewsFeedModel.fromJson(json.decode(str));

String publicNewsFeedModelToJson(PublicNewsFeedModel data) =>
    json.encode(data.toJson());

class PublicNewsFeedModel {
  String newsFeedId;
  String userId;
  String profilePicture;
  // String video;
  String? photo;
  int like;
  String description;
  String name;
  DateTime createdOn;
  List<String> userLikes;
  List<String> userLikeNames;
  String uniqueUserID;
  List<dynamic> mutualConnection;

  PublicNewsFeedModel({
    required this.newsFeedId,
    required this.userId,
    required this.profilePicture,
    // required this.video,
    required this.photo,
    required this.like,
    required this.description,
    required this.name,
    required this.createdOn,
    required this.userLikes,
    required this.userLikeNames,
    required this.uniqueUserID,
    required this.mutualConnection,
  });

  factory PublicNewsFeedModel.fromJson(Map<String, dynamic> json) {
    return PublicNewsFeedModel(
      newsFeedId: json['newsFeedId'],
      userId: json['userId'],
      profilePicture: json['profilePicture'],
      // video: json['video'],
      photo: json['photo'],
      like: json['like'],
      description: json['description'],
      name: json['name'],
      createdOn: DateTime.parse(json['createdOn']),
      userLikes: List<String>.from(json['userLikes']),
      userLikeNames: List<String>.from(json['userLikeNames']),
      uniqueUserID: json['uniqueUserID'],
      mutualConnection: List<dynamic>.from(json['mutualConnection']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'newsFeedId': newsFeedId,
      'userId': userId,
      'profilePicture': profilePicture,
      // 'video': video,
      'photo': photo,
      'like': like,
      'description': description,
      'name': name,
      'createdOn': createdOn.toIso8601String(),
      'userLikes': userLikes,
      'userLikeNames': userLikeNames,
      'uniqueUserID': uniqueUserID,
      'mutualConnection': mutualConnection,
    };
  }
}
