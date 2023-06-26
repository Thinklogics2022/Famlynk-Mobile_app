import 'package:famlynk_version1/constants/constVariables.dart';
import 'package:famlynk_version1/mvc/view/addmember/addMember.dart';
import 'package:famlynk_version1/mvc/view/familyTree/famTree.dart';
import 'package:famlynk_version1/mvc/view/newsFeed/newsFeed.dart';
import 'package:famlynk_version1/mvc/view/profile/profile.dart';
import 'package:famlynk_version1/mvc/view/suggestion/suggestion.dart';
import 'package:famlynk_version1/mvc/view/watsApp_message/message.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../familyList/famList.dart';


class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;
  MyProperties myProperties = MyProperties();

  final List<Widget> _pages = [
    FamlynkNewsFeed(),
    Home(),
    CircleAvatarLayout(),
    Profile(),
  ];

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leadingWidth: 30,
          actions: [
            PopupMenuButton<int>(
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 1,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddMember()),
                          );
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.person_add_alt_1,
                              color: Colors.black,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Add Member",
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 2,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Row(
                          children: [
                            Icon(
                              Icons.notification_add,
                              color: Colors.black,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Notification",
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 3,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SuggestionScreen()),
                          );
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.search,
                              color: Colors.black,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Search",
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 4,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FamilyList()),
                          );
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.family_restroom_outlined,
                              color: Colors.black,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Family List",
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              offset: Offset(0, 70),
              // color: Colors.grey,
              elevation: 2,
            ),
          ],
          title: GestureDetector(
            onTap: () {
              _onTabSelected(0); // Navigate to the news feed page
            },
            child: Row(
              children: [
                Image.asset(
                  'assets/images/FL01.png',
                  width: 30,
                  height: 30,
                ),
                SizedBox(width: 8),
                Text(
                  "FAMLYNK",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
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
          backgroundColor: myProperties
              .buttonColor, // Change the background color to green here
          selectedItemColor:
              const Color.fromARGB(255, 255, 255, 255), // Change the selected icon color here
          unselectedItemColor:
              const Color.fromARGB(255, 219, 219, 219), // Change the unselected icon color here
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
                FontAwesomeIcons.whatsapp,
                size: 25.0,
              ),
              label: 'WhatsApp',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.family_restroom_outlined,
                size: 25.0,
              ),
              label: 'Genealogy',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.account_circle_rounded,
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
