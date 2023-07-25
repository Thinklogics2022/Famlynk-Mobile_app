import 'package:famlynk_version1/mvc/model/profile_model/profile_model.dart';
import 'package:famlynk_version1/mvc/view/profile/edit.dart';
import 'package:famlynk_version1/services/profile_Service.dart';
import 'package:flutter/material.dart';

class ProfileUserDetails extends StatefulWidget {
  @override
  _ProfileUserDetailsState createState() => _ProfileUserDetailsState();
}

class _ProfileUserDetailsState extends State<ProfileUserDetails> {
  ProfileUserModel profileUserModel = ProfileUserModel();
  ProfileUserService profileUserService = ProfileUserService();
  bool isVisibleHomeTown = true;
  bool isVisibleAddress = true;
  bool isVisibleMaritalStatus = true;
  @override
  void initState() {
    super.initState();
    _fetchMembers();
  }

  _fetchMembers() async {
    try {
      profileUserModel = await profileUserService.fetchMembersByUserId();
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 224, 233, 240),
        appBar: AppBar(
          title: Text('Profile User Details'),
        ),
        body: Padding(
            padding: const EdgeInsets.fromLTRB(20, 130, 20, 30),
            child: SingleChildScrollView(
                child: Center(
                    child: Card(
                        child: Padding(
                            padding: const EdgeInsets.all(14),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              "Name           :     ${profileUserModel.name}"),
                                          Divider(
                                            thickness: 0.5,
                                            color: Colors.blue,
                                          ),
                                          Text(
                                              "Dob              :     ${profileUserModel.dateOfBirth}"),
                                          Divider(
                                            thickness: 0.5,
                                            color: Colors.blue,
                                          ),
                                          Text(
                                              "Email           :      ${profileUserModel.email}"),
                                          Divider(
                                            thickness: 0.5,
                                            color: Colors.blue,
                                          ),
                                          Text(
                                              "Gender        :      ${profileUserModel.gender}"),
                                          Divider(
                                            thickness: 0.5,
                                            color: Colors.blue,
                                          ),
                                          Text(
                                              "Mobine No :      ${profileUserModel.mobileNo}"),
                                          Divider(
                                            thickness: 0.5,
                                            color: Colors.blue,
                                          ),
                                          Visibility(
                                            child: Column(
                                              children: [
                                                // Text(
                                                // "HomeTown : ${profileUserModel.hometown}"),
                                                Container(
                                                    child: isVisibleHomeTown
                                                        ? Text(profileUserModel
                                                            .hometown
                                                            .toString())
                                                        : Text("")),
                                                Container(
                                                    child: isVisibleAddress
                                                        ? Text(profileUserModel
                                                            .address
                                                            .toString())
                                                        : Text("")),
                                                         Container(
                                                    child: isVisibleMaritalStatus
                                                        ? Text(profileUserModel
                                                            .maritalStatus
                                                            .toString())
                                                        : Text(""))
                                              ],
                                            ),
                                            // visible: homeTownVisible ,
                                          )
                                        ]),
                                  ))
                                ])))))));
  }
}
