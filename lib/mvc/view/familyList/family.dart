import 'package:famlynk_version1/mvc/controller/dropDown.dart';
import 'package:flutter/material.dart';

import '../../../services/familySevice/individulaUserService.dart';
import '../../model/familyMembers/famlist_modelss.dart';

class Family extends StatefulWidget {
  const Family({super.key, required this.userId});
  final String userId;
  @override
  State<Family> createState() => _FamilyState();
}

class _FamilyState extends State<Family> {
  var isLoaded = false;
  FamListModel famListModel = FamListModel();
  List<FamListModel> familyList = [];

  IndividulaUserService individulaUserService = IndividulaUserService();

  @override
  void initState() {
    super.initState();
    fetchAPI();
  }

  Future<void> fetchAPI() async {
    if (familyList.isEmpty) {
      try {
        familyList = await individulaUserService.familyService(widget.userId);
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

  String capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoaded
          ? familyList.isEmpty
              ? Center(child: Text("There is no list to show"))
              : ListView.builder(
                  itemCount: familyList.length,
                  itemBuilder: (context, index) {
                    return  InkWell(
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
              backgroundImage: familyList[index].image != null
                  ? NetworkImage(familyList[index].image.toString())
                  : null, 
                      backgroundColor: backgroundColors[index % backgroundColors.length],

              child: familyList[index].image != null
                  ? null // Don't display text if an image is available
                  : Text(
                      familyList[index].name!.isNotEmpty
                          ? familyList[index].name![0].toUpperCase()
                          : "?",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
            ),
          ),
          SizedBox(width: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                familyList[index].name.toString(),
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                capitalizeFirstLetter(
                  familyList[index].firstLevelRelation.toString(),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  ),
);

                  })
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
