import 'package:cached_network_image/cached_network_image.dart';
import 'package:famlynk_version1/mvc/model/newsfeed_model/familyNewsFeed_model.dart';
import 'package:famlynk_version1/mvc/view/newsFeed/comment/comment.dart';
import 'package:famlynk_version1/services/newsFeedService/familyNewsFeed_services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FamilyNews extends StatefulWidget {
  const FamilyNews({Key? key}) : super(key: key);

  @override
  State<FamilyNews> createState() => _FamilyNewsState();
}

class _FamilyNewsState extends State<FamilyNews> {
  bool isLoaded = false;
  bool isLiked = false;
  late List<String> comments;
  List<FamilyNewsFeedModel>? familyNewsFeedList = [];
  ScrollController _scrollController = ScrollController();
  String userId = "";

  @override
  void initState() {
    super.initState();
    _fetchFamilyNewsFeed();
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
  }

  Future<void> _fetchFamilyNewsFeed() async {
  FamilyNewsFeedService familyNewsFeedService = FamilyNewsFeedService();
  try {
    var newsFeedFamily = await familyNewsFeedService.getFamilyNewsFeed();
    setState(() {
      familyNewsFeedList!.addAll(newsFeedFamily!);
      isLoaded = true;
    });
  } catch (e) {
    print('Error fetching family news feed: $e');
  }
}


  Future<void> _handleRefresh() async {
    setState(() {
      familyNewsFeedList!.clear();
      isLoaded = false;
    });
    await _fetchFamilyNewsFeed();
  }

  void onLikeButtonPressed(int index) async {
    FamilyNewsFeedModel newsfeed = familyNewsFeedList![index];
    bool isCurrentlyLiked = newsfeed.userLikes.contains(userId);
    try {
      setState(() {
        isLiked = !isCurrentlyLiked;
        if (isLiked) {
          familyNewsFeedList![index].userLikes.add(userId);
          familyNewsFeedList![index].like++;
        } else {
          familyNewsFeedList![index].userLikes.remove(userId);
          familyNewsFeedList![index].like--;
        }
      });
    } catch (e) {
      print(e);
    }
  }

  ImageProvider<Object> _getProfileImage(FamilyNewsFeedModel newsFeedModel) {
    final String? profilePicture = newsFeedModel.profilePicture;

    if (profilePicture == null || profilePicture.isEmpty) {
      return AssetImage('assets/images/FL01.png');
    } else {
      return CachedNetworkImageProvider(profilePicture);
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
        onRefresh: _handleRefresh,
        child: isLoaded
            ? familyNewsFeedList!.isEmpty
                ? Center(
                    child: Text(
                      'No FamilyNews are available.',
                      // style: TextStyle(fontSize: 18),
                    ),
                  )
                : ListView.builder(
                    controller: _scrollController,
                    itemCount: familyNewsFeedList!.length,
                    itemBuilder: (context, index) {
                      FamilyNewsFeedModel newsFeed = familyNewsFeedList![index];
                      DateTime? utcDateTime =
                          DateTime.parse(newsFeed.createdOn.toString());
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
                                backgroundImage: _getProfileImage(newsFeed),
                              ),
                              title: Text(newsFeed.name),
                              subtitle: Text(formattedDate),
                            ),
                            Divider(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                newsFeed.description!,
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ),
                            if (newsFeed.photo != null &&
                                newsFeed.photo!.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CachedNetworkImage(
                                  imageUrl: newsFeed.photo!,
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
                                        Text(newsFeed.like.toString()),
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
                                                    name: newsFeed.name,
                                                    newsFeedId:
                                                        newsFeed.newsFeedId,
                                                    profilePicture: newsFeed
                                                        .profilePicture
                                                        .toString(),
                                                  )));
                                    },
                                    child: Row(
                                      children: [
                                        Icon(Icons.chat_bubble_outline),
                                        SizedBox(width: 6),
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text('and '),
                                  Text(
                                    "others",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 16.0, top: 8),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Gokul',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
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
