import 'package:famlynk_version1/constants/constVariables.dart';
import 'package:famlynk_version1/mvc/model/profile_model/notificationModel.dart';
import 'package:famlynk_version1/mvc/view/familyTree/famTree.dart';
import 'package:famlynk_version1/mvc/view/newsFeed/newsFeed.dart';
import 'package:famlynk_version1/mvc/view/profile/notification/notification.dart';
import 'package:famlynk_version1/mvc/view/profile/profile.dart';
import 'package:famlynk_version1/mvc/view/suggestion/suggestion.dart';
import 'package:famlynk_version1/services/profileService/notificationService.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import '../familyList/famList.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  List<NotificationModel> notificationModel = [];
  NotificationService notificationService = NotificationService();
  var isLoading = false;

  int _selectedIndex = 0;
  MyProperties myProperties = MyProperties();
  @override
  void initState() {
    super.initState();

    fetchAPI();
  }

  final List<Widget> _pages = [
    FamlynkNewsFeed(),
    FamilyList(),
    FamilyTree(),
    Profile(),
  ];

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> fetchAPI() async {
    if (notificationModel.isEmpty) {
      try {
        notificationModel = await notificationService.notificationService();
        //  _updateBadgeCount();
        setState(() {
          isLoading = true;
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
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leadingWidth: 30,
        actions: [
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SuggestionScreen()));
                  },
                  icon: Icon(Icons.search)),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Notifications()));
                  },
                  icon: Badge(
                      label: Text(notificationModel.length.toString()),
                      child: Icon(Icons.notifications))),
              SizedBox(width: 14),
            ],
          )
          // PopupMenuButton<int>(
          //   itemBuilder: (context) => [
          //     PopupMenuItem(
          //       value: 1,
          //       child: Row(
          //         children: [
          //           GestureDetector(
          //             onTap: () {
          //               Navigator.push(
          //                 context,
          //                 MaterialPageRoute(builder: (context) => AddMember()),
          //               );
          //             },
          //             child: Row(
          //               children: [
          //                 Icon(
          //                   Icons.person_add_alt_1,
          //                   color: Colors.black,
          //                 ),
          //                 SizedBox(width: 10),
          //                 Text(
          //                   "Add Member",
          //                   style: TextStyle(color: Colors.black),
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          // PopupMenuItem(
          //   value: 2,
          //   child: Row(
          //     children: [
          //       Row(
          //         children: [
          //           GestureDetector(
          //             onTap: () async {

          //               await Navigator.push(
          //                   context,
          //                   MaterialPageRoute(
          //                       builder: (context) => Notifications()));
          //             },
          //             child: Row(
          //               children: [
          //                 Badge(
          //                   label:
          //                       Text(_badgeCount.toString()),
          //                   child: Icon(
          //                     Icons.notifications,
          //                     color: Colors.black,
          //                   ),
          //                 ),
          //                 SizedBox(width: 10),
          //                 Text(
          //                   "Notification",
          //                   style: TextStyle(color: Colors.black),
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ],
          //       ),
          //     ],
          //   ),
          // ),
          // PopupMenuItem(
          //   value: 3,
          //   child: Row(
          //     children: [
          //       GestureDetector(
          //         onTap: () {
          //           Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //                 builder: (context) => SuggestionScreen()),
          //           );
          //         },
          //         child: Row(
          //           children: [
          //             Icon(
          //               Icons.search,
          //               color: Colors.black,
          //             ),
          //             SizedBox(width: 10),
          //             Text(
          //               "Search",
          //               style: TextStyle(color: Colors.black),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
        // offset: Offset(0, 70),
        // color: Colors.grey,
        // elevation: 2,
        title: GestureDetector(
          onTap: () {
            _onTabSelected(0); // Navigate to the news feed page
          },
          child: Row(
            children: [
              Image.asset(
                'assets/images/FL01.png',
                width: 40,
                height: 40,
              ),
              SizedBox(width: 10),
              Text(
                "Famlynk",
                style: GoogleFonts.dancingScript(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: HexColor('#0175C8')),
                // TextStyle(
                //   color: Colors.white,
                //   fontSize: 20,
                //   fontWeight: FontWeight.bold,
                // ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onTabSelected,
        backgroundColor: Colors.white,
        selectedItemColor: HexColor('#FF6F20'),
        unselectedItemColor: HexColor('#0175C8'),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.home,
              size: 25.0,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.person,
              size: 25.0,
            ),
            label: 'FamilyList',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.tree,
              size: 25.0,
            ),
            label: 'Family Tree',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.personCircleCheck,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
