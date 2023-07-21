import 'package:famlynk_version1/mvc/model/profile_model/profile_model.dart';
import 'package:famlynk_version1/mvc/view/profile/edit.dart';
import 'package:famlynk_version1/services/profile_Service.dart';
import 'package:flutter/material.dart';

class ProfileUserDetails extends StatefulWidget {
  // ProfileUserDetails({});

  @override
  _ProfileUserDetailsState createState() => _ProfileUserDetailsState();
}

class _ProfileUserDetailsState extends State<ProfileUserDetails> {
  List<ProfileUserModel> _members = [];
  var isLoaded = false;
  @override
  void initState() {
    super.initState();
    _fetchMembers();
  }

  Future<void> _fetchMembers() async {
    try {
      ProfileUserService memberService = ProfileUserService();
      List<ProfileUserModel> members =
          await memberService.fetchMembersByUserId();
      setState(() {
        _members = members;
        isLoaded = true;
      });
    } catch (e) {
      print('Error fetching members: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Profile User Details'),
        ),
        body: isLoaded
            ? ListView.builder(
                itemCount: _members.length,
                itemBuilder: (context, index) {
                  ProfileUserModel member = _members[index];
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(20, 50, 20, 30),
                    child: SingleChildScrollView(
                        child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // CircleAvatar(backgroundImage: member.profileImage.toString(),),
                                CircleAvatar(
                                  child: Text(member.profileImage.toString()),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  'Name: ${member.name}',
                                  style: TextStyle(fontSize: 17),
                                ),
                                SizedBox(height: 5),
                                Divider(
                                  thickness: 1,
                                  color: Colors.blue,
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Date of Birth: ${member.dateOfBirth.toString().split(' ')[0]}',
                                  style: TextStyle(fontSize: 17),
                                ),
                                SizedBox(height: 5),
                                Divider(
                                  thickness: 1,
                                  color: Colors.blue,
                                ),
                                Text(
                                  'Gender: ${member.gender}',
                                  style: TextStyle(fontSize: 17),
                                ),
                                SizedBox(height: 5),
                                Divider(
                                  thickness: 1,
                                  color: Colors.blue,
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Email: ${member.email}',
                                  style: TextStyle(fontSize: 17),
                                ),
                                SizedBox(height: 5),
                                Divider(
                                  thickness: 1,
                                  color: Colors.blue,
                                ),
                                Text(
                                  'Mobile: ${member.mobileNo}',
                                  style: TextStyle(fontSize: 17),
                                ),
                                SizedBox(height: 5),
                                Divider(
                                  thickness: 1,
                                  color: Colors.blue,
                                ),
                                Text(
                                  'Gender: ${member.gender}',
                                  style: TextStyle(fontSize: 17),
                                ),
                                SizedBox(height: 5),
                                Divider(
                                  thickness: 1,
                                  color: Colors.blue,
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'HomeTown: ${member.hometown}',
                                  style: TextStyle(fontSize: 17),
                                ),
                                SizedBox(height: 5),
                                Divider(
                                  thickness: 1,
                                  color: Colors.blue,
                                ),
                                Text(
                                  'Address: ${member.address}',
                                  style: TextStyle(fontSize: 17),
                                ),
                                SizedBox(height: 5),
                                Divider(
                                  thickness: 1,
                                  color: Colors.blue,
                                ),
                                Text(
                                  'Marital Status: ${member.maritalStatus}',
                                  style: TextStyle(fontSize: 17),
                                ),
                                SizedBox(height: 5),
                                IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  EditProfilePage(
                                                      profileUserModel:
                                                          _members[index])));
                                    },
                                    icon: Icon(Icons.edit))
                              ],
                            ))
                          ],
                        ),
                      ),
                    )),
                  );
                },
              )
            : Center(
                child: CircularProgressIndicator(),
              ));
  }
}
