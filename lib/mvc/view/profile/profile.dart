

import 'package:famlynk_version1/mvc/view/addmember/addMember.dart';
import 'package:famlynk_version1/mvc/view/familyList/famList.dart';
import 'package:famlynk_version1/mvc/view/gallery/gallery.dart';
import 'package:famlynk_version1/mvc/view/navigationBar/navBar.dart';
import 'package:famlynk_version1/mvc/view/profile/edit.dart';
import 'package:famlynk_version1/mvc/view/profile/editPage.dart';
import 'package:famlynk_version1/mvc/view/profile/logout.dart';
import 'package:famlynk_version1/mvc/view/profile/userDetails.dart';
import 'package:famlynk_version1/services/profile_Service.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/profile_model/profile_model.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  ProfileUserModel profileUserModel = ProfileUserModel();
  ProfileUserService profileUserService = ProfileUserService();
  bool isLoading = true;
  var imageFile;

  @override
  void initState() {
    super.initState();
    _fetchMembers();
  }

  _fetchMembers() async {
    try {
      profileUserModel = await profileUserService.fetchMembersByUserId();
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: SafeArea(
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
                        SizedBox(height: 20),
                        Text(
                          "Profile",
                          style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(60.0),
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
                                      profileUserModel.profileImage == null
                                          // profileUserModel.profileImage
                                          //     is String
                                          ? AssetImage('assets/images/FL01.png')
                                          : NetworkImage(profileUserModel
                                                  .profileImage
                                                  .toString())
                                              as ImageProvider<Object>?

                                  // as ImageProvider<Object>?,
                                  ),
// child: CircleAvatar(
//   backgroundImage: NetworkImage(profileUserModel.profileImage.toString()),
// ),
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 19),
                                Row(
                                  children: [
                                    Text(
                                      profileUserModel.name.toString(),
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  profileUserModel.mobileNo.toString(),
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.grey),
                                ),
                                Container(
                                  width: 170,
                                  child: Text(
                                    profileUserModel.email.toString(),
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                                SizedBox(height: 20),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                EditProfilePage(
                                                    profileUserModel:
                                                        profileUserModel)));
                                  },
                                  child: Text("Edit Profile"),
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 30),
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
                                          builder: (context) => MediaPage()),
                                    );
                                  },
                                ),
                                Divider(
                                  height: 10.0,
                                  color: Colors.grey,
                                ),
                                InkWell(
                                  child: CustomListTile(
                                    icon: Icons.notification_add,
                                    text: "Notification",
                                  ),
                                ),
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
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // crossAxisAlignment: CrossAxisAlignment.center,
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
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => NavBar()),
    );
    return Future.value(false);
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
          SizedBox(
            width: 15.0,
          ),
          Text(
            "$text",
            style: TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}