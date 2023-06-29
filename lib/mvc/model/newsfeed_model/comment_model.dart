class Comment {
  String id;
  String userId;
  String name;
  String profilePicture;
  String newsFeedId;
  String comment;
  DateTime? createdOn;
  DateTime? modifiedOn;

  Comment({
    required this.userId,
    required this.id,
    required this.name,
    required this.profilePicture,
    required this.newsFeedId,
    required this.comment,
    this.createdOn,
    this.modifiedOn
  });
}
