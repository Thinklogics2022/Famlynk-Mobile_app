import 'package:famlynk_version1/mvc/model/famlistModelss.dart';
import 'package:famlynk_version1/services/famlistServicess.dart';
import 'package:flutter/material.dart';


class FamilyList extends StatefulWidget {
  @override
  _FamilyListState createState() => _FamilyListState();
}

class _FamilyListState extends State<FamilyList> {
  var isLoaded = false;
  // List<FamListModel> _familyMembers = [];
  late List<FamListModel> familyList = [];

  @override
  void initState() {
    super.initState();
    fetchFamilyMembers();
  }

  Future<void> fetchFamilyMembers() async {
    ShowFamilyMemberService _familyMemberService =
        ShowFamilyMemberService();
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
                      color: Color.fromARGB(255, 192, 189, 189),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 15,
                              ),
                              SizedBox(width: 55),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      'Name : ${familyList[index].name.toString()}',
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ],
                          ),
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
