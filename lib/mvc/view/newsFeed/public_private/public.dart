import 'package:flutter/material.dart';
import 'package:famlynk_version1/mvc/model/newsfeed_model/publicNewsFeed_model.dart';
import 'package:famlynk_version1/mvc/view/newsFeed/comment/comment.dart';
import 'package:famlynk_version1/services/newsFeedService/likeNewsFeed_service.dart';
import 'package:famlynk_version1/services/newsFeedService/publicNewsFeed_service.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PublicNews extends StatefulWidget {
  const PublicNews({Key? key}) : super(key: key);

  @override
  State<PublicNews> createState() => _PublicNewsState();
}

class _PublicNewsState extends State<PublicNews> {
  bool isLoaded = false;
  int pageNumber = 0;
  int pageSize = 20;
  bool isLiked = false;
  int LikedCount=0;
  late List<String> comments;
  List<PublicNewsFeedModel>? publicNewsFeedList = [];
  ScrollController _scrollController = ScrollController();
  String userId = "";

  @override
  void initState() {
    super.initState();
    fetchData();
    comments = [];
    _scrollController.addListener(_onScroll);
    _handleRefresh();
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

  Future<void> fetchData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('userId') ?? '';
    });
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

  void onLikeButtonPressed(int index) async {
    PublicNewsFeedModel newsFeed = publicNewsFeedList![index];
    bool isCurrentlyLiked = newsFeed.userLikes.contains(userId);

    try {
      // if (isCurrentlyLiked) {
      //   await LikeNewsFeedService().unlikeNewsFeed(newsFeed.newsFeedId);
      // } else {
      //   await LikeNewsFeedService().likeNewsFeed(newsFeed.newsFeedId);
      // }
      setState(() {
        isLiked = !isCurrentlyLiked;
        if (isLiked) {
          publicNewsFeedList![index].userLikes.add(userId);
          publicNewsFeedList![index].like++;
        } else {
          publicNewsFeedList![index].userLikes.remove(userId);
          publicNewsFeedList![index].like--;
        }
        publicNewsFeedList = List.from(publicNewsFeedList!);
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> addComment(int index, String comment) async {
    setState(() {
      comments.add(comment);
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
                            backgroundImage:
                                AssetImage('assets/images/FL02.png'),
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
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () => onLikeButtonPressed(index),
                                child: Row(
                                  children: [
                                    Icon(
                                      isLiked
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      size: 20.0,
                                      color: isLiked ? Colors.red : null,
                                    ),
                                    SizedBox(width: 5),
                                    Text(newsFeed.like
                                        .toString()), // Display the like count
                                  ],
                                ),
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => CommentScreen(
                                            name: newsFeed.name,
                                            newsFeedId: newsFeed.newsFeedId,
                                            profilePicture: newsFeed
                                                .profilePicture
                                                .toString(),
                                          )));
                                },
                                child: Row(
                                  children: [
                                    Icon(Icons.chat_bubble_outline),
                                    SizedBox(width: 5),
                                    Text(comments.length.toString()),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text("Liked by "),
                              Text(
                                "gokul ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text('and '),
                              Text(
                                "others",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0, top: 8),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Gokul',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: 'qwdefgfd',
                                ),
                              ],
                            ),
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
