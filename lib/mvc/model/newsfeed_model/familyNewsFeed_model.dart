import 'dart:convert';

FamilyNewsFeedModel familyNewsFeedModelFromJson(String str) =>
    FamilyNewsFeedModel.fromJson(json.decode(str));

String familyNewsFeedModelToJson(FamilyNewsFeedModel data) =>
    json.encode(data.toJson());

class FamilyNewsFeedModel {
  final String userId;
  final String name;
  final String newsFeedId;
  final String? profilePicture;
  final String? createdOn;
  final String? video;
  final String? photo;
  int like;
  final dynamic image;
  final String description;
  final String uniqueUserID;
  List<String> userLikes;
  List<String>? userLikeNames;
  List<dynamic>? mutualConnection;
  bool isLiked;
  List<String> comments;
  bool showAllComments;

  FamilyNewsFeedModel({
    required this.userId,
    required this.name,
    required this.newsFeedId,
    required this.profilePicture,
    this.createdOn,
    this.video,
    this.photo,
    this.image,
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

  factory FamilyNewsFeedModel.fromJson(Map<String, dynamic> json) {
  return FamilyNewsFeedModel(
    userId: json['userId'],
    name: json['name'],
    newsFeedId: json['newsFeedId'],
    profilePicture: json['profilePicture'],
    createdOn: json['createdOn'],
    video: json['video'],
    photo: json['photo'],
    like: json['like'] is int ? json['like'] : int.tryParse(json['like']) ?? 0,
    description: json['description'],
    uniqueUserID: json['uniqueUserID'],
    image: json['image'],
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
      'video': video,
      'photo': photo,
      'like': like,
      'description': description,
      'uniqueUserID': uniqueUserID,
      'userLikes': userLikes,
      'mutualConnection': mutualConnection,
      'userLikeNames': userLikeNames,
      'image': image,
    };
  }
}
