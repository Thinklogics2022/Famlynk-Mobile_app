import 'dart:io';
import 'package:famlynk_version1/constants/constVariables.dart';
import 'package:famlynk_version1/mvc/view/FamilyTimeLine/newsFeed/news.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class FreshNewsFeed extends StatefulWidget {
  const FreshNewsFeed({Key? key}) : super(key: key);

  @override
  State<FreshNewsFeed> createState() => _FreshNewsFeedState();
}

class _FreshNewsFeedState extends State<FreshNewsFeed> {
  bool isLiked = false;
  int likeCount = 0;
  List<String> comments = [];
  List<File> _images = [];
  bool showLikeCommentSection = false;
  bool showAllComments = false; // New variable to track comment visibility

  TextEditingController _textFieldController =
      TextEditingController(); // Added text field controller

  Future<void> _pickFiles() async {
    final pickedFiles =
        await FilePicker.platform.pickFiles(allowMultiple: true);

    setState(() {
      if (pickedFiles != null) {
        _images = pickedFiles.paths.map((path) => File(path!)).toList();
        showLikeCommentSection = true;
      }
    });
  }

  void onLikeButtonPressed() {
    setState(() {
      if (isLiked) {
        likeCount--;
      } else {
        likeCount++;
      }
      isLiked = !isLiked;
    });
  }

  void addComment(String comment) {
    setState(() {
      comments.add(comment);
    });
  }

  void _sendPost() {
    String postText = _textFieldController.text;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Post Content'),
        content: Container(
          height: 200.0,
          child: ListView(
            children: [
              if (postText.isNotEmpty)
                ListTile(
                  title: Text(postText),
                ),
              ..._images.map((image) => Image.file(image)).toList(),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NewsFeedFirstPage()));
            },
            child: Text('Click To Post'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    MyProperties myProperties = MyProperties();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller:
                            _textFieldController, // Set the text field controller
                        decoration: InputDecoration(
                          hintText: 'What\'s on your mind?',
                        ),
                      ),
                    ),
                    IconButton(
                      color: myProperties.buttonColor,
                      icon: Icon(Icons.camera_alt),
                      onPressed: () {
                        _pickFiles();
                      },
                    ),
                    IconButton(
                      color: myProperties.buttonColor,
                      icon: Icon(Icons.send),
                      onPressed: _sendPost,
                    ),
                  ],
                ),
              ),
              Container(
                color: Color.fromARGB(255, 255, 255, 255),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      ListTile(
                        leading: _images.isNotEmpty
                            ? CircleAvatar(
                                radius: 20.0,
                                backgroundImage:
                                    AssetImage('assets/images/FL02.png'),
                              )
                            : null,
                        title: _images.isNotEmpty
                            ? Text(
                                'jaipandi',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            : null,
                        contentPadding: EdgeInsets.all(0.0),
                      ),
                      Container(
                        child: Column(
                          children: _images
                              .map((image) => Image.file(image))
                              .toList(),
                        ),
                      ),
                      if (showLikeCommentSection)
                        Container(
                          margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: Row(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: onLikeButtonPressed,
                                    child: Row(
                                      children: [
                                        Icon(
                                          isLiked
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          size: 20.0,
                                          color: isLiked
                                              ? const Color.fromARGB(
                                                  255, 206, 0, 0)
                                              : null,
                                        ),
                                        SizedBox(width: 5),
                                        Text(likeCount.toString()),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 100),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        showAllComments = !showAllComments;
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        Text(comments.length.toString()),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text('Add a Comment'),
                                      content: TextField(
                                        controller: _textFieldController,
                                        onChanged: (value) {},
                                        onSubmitted: (value) {
                                          addComment(value);
                                          Navigator.pop(context);
                                        },
                                        decoration: InputDecoration(
                                          hintText: 'Write your comment...',
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            String comment = _textFieldController
                                                .text
                                                .trim(); // Get the comment from the text field
                                            addComment(comment);
                                            _textFieldController.clear();
                                            Navigator.pop(
                                                context); // Close the dialog
                                          },
                                          child: Text('Add'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.mode_comment,
                                      size: 18.0,
                                    ),
                                    SizedBox(width: 5),
                                    Text('Comments'),
                                    if (comments.isNotEmpty)
                                      SizedBox(
                                        width: 5,
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (showAllComments)
                        ...comments.asMap().entries.map(
                              (entry) => ListTile(
                                leading: CircleAvatar(
                                  radius: 20.0,
                                  backgroundImage:
                                      AssetImage('assets/images/nature.jpg'),
                                ),
                                title: Text('itsme'),
                                subtitle: Text(entry.value),
                              ),
                            )
                      else if (comments.isNotEmpty &&
                          comments.length <=
                              2) // Show "View all comments" only if there are comments
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              showAllComments = true;
                            });
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.mode_comment,
                                size: 18.0,
                              ),
                              SizedBox(width: 5),
                              Text('View all comments'),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
