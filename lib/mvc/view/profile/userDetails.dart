import 'package:flutter/material.dart';

class User {
  final String name;
  final DateTime dob;
  final String gender;
  final String email;
  final String phone;
  final String address;
  final String image;
  User({
    required this.name,
    required this.dob,
    required this.gender,
    required this.email,
    required this.phone,
    required this.address,
    required this.image,
  });
}
class UserDetailsPage extends StatelessWidget {
  final User user;
  UserDetailsPage(this.user);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 226, 237, 246),
      appBar: AppBar(
        title: Text('User Details'),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 40, 20, 30),
        child: SingleChildScrollView(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Center(
                    // child: CircleAvatar(
                    //   radius: 60,
                    //   backgroundImage: NetworkImage(user.image),
                    // ),
                    child: CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(
                            "https://dfstudio-d420.kxcdn.com/wordpress/wp-content/uploads/2019/06/digital_camera_photo-1080x675.jpg")),
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Name: ${user.name}',
                    style: TextStyle(fontSize: 17),
                  ),
                  SizedBox(height: 5),
                  Divider(
                    thickness: 1,
                    color: Colors.blue,
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Date of Birth: ${user.dob.toString().split(' ')[0]}',
                    style: TextStyle(fontSize: 17),
                  ),
                  SizedBox(height: 5),
                  Divider(
                    thickness: 1,
                    color: Colors.blue,
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Gender: ${user.gender}',
                    style: TextStyle(fontSize: 17),
                  ),
                  SizedBox(height: 5),
                  Divider(
                    thickness: 1,
                    color: Colors.blue,
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Email: ${user.email}',
                    style: TextStyle(fontSize: 17),
                  ),
                  SizedBox(height: 3),
                  Divider(
                    thickness: 1,
                    color: Colors.blue,
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Phone: ${user.phone}',
                    style: TextStyle(fontSize: 17),
                  ),
                  SizedBox(height: 5),
                  Divider(
                    thickness: 1,
                    color: Colors.blue,
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Home Town: ${user.address}',
                    style: TextStyle(fontSize: 17),
                  ),
                  SizedBox(height: 5),
                  Divider(
                    thickness: 1,
                    color: Colors.blue,
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Address: ${user.address}',
                    style: TextStyle(fontSize: 17),
                  ),
                  SizedBox(height: 3),
                  Divider(
                    thickness: 1,
                    color: Colors.blue,
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        'Marital Status: ',
                        style: TextStyle(fontSize: 17),
                      ),
                      Text(
                        '${user.address}',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}