import 'package:famlynk_version1/mvc/controller/commonWidgets.dart';
import 'package:famlynk_version1/mvc/model/famlist_modelss.dart';
import 'package:famlynk_version1/services/dltFamList_service.dart';
import 'package:famlynk_version1/services/famlist_servicess.dart';
import 'package:famlynk_version1/utils/utils.dart';
import 'package:flutter/material.dart';

class FamilyList extends StatefulWidget {
  @override
  _FamilyListState createState() => _FamilyListState();
}

class _FamilyListState extends State<FamilyList> {
  var isLoaded = false;
  List<FamListModel> familyList = [];
  DltMemberService dltMemberService = DltMemberService();

  @override
  void initState() {
    super.initState();
    fetchFamilyMembers();
  }

  Future<void> fetchFamilyMembers() async {
    ShowFamilyMemberService _familyMemberService = ShowFamilyMemberService();
    if (familyList.isEmpty) {
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

  Future<void> deleteFamilyMember(String userId, String uniqueUserId) async {
    try {
      await dltMemberService.deleteFamilyMember(userId, uniqueUserId);
      setState(() {
        // Update the familyList by removing the deleted member
        familyList.removeWhere((member) =>
            member.userId.toString() == userId &&
            member.uniqueUserId.toString() == uniqueUserId);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoaded
          ? ListView.builder(
              itemCount: familyList.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Container(
                    margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: Color.fromARGB(255, 221, 232, 232),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: CommonWidget.getImage(
                            base64String: familyList[index].image.toString(),
                          ),
                        ),
                        SizedBox(width: 20),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Name  : ${familyList[index].name.toString()}',
                              style: TextStyle(fontSize: 17),
                            ),
                            Text(
                              'Relation : ${familyList[index].relation.toString()}',
                              style: TextStyle(fontSize: 17),
                            ),
                          ],
                        ),
                        Spacer(),
                        Center(
                          child: PopupMenuButton(
                            itemBuilder: (BuildContext context) => [
                              PopupMenuItem(
                                child: TextButton(
                                  onPressed: () {
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             UpdateFamMember(
                                    //               updateMember:
                                    //                   familyList[index],
                                    //             )));
                                  },
                                  child: Text("edit"),
                                ),
                              ),
                              PopupMenuItem(
                                child: TextButton(
                                  onPressed: () {
                                    _showMyDialog(
                                      familyList[index].uniqueUserId.toString(),
                                      familyList[index].userId.toString(),
                                    );
                                  },
                                  child: Text("delete"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Future<void> _showMyDialog(String userId, String uniqueUserId) async {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    Text('Are you sure want to delete'),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text('Confirm'),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => FamilyList()));
                    dltMemberService.deleteFamilyMember(userId, uniqueUserId);
                  },
                ),
              ]);
        });
  }
}
