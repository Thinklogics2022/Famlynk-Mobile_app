import 'dart:convert';

CommentModel commentModelFromJson(String str) =>
    CommentModel.fromJson(json.decode(str));

String commentModelToJson(CommentModel data) => json.encode(data.toJson());

class CommentModel {
  // String id;
  String userId;
  String name;
  String profilePicture;
  String newsFeedId;
  String comment;
  DateTime? createdOn;
  DateTime? modifiedOn;

  CommentModel({
    required this.userId,
    // required this.id,
    required this.name,
    required this.profilePicture,
    required this.newsFeedId,
    required this.comment,
    this.createdOn,
    this.modifiedOn,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      userId: json['userId'],
      // id: json['id'],
      name: json['name'],
      profilePicture: json['profilePicture'],
      newsFeedId: json['newsFeedId'],
      comment: json['comment'],
      createdOn: json['createdOn'],
      modifiedOn: json['modifiedOn'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      // 'id': id,
      'name': name,
      'profilePicture': profilePicture,
      'newsFeedId': newsFeedId,
      'comment': comment,
      'createdOn': createdOn,
      'modifiedOn': modifiedOn,
    };
  }
}
