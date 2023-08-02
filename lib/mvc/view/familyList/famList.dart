import 'package:famlynk_version1/mvc/model/familyMembers/famlist_modelss.dart';
import 'package:famlynk_version1/mvc/view/familyList/famDetails.dart';
import 'package:famlynk_version1/mvc/view/familyList/updateFamList.dart';
import 'package:famlynk_version1/mvc/view/navigationBar/navBar.dart';
import 'package:famlynk_version1/services/familySevice/dltFamList_service.dart';
import 'package:famlynk_version1/services/familySevice/famlist_servicess.dart';
import 'package:flutter/material.dart';

class FamilyList extends StatefulWidget {
  @override
  _FamilyListState createState() => _FamilyListState();
}

class _FamilyListState extends State<FamilyList> {
  var isLoaded = false;
  List<FamListModel> familyList = [];
  DltMemberService dltMemberService = DltMemberService();
  ShowFamilyMemberService _familyMemberService = ShowFamilyMemberService();

  @override
  void initState() {
    super.initState();
    fetchFamilyMembers();
  }

  Future<void> fetchFamilyMembers() async {
    if (familyList.isEmpty) {
      try {
        familyList = await _familyMemberService.getFamilyList();
        if (familyList.isNotEmpty) {
          familyList = familyList.sublist(1);
        }
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
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        body: isLoaded
            ? familyList.isEmpty
                ? Center(
                    child: Text('There is no more family list.'),
                  )
                : ListView.builder(
                    itemCount: familyList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        child: Card(
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
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    radius: 35,
                                    backgroundImage: NetworkImage(
                                        familyList[index].image.toString()),
                                  ),
                                ),
                                SizedBox(width: 20),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      familyList[index].name.toString(),
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(familyList[index].relation.toString()),
                                  ],
                                ),
                                Spacer(),
                                Center(
                                  child: PopupMenuButton(
                                    itemBuilder: (BuildContext context) => [
                                      PopupMenuItem(
                                        child: TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    UpdateFamList(
                                                  updateMember:
                                                      familyList[index],
                                                ),
                                              ),
                                            );
                                          },
                                          child: Text("edit",style: TextStyle(color: Colors.blue),),
                                        ),
                                      ),
                                      PopupMenuItem(
                                        child: TextButton(
                                          onPressed: () {
                                            _showMyDialog(
                                              familyList[index]
                                                  .userId
                                                  .toString(),
                                              familyList[index]
                                                  .uniqueUserID
                                                  .toString(),
                                            );
                                            print(familyList[index]
                                                .uniqueUserID
                                                .toString());
                                          },
                                          child: Text("delete", style: TextStyle(color: Colors.blue),),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MemberDetails(
                                      details: familyList[index])));
                        },
                      );
                    },
                  )
            : Center(
                child: CircularProgressIndicator(),
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

  Future<void> _showMyDialog(String userId, String uniqueUserID) async {
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
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => NavBar()),
                );
                dltMemberService.deleteFamilyMember(userId, uniqueUserID);
              },
            ),
          ],
        );
      },
    );
  }
}
