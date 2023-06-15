import 'package:famlynk_version1/mvc/controller/dropDown.dart';
import 'package:famlynk_version1/mvc/view/FamilyTimeLine/familyList/famList.dart';
import 'package:famlynk_version1/mvc/model/suggestionModel.dart';

import 'package:flutter/material.dart';

class UserDetailsPage extends StatefulWidget {
  UserDetailsPage({
    super.key,
    this.name,
    this.gender,
    this.dateOfBirth,
    this.email,
    this.maritalStatus,
    this.hometown,
    this.profileImage,
    this.address,
    this.uniqueUserId,
  });
  final String? name;
  final String? gender;
  final String? dateOfBirth;
  final String? email;
  final String? maritalStatus;
  final String? hometown;
  final String? profileImage;
  final String? address;
  final String? uniqueUserId;
  @override
  _UserDetailsPageState createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  final _formKey = GlobalKey<FormState>();
  String dropdownValue1 = 'Select Relation';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage("assets/images/google.png"),
                  backgroundColor: Colors.transparent,
                ),
              ],
            ),
            SizedBox(height: 70),
            Text(
              'Name: ${widget.name}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 8.0),
            Divider(thickness: 2),
            SizedBox(height: 8.0),
            Text(
              'Gender: ${widget.gender}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 8.0),
            Divider(thickness: 2),
            SizedBox(height: 8.0),
            Text(
              'Date of Birth: ${widget.dateOfBirth}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 8.0),
            Divider(thickness: 2),
            SizedBox(height: 8.0),
            Text(
              'Email: ${widget.email}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 8.0),
            Divider(thickness: 2),
            SizedBox(height: 8.0),
            Text(
              'Address: ${widget.address}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 8.0),
            Divider(thickness: 2),
            SizedBox(height: 8.0),
            Text(
              'HomeTown: ${widget.hometown}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 8.0),
            Divider(thickness: 2),
            SizedBox(height: 8.0),
            Container(
              child: DropdownButtonFormField(
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                    fillColor: Colors.grey.shade200,
                    filled: true,
                    hintStyle: TextStyle(color: Colors.grey[500])),
                dropdownColor: Color.fromARGB(255, 255, 255, 255),
                value: dropdownValue1,
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue1 = newValue!;
                  });
                },
                items: relation.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 15),
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FamilyList()),
                  );
                },
                child: Text("Add to Family"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
