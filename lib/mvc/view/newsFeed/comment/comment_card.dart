import 'package:flutter/material.dart';
import 'package:famlynk_version1/mvc/model/newsfeed_model/comment_model.dart';
import 'package:famlynk_version1/services/newsFeedService/commentNewsFeed_service.dart';
import 'package:intl/intl.dart';

class CommentCard extends StatelessWidget {
  final String newsFeedId;

  CommentCard({required this.newsFeedId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<CommentModel>>(
        future: getComments(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            List<CommentModel> commentList = snapshot.data!;
            return ListView.builder(
              itemCount: commentList.length,
              itemBuilder: (context, index) {
                CommentModel comment = commentList[index];

                DateTime? utcDateTime =
                    DateTime.parse(comment.createdOn.toString());
                DateTime localDateTime = utcDateTime.toLocal();

                String formattedDate =
                    DateFormat('MMM-dd-yyyy  hh:mm a').format(localDateTime);

                return Container(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(comment.profilePicture),
                        radius: 18,
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                comment.name,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              ),
                              SizedBox(height: 3),
                              Text(
                                formattedDate,
                                // style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 5),
                              Text(
                                comment.comment,
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        child: Icon(
                          Icons.favorite,
                          size: 15,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Center(child: Text('No comments found.'));
          }
        },
      ),
    );
  }

  Future<List<CommentModel>> getComments() async {
    CommentNewsFeedService commentService = CommentNewsFeedService();
    return await commentService.getComment(newsFeedId);
  }
}
