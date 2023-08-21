import 'package:famlynk_version1/mvc/view/familyTree/firstLevel.dart';
import 'package:famlynk_version1/mvc/view/familyTree/secondLevel.dart';
import 'package:famlynk_version1/mvc/view/familyTree/thirdLevel.dart';
import 'package:famlynk_version1/mvc/view/navigationBar/navBar.dart';
import 'package:flutter/material.dart';

class FamilyTree extends StatefulWidget {
  const FamilyTree({Key? key}) : super(key: key);

  @override
  _FamilyTreeState createState() => _FamilyTreeState();
}

class _FamilyTreeState extends State<FamilyTree>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        body: Column(
          children: [
            TabBar(
              labelColor: Colors.blue, 
              controller: tabController,
              tabs: [
                Tab(child: Text('FirstLevel')),
                Tab(child: Text('SecondLevel')),
                Tab(child: Text('ThirdLevel')),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  FirstLevelRelation(),
                  SecondLevelRelation(),
                  ThirdLevelRelation(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future<bool> _onBackPressed() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => NavBar()),
    );
    return Future.value(false);
  }
}
