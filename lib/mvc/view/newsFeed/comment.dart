import 'package:famlynk_version1/mvc/model/newsfeed_model/comment_model.dart';
import 'package:famlynk_version1/mvc/view/newsFeed/comment_card.dart';
import 'package:famlynk_version1/services/newsFeedService/commentNewsFeed_service.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommentScreen extends StatefulWidget {
  CommentScreen({
    super.key,
    required this.name,
    required this.profilePicture,
    required this.newsFeedId,
  });
  String name;
  String profilePicture;
  String newsFeedId;

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final TextEditingController commentEditController = TextEditingController();
  String userId = "";
  String name = "";
  bool isPostingComment = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('userId') ?? '';
      name = prefs.getString('name') ?? '';
    });
  }

  Future<void> postComment() async {
    String commentText = commentEditController.text.trim();
    if (commentText.isNotEmpty) {
      try {
        setState(() {
          isPostingComment = true;
        });

        CommentNewsFeedService commentService = CommentNewsFeedService();
        CommentModel commentModel = CommentModel(
          userId: userId,
          name: name,
          newsFeedId: widget.newsFeedId,
          profilePicture: widget.profilePicture,
          comment: commentText,
        );

        await commentService.addComment(commentModel);
        commentEditController.clear();

        setState(() {
          isPostingComment = false;
        });
      } catch (e) {
        print('Error: $e');
        setState(() {
          isPostingComment = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Comments"),
        centerTitle: true,
      ),
      body: CommentCard(),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: kTextTabBarHeight,
          margin:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          padding: EdgeInsets.only(left: 16, right: 8),
          child: Row(
            children: [
              CircleAvatar(),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 16, right: 8),
                  child: TextField(
                    controller: commentEditController,
                    decoration: InputDecoration(
                      hintText: 'Comment as anything',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: isPostingComment ? null : postComment,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: isPostingComment
                      ? CircularProgressIndicator()
                      : Text(
                          'Post',
                          style: TextStyle(
                            color: HexColor('#0175C8'),
                          ),
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
