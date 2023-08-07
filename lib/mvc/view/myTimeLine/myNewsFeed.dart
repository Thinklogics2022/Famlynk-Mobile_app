// ignore_for_file: unnecessary_null_comparison

import 'package:cached_network_image/cached_network_image.dart';
import 'package:famlynk_version1/mvc/model/profile_model/myTimeLine_model.dart';
import 'package:famlynk_version1/mvc/view/newsFeed/comment/comment.dart';
import 'package:famlynk_version1/services/profileService/myTimeLine/myTimeLine_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyNewsFeed extends StatefulWidget {
  const MyNewsFeed({super.key});

  @override
  State<MyNewsFeed> createState() => _MyNewsFeedState();
}

class _MyNewsFeedState extends State<MyNewsFeed> {
  bool isLoaded = false;
  bool isLiked = false;
  late List<String> comments;
  List<MyTimeLineModel>? myTimeLineList = [];
  ScrollController _scrollController = ScrollController();
  String userId = "";

  @override
  void initState() {
    super.initState();
    fetchData();
    comments = [];
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.atEdge &&
        _scrollController.position.pixels != 0) {}
  }

  Future<void> fetchData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('userId') ?? '';
    });
    await _fetchMyTimeLine();
  }

  Future<void> _fetchMyTimeLine() async {
    MyTimeLineService myTimeLineService = MyTimeLineService();
    try {
      var myNewsFeed = await myTimeLineService.getMyTimeLine();
      setState(() {
        myTimeLineList!.addAll(myNewsFeed);
        isLoaded = true;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _handleRefersh() async {
    setState(() {
      myTimeLineList!.clear();
      isLoaded = false;
    });
    await _fetchMyTimeLine();
  }

  ImageProvider<Object>? _getProfileImage(MyTimeLineModel myNewsFeeds) {
    final String? profilePicture = myNewsFeeds.profilePicture;
    if (profilePicture == null ||
        profilePicture.isEmpty) {
      return AssetImage('assets/images/FL01.png');
    } else {
      return CachedNetworkImageProvider(profilePicture);
    }
  }

  void onLikeButtonPressed(int index) async {
    MyTimeLineModel myNewsFeeds = myTimeLineList![index];
    bool isCurrentlyLiked = myNewsFeeds.userLikes.contains(userId);

    try {
      isLiked = isCurrentlyLiked;
      if (isLiked) {
        myTimeLineList![index].userLikes.add(userId);
        myTimeLineList![index].like++;
      } else {
        myTimeLineList![index].userLikes.remove(userId);
        myTimeLineList![index].like--;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> addComment(int index, String comment) async {
    setState(() {
      comments.add(comment);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 223, 228, 237),
      body: RefreshIndicator(
        onRefresh: _handleRefersh,
        child: isLoaded
            ? myTimeLineList!.isEmpty
                ? Center(
                    child: Text(
                      'You have no Posted',
                      // style: TextStyle(fontSize: 18),
                    ),
                  )
                : ListView.builder(
                    controller: _scrollController,
                    itemCount: myTimeLineList!.length,
                    itemBuilder: (context, index) {
                      MyTimeLineModel myNewsFeeds = myTimeLineList![index];
                      DateTime? utcDateTime =
                          DateTime.parse(myNewsFeeds.createdOn.toString());
                      DateTime localDateTime = utcDateTime.toLocal();

                      String formattedDate = DateFormat('MMMM-dd-yyyy  hh:mm a')
                          .format(localDateTime);
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
                                backgroundImage: _getProfileImage(myNewsFeeds),
                              ),
                              title: Text(myNewsFeeds.name),
                              subtitle: Text(formattedDate),
                            ),
                            Divider(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                myNewsFeeds.description,
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ),
                            if (myNewsFeeds.photo != null &&
                                myNewsFeeds.photo!.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CachedNetworkImage(
                                  imageUrl: myNewsFeeds.photo!,
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: null,
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
                                        Text(myNewsFeeds.like.toString()),
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CommentScreen(
                                                    name: myNewsFeeds.name,
                                                    newsFeedId:
                                                        myNewsFeeds.newsFeedId,
                                                    profilePicture: myNewsFeeds
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
                            SizedBox(
                              height: 10,
                            )
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
