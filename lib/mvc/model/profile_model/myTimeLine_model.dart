import 'dart:convert';

MyTimeLineModel myTimeLineModelFromJson(String str) =>
    MyTimeLineModel.fromJson(json.decode(str));

String myTimeLineModelToJson(MyTimeLineModel data) =>
    json.encode(data.toJson());

class MyTimeLineModel {
  String newsFeedId;
  String userId;
  String? profilePicture;
  String? photo;
  int like;
  String? description;
  String name;
  DateTime createdOn;
  List<String> userLikes;
  List<String> userLikeNames;
  String uniqueUserID;
  List<dynamic> mutualConnection;

  MyTimeLineModel({
    required this.newsFeedId,
    required this.userId,
    this.profilePicture,
    required this.photo,
    required this.like,
    this.description,
    required this.name,
    required this.createdOn,
    required this.userLikes,
    required this.userLikeNames,
    required this.uniqueUserID,
    required this.mutualConnection,
  });

  factory MyTimeLineModel.fromJson(Map<String, dynamic> json) {
    return MyTimeLineModel(
      newsFeedId: json['newsFeedId'],
      userId: json['userId'],
      profilePicture: json['profilePicture'],
      photo: json['photo'],
      like:json['like'],
      description: json['description'] != null ? json['description'] : '',
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