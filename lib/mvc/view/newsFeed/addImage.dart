import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:famlynk_version1/mvc/model/newsfeed_model/newsFeed_model.dart';
import 'package:famlynk_version1/services/newsFeed_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddImagePage extends StatefulWidget {
  @override
  _AddImagePageState createState() => _AddImagePageState();
}

class _AddImagePageState extends State<AddImagePage> {
  final TextEditingController _descriptionController = TextEditingController();
  String userId = '';
  String name = '';
  String uniqueUserID = '';
  bool uploading = false;
  late CollectionReference imgRef;
  List<File> _imagesFile = [];
  late Reference ref;

  final picker = ImagePicker();

  @override
  void initState() {
    imgRef = FirebaseFirestore.instance.collection('imageURLs');
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('userId') ?? '';
      name = prefs.getString('name') ?? '';
      uniqueUserID = prefs.getString('uniqueUserID') ?? '';
    });
  }

  void _postNewsFeed() async {
    

      String photo = '';

    if (_imagesFile.isNotEmpty) {
      final imageFile = _imagesFile.first;
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageReference =
          FirebaseStorage.instance.ref().child('profile_images/$fileName');
      UploadTask uploadTask = storageReference.putFile(imageFile);
      TaskSnapshot taskSnapshot = await uploadTask;
      photo = await taskSnapshot.ref.getDownloadURL();
    }
      String profilePicture = 'assets/images/FL03.png';
      String vedio = '';
      int like = 0.toInt();
      String description = _descriptionController.text;
      List<String> userLikes = [];

      if (description.isNotEmpty) {
      NewsFeedModel newsFeedModel = NewsFeedModel(
        userId: userId,
        name: name,
        profilePicture: profilePicture,
        vedio: vedio,
        photo: photo,
        like: like,
        description: description,
        uniqueUserID: uniqueUserID,
        userLikes: userLikes,
      );
      NewsFeedService newsFeedService = NewsFeedService();
      newsFeedService.postNewsFeed(newsFeedModel);
      Navigator.pop(context);
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please enter a description.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Image'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                ),
                SizedBox(width: 10),
                Text("${name}"),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _descriptionController,
                    decoration: InputDecoration(hintText: 'Description'),
                  ),
                ),
                SizedBox(width: 20),
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: ((builder) => bottomSheet()),
                    );
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 4,
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                      color: Colors.green,
                    ),
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 20),
                GestureDetector(
                  onTap: _postNewsFeed,
                  child: Icon(Icons.send_sharp),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            'Choose Profile Photo',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton.icon(
                icon: Icon(Icons.camera),
                onPressed: () {
                  takePhoto(ImageSource.camera);
                  Navigator.pop(context);
                },
                label: Text('Camera'),
              ),
              TextButton.icon(
                icon: Icon(Icons.image),
                onPressed: () {
                  takePhoto(ImageSource.gallery);
                  Navigator.pop(context);
                },
                label: Text('Gallery'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imagesFile.clear();
        _imagesFile.add(File(pickedFile.path));
      });
    }
  }
}