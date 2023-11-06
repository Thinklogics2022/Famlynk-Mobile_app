import 'package:cached_network_image/cached_network_image.dart';
import 'package:famlynk_version1/mvc/model/profile_model/profileModel.dart';
import 'package:famlynk_version1/mvc/view/addmember/addMember.dart';
import 'package:famlynk_version1/mvc/view/famlynkLogin/Password/resetPassword.dart';
import 'package:famlynk_version1/mvc/view/profile/edit.dart';
import 'package:famlynk_version1/mvc/view/profile/logout.dart';
import 'package:famlynk_version1/mvc/view/profile/myTimeLine/myTimeLine.dart';
import 'package:famlynk_version1/mvc/view/profile/notification/notification.dart';
import 'package:famlynk_version1/mvc/view/profile/userDetails.dart';
import 'package:famlynk_version1/services/profileService/editProfileService.dart';
import 'package:famlynk_version1/services/profileService/profile_Service.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final firebase_storage.Reference storageRef =
      firebase_storage.FirebaseStorage.instance.ref();
  ProfileUserModel profileUserModel = ProfileUserModel();
  ProfileUserService profileUserService = ProfileUserService();
  bool isLoading = true;
  File? imageFile;

  ImageProvider<Object>? _getCoverImage(ProfileUserModel profileUserModel) {
    if (profileUserModel.coverImage == null ||
        profileUserModel.coverImage!.isEmpty) {
      return AssetImage('assets/images/fam.jpg');
    } else {
      return CachedNetworkImageProvider(profileUserModel.coverImage.toString());
    }
  }

  ImageProvider<Object>? _getProfileImage(ProfileUserModel profileUserModel) {
    if (profileUserModel.profileImage == null ||
        profileUserModel.profileImage!.isEmpty) {
      return AssetImage('assets/images/FL01.png');
    } else {
      return CachedNetworkImageProvider(
        profileUserModel.profileImage.toString(),
      );
    }
  }

  File? _coverImageFile;

  Future<void> _fetchMembers() async {
    try {
      profileUserModel = await profileUserService.fetchMembersByUserId();

      if (profileUserModel.coverImage != null &&
          profileUserModel.coverImage!.isNotEmpty) {
        try {
          final imageFile = await firebase_storage.FirebaseStorage.instance
              .refFromURL(profileUserModel.coverImage.toString())
              .getDownloadURL();
          _coverImageFile = File(imageFile);
        } catch (e) {
          print(e);
        }
      }

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchMembers();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // SizedBox(height: 20),
                          // Text(
                          //   "Profile",
                          //   style: TextStyle(
                          //     fontSize: 25.0,
                          //     fontWeight: FontWeight.bold,
                          //   ),
                          // ),
                          SizedBox(height: 20.0),
                          Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              Container(
                                height: 200,
                                width: 360,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: _getCoverImage(profileUserModel) ??
                                        AssetImage('assets/images/fam.jpg'),
                                    fit: BoxFit.cover,
                                  ),
                                  color: Colors.grey[300],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 120),
                                height: 120,
                                width: 120,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(60.0),
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 5.0,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 3.0,
                                      offset: Offset(0, 4.0),
                                      color: Colors.black38,
                                    ),
                                  ],
                                ),
                                child: CircleAvatar(
                                  backgroundImage:
                                      _getProfileImage(profileUserModel),
                                ),
                              ),
                              Positioned(
                                right: 1,
                                bottom: 40,
                                child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.blue),
                                  child: IconButton(
                                    iconSize: 20,
                                    icon: Icon(
                                      Icons.photo_camera,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      _pickImageFromGallery();
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(children: [
                              Column(
                                children: [
                                  SizedBox(height: 19),
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 160,
                                            child: Text(
                                              profileUserModel.name.toString(),
                                              style: TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle: FontStyle.italic),
                                            ),
                                          ),
                                          Text(
                                            profileUserModel.mobileNo
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.black),
                                          ),
                                          Container(
                                            width: 160,
                                            child: Text(
                                              profileUserModel.email.toString(),
                                              style: TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontSize: 13,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 25),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    EditProfilePage(
                                                      profileUserModel:
                                                          profileUserModel,
                                                    )),
                                          );
                                        },
                                        child: Text(
                                          "Edit Profile",
                                          style: TextStyle(
                                              color: HexColor('#FF6F20'),
                                              fontSize: 15),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ]),
                          ),
                          SizedBox(height: 20),
                          Text(
                            "Account",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 30),
                          Card(
                            elevation: 3.0,
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  InkWell(
                                    child: CustomListTile(
                                      icon: Icons.add,
                                      text: "Add Family Member",
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => AddMember()),
                                      );
                                    },
                                  ),
                                  Divider(
                                    height: 10.0,
                                    color: Colors.grey,
                                  ),
                                  InkWell(
                                    child: CustomListTile(
                                      icon: Icons.photo,
                                      text: "Gallery",
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MyTimeLine()),
                                      );
                                    },
                                  ),
                                  Divider(
                                    height: 10.0,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(height: 5),
                                  GestureDetector(
                                    onTap: () async {
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Notifications()),
                                      );
                                    },
                                    child: Row(
                                      children: [
                                        Icon(Icons.notifications,
                                            color: HexColor('#FF6F20')),
                                        SizedBox(width: 17),
                                        Text("Notifications",
                                            style: TextStyle(fontSize: 16))
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Divider(
                                    height: 10.0,
                                    color: Colors.grey,
                                  ),
                                  InkWell(
                                    child: CustomListTile(
                                      icon: Icons.account_circle_rounded,
                                      text: "User Details",
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ProfileUserDetails()));
                                    },
                                  ),
                                  Divider(
                                    height: 10.0,
                                    color: Colors.grey,
                                  ),
                                  InkWell(
                                    child: CustomListTile(
                                      icon: Icons.password,
                                      text: "Reset Password",
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ResetPassword()));
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LogOutPage()));
                                },
                                child: Text(
                                  "Logout",
                                  style: TextStyle(
                                      fontSize: 23, color: HexColor('#FF6F20')),
                                ),
                              ),
                            ],
                          )
                        ]),
                  ))));
  }

  Future<void> _pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _coverImageFile = File(pickedFile.path);
      _showImageSelectionConfirmation();
    }
  }

  Future<void> _showImageSelectionConfirmation() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Image Selection Confirmation"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Do you want to save this image?"),
              SizedBox(height: 20),
              Row(
                children: [
                  TextButton(
                    child: Text("Cancel"),
                    onPressed: () {
                      Navigator.of(context).pop();
                      setState(() {
                        _coverImageFile = null;
                      });
                    },
                  ),
                  SizedBox(width: 20),
                  TextButton(
                    child: Text("Save"),
                    onPressed: () async {
                      if (_coverImageFile != null) {
                        final storageResult = await storageRef
                            .child(
                                'profile_images/${DateTime.now().millisecondsSinceEpoch}')
                            .putFile(_coverImageFile!);
                        var imageUrl1 =
                            await storageResult.ref.getDownloadURL();
                        profileUserModel.coverImage = imageUrl1;
                        setState(() {});
                        ProfileUserModel updatedProfile = ProfileUserModel(
                          coverImage: imageUrl1,
                          name: profileUserModel.name,
                          email: profileUserModel.email,
                          mobileNo: profileUserModel.mobileNo,
                          gender: profileUserModel.gender,
                          dateOfBirth: profileUserModel.dateOfBirth,
                          hometown: profileUserModel.hometown,
                          address: profileUserModel.address,
                          maritalStatus: profileUserModel.maritalStatus,
                          userId: profileUserModel.userId,
                          uniqueUserID: profileUserModel.uniqueUserID,
                          profileImage: profileUserModel.profileImage,
                          id: profileUserModel.id,
                          password: profileUserModel.password,
                          createdOn: profileUserModel.createdOn,
                          modifiedOn: "",
                          status: profileUserModel.status,
                          role: profileUserModel.role,
                          enabled: profileUserModel.enabled,
                          verificationToken: profileUserModel.verificationToken,
                          otp: profileUserModel.otp,
                        );
                        EditProfileService editProfileService =
                            EditProfileService();
                        editProfileService.editProfile(updatedProfile);
                      }
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class CustomListTile extends StatelessWidget {
  final IconData? icon;
  final String? text;

  CustomListTile({this.icon, this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 5.0),
        child: Row(
          children: <Widget>[
            Icon(
              icon,
              color: HexColor('#FF6F20'),
            ),
            SizedBox(width: 15),
            Text(
              "$text",
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ));
  }
}
