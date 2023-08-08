import 'package:famlynk_version1/mvc/model/familyMembers/famlist_modelss.dart';
import 'package:famlynk_version1/mvc/view/familyList/family.dart';
import 'package:famlynk_version1/mvc/view/familyList/about.dart';
import 'package:famlynk_version1/mvc/view/myTimeLine/photo.dart';
import 'package:famlynk_version1/mvc/view/myTimeLine/myNewsFeed.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../services/familySevice/individulaUserService.dart';

class TabBarPage extends StatefulWidget {
  const TabBarPage({Key? key, required this.uniqueUserId}) : super(key: key);

  final String uniqueUserId;
  @override
  _TabBarPageState createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage>
    with SingleTickerProviderStateMixin {
  FamListModel famListModel = FamListModel();
  IndividulaUserService individulaUserService = IndividulaUserService();
  late TabController _tabController;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    fetchFamilyMembers(widget.uniqueUserId);
  }

  fetchFamilyMembers(String uniqueUserID) async {
    try {
      famListModel = await individulaUserService
          .individulaUserService(widget.uniqueUserId);
      setState(() {
        isLoading = false;
      });
      print(famListModel.relation);
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: HexColor('#0175C8'),
        title: Text(
          'Family Members',
          style: TextStyle(color: Colors.white),
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(icon: Icon(Icons.account_box), text: "About"),
            Tab(icon: Icon(Icons.people), text: "Family"),
          ],
          labelPadding: EdgeInsets.symmetric(horizontal: 2),
          unselectedLabelColor: Colors.white,
          labelColor: HexColor('#FF6F20'),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          About(
            name: famListModel.name.toString(),
            gender: famListModel.gender.toString(),
            dateOfBirth: famListModel.dob.toString(),
            email: famListModel.email.toString(),
            uniqueUserId: famListModel.uniqueUserID.toString(),
            userId: famListModel.userId.toString(),
            image: famListModel.image.toString(),
          ),
          Family(userId: famListModel.userId.toString())
        ],
      ),
    );
  }
}
