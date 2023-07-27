// import 'package:famlynk_version1/mvc/view/newsFeed/comment_card.dart';
// import 'package:flutter/material.dart';
// import 'package:hexcolor/hexcolor.dart';

// class CommentScreen extends StatefulWidget {
//   const CommentScreen({super.key});

//   @override
//   State<CommentScreen> createState() => _CommentScreenState();
// }

// class _CommentScreenState extends State<CommentScreen> {
//   final TextEditingController commentEditController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Comments"),
//         centerTitle: true,
//       ),
//       body: CommentCard(),
//       bottomNavigationBar: SafeArea(
//         child: Container(
//           height: kTextTabBarHeight,
//           margin:
//               EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
//           padding: EdgeInsets.only(left: 16, right: 8),
//           child: Row(
//             children: [
//               CircleAvatar(
//                 backgroundImage: NetworkImage("url"),
//               ),
//               Expanded(
//                 child: Padding(
//                   padding: EdgeInsets.only(left: 16, right: 8),
//                   child: TextField(
//                     controller: commentEditController,
//                     decoration: InputDecoration(
//                       hintText: 'Comment as anything',
//                       border: InputBorder.none,
//                     ),
//                   ),
//                 ),
//               ),
//               InkWell(
//                 onTap: () {},
//                 child: Container(
//                   padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
//                   child: Text(
//                     'Post',
//                     style: TextStyle(
//                       color: HexColor('#0175C8'),
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:famlynk_version1/mvc/model/newsfeed_model/comment_model.dart';
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
  // CommentNewsFeedService commentService = CommentNewsFeedService();

  // void postComment() async {
  //   String commentText = commentEditController.text.trim();
  //   if (commentText.isNotEmpty) {
  //     try {
  //       String newsFeedId = "";

  //       await commentService.addComment(newsFeedId, commentText);
  //     } catch (e) {
  //       print('Error: $e');
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Comments"),
        centerTitle: true,
      ),
      // body: CommentCard(),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: kTextTabBarHeight,
          margin:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          padding: EdgeInsets.only(left: 16, right: 8),
          child: Row(
            children: [
              CircleAvatar(
                // backgroundImage: NetworkImage("url"),
              ),
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
                onTap: () {
                  CommentNewsFeedService commentService =
                      CommentNewsFeedService();
                  CommentModel commentModel = CommentModel(
                    // id: '',
                    userId: userId,
                    name: name,
                    newsFeedId: widget.newsFeedId,
                    profilePicture: widget.profilePicture,
                    comment: commentEditController.text,
                  );
                  commentService.addComment(commentModel);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: Text(
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
