import 'dart:convert';

GalleryNewsFeedModel galleryNewsFeedModelFromJson(String str) =>
    GalleryNewsFeedModel.fromJson(json.decode(str));

String galleryNewsFeedModelToJson(GalleryNewsFeedModel data) =>
    json.encode(data.toJson());

class GalleryNewsFeedModel {
  final String userId;
  final String name;
  final String newsFeedId;
  final String profilePicture;
  final String? createdOn;
  // final String vedio;
  final String photo;
  final int like;
  final String description;
  final String uniqueUserID;
  List<String> userLikes;

  GalleryNewsFeedModel({
    required this.userId,
    required this.name,
    required this.newsFeedId,
    required this.profilePicture,
    this.createdOn,
    // required this.vedio,
    required this.photo,
    required this.like,
    required this.description,
    required this.uniqueUserID,
    required this.userLikes,
  });

  factory GalleryNewsFeedModel.fromJson(Map<String, dynamic> json) {
    return GalleryNewsFeedModel(
      userId: json['userId'],
      name: json['name'],
      newsFeedId: json['newsFeedId'],
      profilePicture: json['profilePicture'],
      createdOn: json['createdOn'],
      // vedio: json['vedio'],
      photo: json['photo'],
      like: json['like'],
      description: json['description'],
      uniqueUserID: json['uniqueUserID'],
      userLikes: List<String>.from(json['userLikes']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'newsFeedId': newsFeedId,
      'profilePicture': profilePicture,
      'createdOn': createdOn,
      // 'vedio': vedio,
      'photo': photo,
      'like': like,
      'description': description,
      'uniqueUserID': uniqueUserID,
      'userLikes': userLikes,
    };
  }
}
