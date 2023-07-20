import 'package:famlynk_version1/mvc/controller/dropDown.dart';
import 'package:famlynk_version1/mvc/model/addmember_model/searchAddMember_model.dart';
import 'package:famlynk_version1/mvc/view/familyList/famList.dart';
import 'package:famlynk_version1/services/searchAddMumber_service.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDetails extends StatefulWidget {
  UserDetails(
      {super.key,
      this.name,
      this.gender,
      this.dateOfBirth,
      this.email,
      this.maritalStatus,
      this.hometown,
      this.profileImage,
      this.address,
      this.uniqueUserID,
      this.mobileNo});
  final String? name;
  final String? gender;
  final String? dateOfBirth;
  final String? email;
  final String? maritalStatus;
  final String? hometown;
  final String? profileImage;
  final String? address;
  final String? uniqueUserID;
  final String? mobileNo;
  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  String dropdownValue1 = 'Select Relation';
  String userId = "";

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 223, 233, 242),
      appBar: AppBar(
        title: Text('Family Details'),
        
      ),
      body : Padding(
        padding: const EdgeInsets.all(10),
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: AssetImage("assets/images/FL01.png"),
                        backgroundColor: Colors.transparent,
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  Text(
                    'Name: ${widget.name}',
                    style: TextStyle(fontSize: 17),
                  ),
                  SizedBox(height: 8.0),
                  Divider(thickness: 1, color: Colors.blue),
                  SizedBox(height: 8.0),
                  Text(
                    'Gender: ${widget.gender}',
                    style: TextStyle(fontSize: 17),
                  ),
                  SizedBox(height: 8.0),
                  Divider(thickness: 1, color: Colors.blue,),
                  SizedBox(height: 8.0),
                  Text(
                    'Date of Birth: ${widget.dateOfBirth}',
                    style: TextStyle(fontSize: 17),
                  ),
                  SizedBox(height: 8.0),
                  Divider(thickness: 1, color: Colors.blue,),
                  SizedBox(height: 8.0),
                  Text(
                    'Email: ${widget.email}',
                    style: TextStyle(fontSize: 17),
                  ),
                  SizedBox(height: 8.0),
                  Divider(thickness: 1, color: Colors.blue,),
                  SizedBox(height: 8.0),
                  Text(
                    'Address: ${widget.address}',
                    style: TextStyle(fontSize: 17),
                  ),
                  SizedBox(height: 8.0),
                  Divider(thickness: 1, color: Colors.blue),
                  SizedBox(height: 8.0),
                  Text(
                    'HomeTown: ${widget.hometown}',
                    style: TextStyle(fontSize: 17),
                  ),
                  SizedBox(height: 8.0),
                  Divider(thickness: 1, color: Colors.blue,),
                  SizedBox(height: 8.0),
                  Container(
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          // fillColor: const Color.fromARGB(255, 221, 237, 250),
                          filled: true,
                          hintStyle: TextStyle(color: Colors.grey[500])),
                      // dropdownColor: Color.fromARGB(255, 255, 255, 255),
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
                      onPressed: () async {
                        try {
                          SearchAddMemberService searchAddMemberService =
                              SearchAddMemberService();
                          SearchAddMember searchAddMember = SearchAddMember(
                            famid: '',
                            name: widget.name.toString(),
                            gender: widget.gender.toString(),
                            dob: widget.dateOfBirth.toString(),
                            email: widget.email.toString(),
                            userId: userId,
                            image: widget.profileImage.toString(),
                            mobileNo: widget.mobileNo.toString(),
                            uniqueUserID: widget.uniqueUserID.toString(),
                            relation: dropdownValue1,
                            // createdOn: ,
                            // modifiedOn: ,
                          );
                          await searchAddMemberService
                              .searchAddMemberPost(searchAddMember);
                        } catch (e) {
                          print(e.toString());
                        }
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
          ),
        ),
      ),
    );
  }
}
