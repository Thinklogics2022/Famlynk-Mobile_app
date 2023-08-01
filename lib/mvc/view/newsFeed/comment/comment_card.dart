import 'package:famlynk_version1/mvc/model/newsfeed_model/comment_model.dart';
import 'package:flutter/material.dart';

class CommentCard extends StatefulWidget {
  const CommentCard({super.key});

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  bool isLoaded = false;
  List<CommentModel>? commentList = [];
  Future<void> _handleRefresh() async {
    setState(() {
      commentList!.cast();
      isLoaded = false;
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _handleRefresh,
      child: isLoaded?ListView.builder(
        itemCount: commentList!.length,
        itemBuilder: (context,index) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage('url'),
                  radius: 18,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Column(
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'this is Sea',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(text: 'See more')
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: Text(
                            "27-11-2022",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
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
        }
      ):Center(
                child: CircularProgressIndicator(),
              ),
    );
  }
}
