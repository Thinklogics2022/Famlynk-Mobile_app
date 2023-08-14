import 'package:famlynk_version1/services/profileService/notificationService.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../model/profile_model/notificationModel.dart';

class Notifications extends StatefulWidget {
  const Notifications({
    super.key,
  });

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  List<NotificationModel> notificationModel = [];
  NotificationService notificationService = NotificationService();
  bool isLoaded = true;
  String userId = "";
  @override
  void initState() {
    super.initState();
    fetchAPI();
  }

  Future<void> fetchAPI() async {
    if (notificationModel.isEmpty) {
      try {
        notificationModel = await notificationService.notificationService();

        setState(() {
          isLoaded = true;
        });
        final prefs = await SharedPreferences.getInstance();
        userId = prefs.getString('userId') ?? '';
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: HexColor('#0175C8'),
          title: Text(
            'Family Request',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: isLoaded
            ? notificationModel.isEmpty
                ? Center(
                    child: Text("No more notifications"),
                  )
                : Container(
                    child: ListView.builder(
                    itemCount: notificationModel.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Container(
                                  child: CircleAvatar(
                                    radius: 45,
                                    backgroundImage: NetworkImage(
                                        notificationModel[index]
                                            .profileImage
                                            .toString()),
                                  ),
                                ),
                                SizedBox(width: 20),
                                Column(
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          notificationModel[index]
                                              .fromName
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontStyle: FontStyle.italic,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          notificationModel[index]
                                              .relation
                                              .toString(),
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      child: Row(
                                        children: [
                                          ElevatedButton(
                                              onPressed: () {
                                                notificationService
                                                    .acceptNotificationService(
                                                  notificationModel[index]
                                                      .fromUniqueUserId
                                                      .toString(),
                                                  notificationModel[index]
                                                      .relation
                                                      .toString(),
                                                  notificationModel[index]
                                                      .toUniqueUserId
                                                      .toString(),
                                                );
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.green),
                                              child: Text("Accept")),
                                          SizedBox(width: 30),
                                          ElevatedButton(
                                              onPressed: () {
                                                notificationService
                                                    .declineNotificationService(
                                                        notificationModel[index]
                                                            .fromUserId
                                                            .toString(),
                                                        notificationModel[index]
                                                            .toUniqueUserId
                                                            .toString());
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Notifications()));
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.red),
                                              child: Text("Decline"))
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ))
            : Center(
                child: CircularProgressIndicator(),
              ));
  }
}
