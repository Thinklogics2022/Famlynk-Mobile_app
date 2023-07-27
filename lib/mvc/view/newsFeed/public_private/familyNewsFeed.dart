import 'package:cached_network_image/cached_network_image.dart';
import 'package:famlynk_version1/mvc/model/newsfeed_model/familyNewsFeed_model.dart';
import 'package:famlynk_version1/services/newsFeedService/familyNewsFeed_services.dart';
import 'package:flutter/material.dart';

class FamilyNews extends StatefulWidget {
  const FamilyNews({Key? key}) : super(key: key);

  @override
  State<FamilyNews> createState() => _FamilyNewsState();
}

class _FamilyNewsState extends State<FamilyNews> {
  bool isLoaded = false;
  
  List<FamilyNewsFeedModel>? familyNewsFeedList = [];
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    fetchPublicNewsFeed();
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
    }
  }

  Future<void> fetchPublicNewsFeed() async {
    FamilyNewsFeedService familyNewsFeedService = FamilyNewsFeedService();
    try {
      var newsFeedFamily =
          await familyNewsFeedService.getFamilyNewsFeed();
      setState(() {
        familyNewsFeedList!.addAll(newsFeedFamily);
        isLoaded = true;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  

  void onLikeButtonPressed(int index) {
    setState(() {
      familyNewsFeedList![index].isLiked = !familyNewsFeedList![index].isLiked;
      if (familyNewsFeedList![index].isLiked) {
        familyNewsFeedList![index].userLikes.add('your-user-id');
      } else {
        familyNewsFeedList![index].userLikes.remove('your-user-id');
      }
    });
  }

  void addComment(int index, String comment) {
    setState(() {
      familyNewsFeedList![index].comments.add(comment);
    });
  }
  
  Future<void> _handleRefresh() async {
    setState(() {
      familyNewsFeedList!.clear();
      isLoaded = false;
    });
    await fetchPublicNewsFeed();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color.fromARGB(255, 223, 228, 237),
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: isLoaded
            ? ListView.builder(
                controller: _scrollController,
                itemCount: familyNewsFeedList!.length,
                itemBuilder: (context, index) {
                  FamilyNewsFeedModel newsFeed = familyNewsFeedList![index];
                  return Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            backgroundImage: AssetImage('assets/images/FL02.png'),
                          ),
                          title: Text(newsFeed.name),
                          subtitle: Text(newsFeed.createdOn.toString()),
                        ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            newsFeed.description,
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ),
                        if (newsFeed.photo != null) ...[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CachedNetworkImage(
                              imageUrl: newsFeed.photo!,
                              placeholder: (context, url) => CircularProgressIndicator(),
                              errorWidget: (context, url, error) => Icon(Icons.error),
                            ),
                          ),
                          // SizedBox(height: 10),
                        ],
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () => onLikeButtonPressed(index),
                                child: Row(
                                  children: [
                                    Icon(
                                      newsFeed.isLiked ? Icons.favorite : Icons.favorite_border,
                                      size: 20.0,
                                      color: newsFeed.isLiked ? Colors.red : null,
                                    ),
                                    SizedBox(width: 5),
                                    Text(newsFeed.likeCount.toString()),
                                  ],
                                ),
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    newsFeed.showAllComments = !newsFeed.showAllComments;
                                  });
                                },
                                child: Row(
                                  children: [
                                    Icon(Icons.comment),
                                    SizedBox(width: 5),
                                    Text(newsFeed.comments.length.toString()),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  );
                },
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
