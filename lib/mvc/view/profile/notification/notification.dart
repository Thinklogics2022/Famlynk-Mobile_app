import 'package:famlynk_version1/services/profileService/notificationService.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../model/profile_model/notificationModel.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  
  List<NotificationModel> notificationModel = [];
  NotificationService notificationService = NotificationService();
  bool isLoaded = true;
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
      body: Container(
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
                            notificationModel[index].profileImage.toString()),
                      ),
                    ),
                    SizedBox(width: 20),
                    Column(
                      children: [
                        Column(
                          children: [
                            Text(
                              notificationModel[index].fromName.toString(),
                              style: TextStyle(
                                  fontSize: 20,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              notificationModel[index].relation.toString(),
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                        Container(
                          child: Row(
                            children: [
                              ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green),
                                  child: Text("Accept")),
                              SizedBox(width: 30),
                              ElevatedButton(
                                  onPressed: () {},
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
          // return Card(
          //   child: Container(
          //     margin: EdgeInsets.all(20),
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(14),
          //       color: Color.fromARGB(255, 221, 232, 232),
          //     ),
          //     child: Column(
          //       children: [
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.start,
          //           crossAxisAlignment: CrossAxisAlignment.center,
          //           children: [

          //             Padding(
          //               padding: const EdgeInsets.all(8.0),
          //               child: CircleAvatar(
          //                 radius: 35,
          //                 backgroundImage: NetworkImage(
          //                     notificationModel[index].profileImage.toString()),
          //               ),
          //             ),
          //             SizedBox(width: 20),
          //             Container(
          //               child: Column(
          //                 crossAxisAlignment: CrossAxisAlignment.center,
          //                 children: [
          //                   Text(
          //                     notificationModel[index].toName.toString(),
          //                     style: TextStyle(
          //                         fontSize: 17, fontWeight: FontWeight.bold),
          //                   ),
          //                   Text(notificationModel[index].relation.toString()),
          //                 ],
          //               ),
          //             ),
          //           ],
          //         ),
          //         Container(
          //           child: Row(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               ElevatedButton(
          //                   onPressed: () {},
          //                   style:
          //                       ElevatedButton.styleFrom(primary: Colors.green),
          //                   child: Text("Accept")),
          //               SizedBox(width: 30),
          //               ElevatedButton(
          //                   onPressed: () {},
          //                   style:
          //                       ElevatedButton.styleFrom(primary: Colors.red),
          //                   child: Text("Decline")),
          //             ],
          //           ),
          //         ),
          //         SizedBox(
          //           height: 20,
          //         )
          //       ],
          //     ),
          //   ),
          // );
        },
      )),
    );
  }
}










// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:hexcolor/hexcolor.dart';

// class Notifications extends StatefulWidget {
//   const Notifications({super.key});

//   @override
//   State<Notifications> createState() => _NotificationsState();
// }

// class _NotificationsState extends State<Notifications> {
//   // Sample data for demonstration
//   final List<Map<String, dynamic>> notificationData = [
//     {'name': 'John Doe', 'image': 'assets/profile_image.png'},
//     {'name': 'Jane Smith', 'image': 'assets/profile_image.png'},
//     // Add more data as needed
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: HexColor('#0175C8'),
//         iconTheme: IconThemeData(color: Colors.white),
//         title: Text(
//           'Family Requests',
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//       body: ListView.builder(
//         itemCount: notificationData.length,
//         itemBuilder: (context, index) {
//           final notification = notificationData[index];
//           return NotificationCard(
//             name: notification['name'],
//             image: notification['image'],
//           );
//         },
//       ),
//     );
//   }
// }

// class NotificationCard extends StatelessWidget {
//   final String name;
//   final String image;

//   NotificationCard({required this.name, required this.image});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//         margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//         child: Padding(
//             padding: EdgeInsets.all(15),
//             child: Row(children: [
//               CircleAvatar(
//                 backgroundImage: AssetImage(image), // Replace with your image
//                 radius: 40,
//               ),
//               SizedBox(width: 20),
//               Column(
//                 children: [
//                   Row(
//                     children: [
//                       Text(
//                         name,
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Text(
//                         name,
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 10),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       ElevatedButton(
//                         onPressed: () {
                        
//                         },
//                         style: ElevatedButton.styleFrom(
//                           primary: Colors.green,
//                         ),
//                         child: Text('Accept'),
//                       ),
//                       SizedBox(width: 20),
//                       ElevatedButton(
//                         onPressed: () {
//                           // Add your decline logic here
//                         },
//                         style: ElevatedButton.styleFrom(
//                           primary: Colors.red,
//                         ),
//                         child: Text('Decline'),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ]
//                 // child: Column(
//                 //   children: [
//                 //     CircleAvatar(
//                 //       backgroundImage: AssetImage(image), // Replace with your image
//                 //       radius: 40,
//                 //     ),
//                 //     SizedBox(height: 10),
//                 //     Text(
//                 //       name,
//                 //       style: TextStyle(
//                 //         fontSize: 18,
//                 //         fontWeight: FontWeight.bold,
//                 //       ),
//                 //     ),
//                 //     SizedBox(height: 10),
//                 //     Row(
//                 //       mainAxisAlignment: MainAxisAlignment.center,
//                 //       children: [
//                 //         ElevatedButton(
//                 //           onPressed: () {
//                 //             // Add your accept logic here
//                 //           },
//                 //           style: ElevatedButton.styleFrom(
//                 //             primary: Colors.green,
//                 //           ),
//                 //           child: Text('Accept'),
//                 //         ),
//                 //         SizedBox(width: 20),
//                 //         ElevatedButton(
//                 //           onPressed: () {
//                 //             // Add your decline logic here
//                 //           },
//                 //           style: ElevatedButton.styleFrom(
//                 //             primary: Colors.red,
//                 //           ),
//                 //           child: Text('Decline'),
//                 //         ),
//                 //       ],
//                 //     ),
//                 //   ],
//                 // ),
//                 )));
//   }
// }
