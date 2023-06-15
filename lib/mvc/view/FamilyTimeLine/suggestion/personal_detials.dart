import 'package:famlynk_version1/mvc/model/suggestionModel.dart';
import 'package:famlynk_version1/mvc/view/FamilyTimeLine/profile/addMember.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  // final FriendSuggestion friendSuggestion;

  DetailScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Friend Details'),
      ),
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage("assets/images/google.png"),
                  backgroundColor: Colors.transparent,
                ),
              ],
            ),
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(width: 10),
                      Text(
                        "Names",
                        style: TextStyle(
                          fontSize: 40,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      SizedBox(width: 10),
                      Text(
                        "Gender",
                        style: TextStyle(
                          fontSize: 40,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                   children: [
                      SizedBox(width: 10),
                      Text(
                        "D-O-B",
                        style: TextStyle(
                          fontSize: 40,
                        ),
                      ),
                    ],
                  ), 
                  SizedBox(height: 20),
                  Row(
                   children: [
                      SizedBox(width: 10),
                      Text(
                        "Email",
                        style: TextStyle(
                          fontSize: 40,
                        ),
                      ),
                    ],
                  ), 
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddMember()));
              },
              child: Text(
                "Add to Family",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
