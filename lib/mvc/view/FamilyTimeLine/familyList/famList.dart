import 'dart:ffi';

import 'package:famlynk_version1/mvc/controller/commonWidgets.dart';
import 'package:famlynk_version1/mvc/model/famlistModelss.dart';
import 'package:famlynk_version1/services/famlistServicess.dart';
import 'package:flutter/material.dart';

class FamilyList extends StatefulWidget {
  @override
  _FamilyListState createState() => _FamilyListState();
}

class _FamilyListState extends State<FamilyList> {
  var isLoaded = false;
  late List<FamListModel> familyList = [];

  @override
  void initState() {
    super.initState();
    // fetchFamilyMembers();
  }

  Future<void> fetchFamilyMembers() async {
    ShowFamilyMemberService _familyMemberService = ShowFamilyMemberService();
    if (familyList!.isEmpty) {
      try {
        familyList = await _familyMemberService.getFamilyList();
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
      body: FutureBuilder(
          future: fetchFamilyMembers(),
          builder: (context, data) {
            return ListView.builder(
              itemCount: familyList.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Container(
                    margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Color.fromARGB(255, 221, 232, 232)),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: CommonWidget.getImage(
                              base64String: familyList[index].image.toString()),
                        ),
                        Column(
                          children: [
                            Text('Name : ${familyList[index].name.toString()}',
                                style: TextStyle(fontSize: 17)),
                            Text(
                                'Relation : ${familyList[index].relation.toString()}',
                                style: TextStyle(fontSize: 17)),
                          ],
                        ),
                        Spacer(),
                        Center(
                          child: PopupMenuButton(
                              itemBuilder: (BuildContext context) => [
                                    PopupMenuItem(
                                        child: TextButton(
                                            onPressed: () {},
                                            child: Text("edit"))),
                                    PopupMenuItem(
                                        child: TextButton(
                                            onPressed: () {},
                                            child: Text("delete"))),
                                  ]),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}
