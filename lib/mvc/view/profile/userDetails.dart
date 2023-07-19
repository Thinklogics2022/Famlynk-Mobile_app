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

class UserDetailsPages extends StatelessWidget {
  final User user;

  UserDetailsPages(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 80,
                  backgroundImage: NetworkImage(user.image),
                ),
              ),
              SizedBox(height: 40),
              Text(
                'Name: ${user.name}',
                style: TextStyle(fontSize: 27),
              ),
              SizedBox(height: 3),
              Divider(
                thickness: 2,
              ),
              SizedBox(height: 3),
              Text(
                'Date of Birth: ${user.dob.toString().split(' ')[0]}',
                style: TextStyle(fontSize: 27),
              ),
              SizedBox(height: 3),
              Divider(
                thickness: 2,
              ),
              SizedBox(height: 3),
              Text(
                'Gender: ${user.gender}',
                style: TextStyle(fontSize: 27),
              ),
              SizedBox(height: 3),
              Divider(
                thickness: 2,
              ),
              SizedBox(height: 3),
              Text(
                'Email: ${user.email}',
                style: TextStyle(fontSize: 27),
              ),
              SizedBox(height: 3),
              Divider(
                thickness: 2,
              ),
              SizedBox(height: 3),
              Text(
                'Phone: ${user.phone}',
                style: TextStyle(fontSize: 27),
              ),
              SizedBox(height: 3),
              Divider(
                thickness: 2,
              ),
              SizedBox(height: 3),
              Text(
                'Home Town: ${user.address}',
                style: TextStyle(fontSize: 27),
              ),
              SizedBox(height: 3),
              Divider(
                thickness: 2,
              ),
              SizedBox(height: 3),
              Text(
                'Address: ${user.address}',
                style: TextStyle(fontSize: 27),
              ),
              SizedBox(height: 3),
              Divider(
                thickness: 2,
              ),
              SizedBox(height: 3),
              Row(
                children: [
                  Text(
                    'Marital Status: ',
                    style: TextStyle(fontSize: 25,),
                  ),
                  Text(
                    '${user.address}',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 3),
              Divider(
                thickness: 2,
              ),
              SizedBox(height: 3),
            ],
          ),
        ),
      ),
    );
  }
}

