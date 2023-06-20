import 'dart:io';
import 'package:famlynk_version1/constants/constVariables.dart';
import 'package:famlynk_version1/mvc/model/newsfeed_model/newsFeedModel.dart';
import 'package:famlynk_version1/services/newsFeedService.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FreshNewsFeed extends StatefulWidget {
  const FreshNewsFeed({Key? key}) : super(key: key);

  @override
  State<FreshNewsFeed> createState() => _FreshNewsFeedState();
}

class _FreshNewsFeedState extends State<FreshNewsFeed> {
  String userId = "";
  

  PlatformFile? pickedFile;
  UploadTask? uploadTask;

  bool isLiked = false;
  int likeCount = 0;
  List<String> comments = [];
  List<File> _images = [];

  bool showLikeCommentSection = false;
  bool showAllComments = false; // New variable to track comment visibility

  TextEditingController _textFieldController = TextEditingController();

  Future _pickFiles() async {
    final result = await FilePicker.platform.pickFiles();

    if (result == null) return;

    setState(() {
      pickedFile = result.files.first;
    });
  }

  void _sendPost() async {
    try {
      final path = 'files/${pickedFile!.name}';
      final file = File(pickedFile!.path!);

      final ref = FirebaseStorage.instance.ref().child(path);
      setState(() {
        uploadTask = ref.putFile(file);
      });

      final snapshot = await uploadTask!.whenComplete(() {});

      final urlDownload = await snapshot.ref.getDownloadURL();
      print('Download Link: $urlDownload');

      NewsFeedService newsFeedService = NewsFeedService();
      NewsFeedModel newsFeedModel = NewsFeedModel(
          userId: userId,
          photo: urlDownload,
          vedio: 'asdffjklwrtrter',
          like: likeCount,
          description: 'lkjtdrsdzfurydyunxbae');

      await newsFeedService.postNewsFeed(newsFeedModel);
      // setState(() {
      //   userId = prefs.getString('userId') ?? '';

      //   uploadTask = null;
      // });
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('userId') ?? '';
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
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
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(
                                left: 8.0, right: 8.0, top: 4.0, bottom: 8.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: TextFormField(
                              controller: _textFieldController,
                              decoration: InputDecoration(
                                hintText: 'What\'s on your mind?',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8.0),
                        IconButton(
                          color: myProperties.buttonColor,
                          icon: Icon(Icons.camera_alt),
                          onPressed: _pickFiles,
                        ),
                        IconButton(
                          color: myProperties.buttonColor,
                          icon: Icon(Icons.send),
                          onPressed: () {
                            _sendPost();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FreshNewsFeed()));
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ListTile(
                      leading: CircleAvatar(
                        radius: 20.0,
                        backgroundImage: AssetImage('assets/images/FL02.png'),
                      ),
                      title: Text(
                        'jaipandi',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    if (pickedFile != null)
                      SizedBox(
                        height: 300.0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.file(
                            File(pickedFile!.path!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(height: 8.0),
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (_images.isNotEmpty)
                      Column(
                        children:
                            _images.map((image) => Image.file(image)).toList(),
                      ),
                    if (showLikeCommentSection)
                      Row(
                        children: [
                          TextButton.icon(
                            onPressed: onLikeButtonPressed,
                            icon: Icon(
                              isLiked
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: isLiked ? Colors.red : null,
                            ),
                            label: Text(
                              likeCount.toString(),
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          TextButton.icon(
                            onPressed: () {
                              setState(() {
                                showAllComments = !showAllComments;
                              });
                            },
                            icon: Icon(
                              Icons.mode_comment,
                              color: Colors.grey,
                            ),
                            label: Text(
                              comments.length.toString(),
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    if (showAllComments ||
                        (comments.isNotEmpty && comments.length <= 2))
                      ...comments
                          .asMap()
                          .entries
                          .map(
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
                          .toList(),
                    if (comments.isNotEmpty &&
                        comments.length > 2 &&
                        !showAllComments)
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            showAllComments = true;
                          });
                        },
                        child: Text(
                          'View all comments',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    if (showAllComments ||
                        (comments.isNotEmpty && comments.length <= 2))
                      Divider(
                        color: Colors.grey,
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
                                  String comment =
                                      _textFieldController.text.trim();
                                  addComment(comment);
                                  _textFieldController.clear();
                                  Navigator.pop(context);
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
                            color: Colors.grey,
                            size: 18.0,
                          ),
                          SizedBox(width: 5.0),
                          Text(
                            'Comments',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              buildProgress(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProgress() => StreamBuilder<TaskSnapshot>(
        stream: uploadTask?.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!;
            double progress = data.bytesTransferred / data.totalBytes;
            return LinearProgressIndicator(value: progress);
          } else {
            return Container();
          }
        },
      );
}
