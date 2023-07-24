import 'package:famlynk_version1/mvc/model/newsfeed_model/publicNewsFeed_model.dart';
import 'package:famlynk_version1/services/publicNewsFeed_service.dart';
import 'package:flutter/material.dart';

class PublicNews extends StatefulWidget {
  const PublicNews({Key? key}) : super(key: key);

  @override
  State<PublicNews> createState() => _PublicNewsState();
}

class _PublicNewsState extends State<PublicNews> {
  bool isLoaded = false;
  int pageNumber = 0;
  int pageSize = 20;
  List<PublicNewsFeedModel>? publicNewsFeedList = [];
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    fetchPublicNewsFeed(pageNumber, pageSize);
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.atEdge &&
        _scrollController.position.pixels != 0) {
      loadMoreSuggestions();
    }
  }

  Future<void> fetchPublicNewsFeed(int pageNumber, int pageSize) async {
    PublicNewsFeedService publicNewsFeedService = PublicNewsFeedService();
    try {
      var newsFeedPublic =
          await publicNewsFeedService.getPublicNewsFeed(pageNumber, pageSize);
      setState(() {
        publicNewsFeedList!.addAll(newsFeedPublic);
        isLoaded = true;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  void loadMoreSuggestions() {
    setState(() {
      pageNumber++;
    });
    fetchPublicNewsFeed(pageNumber, pageSize);
  }

  void onLikeButtonPressed(int index) {
    setState(() {
      publicNewsFeedList![index].isLiked = !publicNewsFeedList![index].isLiked;
      if (publicNewsFeedList![index].isLiked) {
        publicNewsFeedList![index].userLikes.add('your-user-id');
      } else {
        publicNewsFeedList![index].userLikes.remove('your-user-id');
      }
    });
  }

  void addComment(int index, String comment) {
    setState(() {
      publicNewsFeedList![index].comments.add(comment);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoaded
          ? ListView.builder(
              controller: _scrollController,
              itemCount: publicNewsFeedList!.length,
              itemBuilder: (context, index) {
                PublicNewsFeedModel newsFeed = publicNewsFeedList![index];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 20.0,
                              backgroundImage:
                                  AssetImage('assets/images/FL02.png'),
                            ),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(newsFeed.name),
                                SizedBox(height: 10),
                                Text(newsFeed.createdOn.toString()),
                              ],
                            ),
                          ],
                        ),
                        Divider(thickness: 1),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(newsFeed.description),
                            SizedBox(height: 10,),
                            if (newsFeed.photo != null)
                              Image.network(newsFeed.photo!),
                          ],
                        ),

                        Divider(thickness: 1),
                        Container(
                          margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () => onLikeButtonPressed(index),
                                child: Row(
                                  children: [
                                    Icon(
                                      newsFeed.isLiked
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      size: 20.0,
                                      color: newsFeed.isLiked
                                          ? const Color.fromARGB(255, 206, 0, 0)
                                          : null,
                                    ),
                                    SizedBox(width: 5),
                                    Text(newsFeed.likeCount.toString()),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    newsFeed.showAllComments =
                                        !newsFeed.showAllComments;
                                  });
                                },
                                child: Row(
                                  children: [
                                    Text(newsFeed.comments.length.toString()),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Rest of your code
                      ],
                    ),
                  ),
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
