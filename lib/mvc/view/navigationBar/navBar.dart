import 'package:famlynk_version1/mvc/view/addmember/addMember.dart';
import 'package:famlynk_version1/mvc/view/familyTree/famTree.dart';
import 'package:famlynk_version1/mvc/view/newsFeed/fresh.dart';
import 'package:famlynk_version1/mvc/view/profile/profile.dart';
import 'package:famlynk_version1/mvc/view/suggestion/suggestion.dart';
import 'package:famlynk_version1/mvc/view/watsApp_message/message.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../familyList/famList.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this, initialIndex: 0)
      ..addListener(() {
        setState(() {});
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
                       Text(
                        "add member",
                        style: TextStyle(color: Colors.black),
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddMember()));
                          },
                          icon: Icon(
                            Icons.person_add_alt_1,
                            color: Colors.black,
                          )),
                      SizedBox(
                        width: 10,
                      ),

                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 2,
                  child: Row(
                    children: [
                       Text(
                        "notifications",
                        style: TextStyle(color: Colors.black),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.notification_add,
                              color: Colors.black)),
                      SizedBox(
                        width: 10,
                      ),

                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 2,
                  child: Row(
                    children: [
                       Text(
                        "search",
                        style: TextStyle(color: Colors.black),
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SuggestionScreen()));
                          },
                          icon: Icon(
                            Icons.search,
                            color: Colors.black,
                          )),
                      SizedBox(
                        width: 10,
                      ),

                    ],
                  ),
                ),
              ],
              offset: Offset(0, 100),
              // color: Colors.grey,
              elevation: 2,
            ),
          ],
          title: Row(
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
              // SizedBox(width: MediaQuery.of(context).size.width * 0.40),
              Spacer(),
            ],
          ),
          bottom: TabBar(
            indicatorColor: Colors.white,
            controller: _tabController,
            tabs: [
              Tab(
                icon: Icon(
                  FontAwesomeIcons.fileImage,
                  color: Color.fromARGB(255, 255, 255, 255),
                  size: 25.0,
                ),
              ),
              Tab(
                icon: Icon(
                  FontAwesomeIcons.peopleGroup,
                  color: Color.fromARGB(255, 255, 255, 255),
                  size: 25.0,
                ),
              ),
              Tab(
                icon: Icon(
                  FontAwesomeIcons.whatsapp,
                  color: Color.fromARGB(255, 255, 255, 255),
                  size: 25.0,
                ),
              ),
              Tab(
                icon: Icon(
                  FontAwesomeIcons.objectGroup,
                  color: Color.fromARGB(255, 255, 255, 255),
                  size: 25.0,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.account_circle_rounded,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(controller: _tabController, children: <Widget>[
          FreshNewsFeed(),
          FamilyList(),
          Home(),
          CircleAvatarLayout(),
          Profile(),
        ]),
      ),
    );
  }
}

