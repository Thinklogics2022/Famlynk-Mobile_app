import 'package:cached_network_image/cached_network_image.dart';
import 'package:famlynk_version1/mvc/model/newsfeed_model/publicNewsFeed_model.dart';
import 'package:famlynk_version1/services/publicNewsFeed_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  Future<void> _handleRefresh() async {
    setState(() {
      pageNumber = 0;
      publicNewsFeedList!.clear();
      isLoaded = false;
    });
    await fetchPublicNewsFeed(pageNumber, pageSize);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 223, 228, 237),
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: isLoaded
            ? ListView.builder(
                controller: _scrollController,
                itemCount: publicNewsFeedList!.length,
                itemBuilder: (context, index) {
                  PublicNewsFeedModel newsFeed = publicNewsFeedList![index];
                  DateTime? utcDateTime =
                      DateTime.parse(newsFeed.createdOn.toString());
                  DateTime localDateTime = utcDateTime.toLocal();

                  String formattedDate =
                      DateFormat('MMMM-dd-yyyy  hh:mm a').format(localDateTime);

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
                          subtitle: Text(formattedDate),
                        ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            newsFeed.description,
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ),
                        if (newsFeed.photo != null)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CachedNetworkImage(
                              imageUrl: newsFeed.photo!,
                              placeholder: (context, url) => CircularProgressIndicator(),
                              errorWidget: (context, url, error) => Icon(Icons.error),
                            ),
                          ),
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
                                      newsFeed.isLiked
                                          ? Icons.favorite
                                          : Icons.favorite_border,
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
                        if (newsFeed.showAllComments) ...[
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: newsFeed.comments.length,
                            itemBuilder: (context, commentIndex) {
                              String comment = newsFeed.comments[commentIndex];
                              return ListTile(
                                title: Text(comment),
                              );
                            },
                          ),
                          SizedBox(height: 10),
                        ],
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
