

import 'dart:convert';

PublicNewsFeedModel publicNewsFeedModelFromJson(String str) =>
    PublicNewsFeedModel.fromJson(json.decode(str));

String publicNewsFeedModelToJson(PublicNewsFeedModel data) =>
    json.encode(data.toJson());

// Model class representing a single news feed item
class PublicNewsFeedModel {
  final String userId;
  final String name;
  final String newsFeedId;
  final String? profilePicture;
  final String? createdOn;
  final String? vedio;
  final String? photo;
  int like;
  final String description;
  final String uniqueUserID;
  List<String> userLikes;
  List<String>? userLikeNames;
  List<dynamic>? mutualConnection;
  bool isLiked;
  List<String> comments;
  bool showAllComments;

  PublicNewsFeedModel({
    required this.userId,
    required this.name,
    required this.newsFeedId,
    required this.profilePicture,
    this.createdOn,
    this.vedio,
    this.photo,
  
    required this.like,
    required this.description,
    required this.uniqueUserID,
    required this.userLikes,
    this.userLikeNames,
    this.mutualConnection,
    this.isLiked = false,
    this.comments = const [],
    this.showAllComments = false,
  });

  int get likeCount => userLikes.length;

  factory PublicNewsFeedModel.fromJson(Map<String, dynamic> json) {
    return PublicNewsFeedModel(
      userId: json['userId'],
      name: json['name'],
      newsFeedId: json['newsFeedId'],
      profilePicture: json['profilePicture'],
      createdOn: json['createdOn'],
      vedio: json['vedio'],
      photo: json['photo'],
      like: json['like'],
      description: json['description'],
      uniqueUserID: json['uniqueUserID'],

      userLikes: List<String>.from(json['userLikes']),
      mutualConnection: List<dynamic>.from(json['mutualConnection'] ?? []),
      userLikeNames: List<String>.from(json['userLikeNames'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'newsFeedId': newsFeedId,
      'profilePicture': profilePicture,
      'createdOn': createdOn,
      'vedio': vedio,
      'photo': photo,
      'like': like,
      'description': description,
      'uniqueUserID': uniqueUserID,
      'userLikes': userLikes,
      'mutualConnection': mutualConnection,
      'userLikeNames': userLikeNames,

    };
  }
}
