import 'package:famlynk_version1/mvc/view/FamilyTimeLine/profile/logout.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../constants/constVariables.dart';
import '../addmember/addMember.dart';
import '../gallery/gallery.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String name ='';

  
  Future<void>fetchData()async{
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name')?? '';
    });
  }
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  MyProperties myProperties = new MyProperties();

  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(40),
        child: Center(
            child: Container(
              child: Column(children: [
                
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR9YYh5Fk1u9VsWWr1MhkyQeOzeNbtnnMO96g&usqp=CAU'),
                  radius: 50,
                ),
                SizedBox(height: 20),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text("$name"),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.calendar_month_outlined),
                  title: Text("Dob"),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.person_2),
                  title: Text("Gender"),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.mail),
                  title: Text("Mail"),
                ),
                Container(
                  child: InkWell(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Gallery()),
                                  );
                                },
                                child: Text(
                                  "Gallery",
                                  style: TextStyle(fontSize: 16),
                                )),
                            SizedBox(width: 70),
                          ],
                        ),
                        Row(
                          children: [
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddMember()),
                                  );
                                },
                                child: Text("Add family member",
                                    style: TextStyle(fontSize: 16))),
                            SizedBox(width: 40),
                            
                          ],
                        ),
                        Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FamlynkLogout()));
                              },
                             
                              child: const Text('LogOut'),
                            ),
                            SizedBox(width: 70),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            )),
      ),
    ));
  }
}
