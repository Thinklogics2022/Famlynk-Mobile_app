import 'package:famlynk_version1/mvc/view/profile/myTimeLine/myComment.dart';
import 'package:famlynk_version1/mvc/view/profile/myTimeLine/myNewsFeed.dart';
import 'package:famlynk_version1/mvc/view/profile/myTimeLine/photo.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class MyTimeLine extends StatefulWidget {
  const MyTimeLine({Key? key}) : super(key: key);

  @override
  _MyTimeLineState createState() => _MyTimeLineState();
}

class _MyTimeLineState extends State<MyTimeLine> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
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
        title: Text('MyTimeLine',style: TextStyle(color: Colors.white),),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(icon: Icon(Icons.newspaper), text: "MyTimeLine"),
            Tab(icon: Icon(Icons.photo), text: "Photo"),
            Tab(icon: Icon(Icons.comment), text: "Photo"),
            Tab(icon: Icon(Icons.favorite), text: "Photo"),
          ],
          unselectedLabelColor: Colors.white,
          labelColor: HexColor('#FF6F20'),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          MyNewsFeed(),
          PhotoPage(),
          MyComment(),
        ],
      ),
    );
  }
}
