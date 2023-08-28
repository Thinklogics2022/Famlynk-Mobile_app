import 'package:famlynk_version1/mvc/model/familyTree_model/familyTree_model.dart';
import 'package:famlynk_version1/services/familyTreeService/familyTree_service.dart';
import 'package:flutter/material.dart';

class ThirdLevelRelation extends StatefulWidget {
  const ThirdLevelRelation({super.key});

  @override
  State<ThirdLevelRelation> createState() => _ThirdLevelRelationState();
}

class _ThirdLevelRelationState extends State<ThirdLevelRelation> {
  String LevelThree = "firstLevel";
  double _zoomLevel = 0.7;
  bool isLoading = true;
  List<FamilyTreeModel> familyTreeDataList = [];
  List<FamilyTreeModel> user = [];
  List<FamilyTreeModel> fathers = [];
  List<FamilyTreeModel> mothers = [];
  List<FamilyTreeModel> brothers = [];
  List<FamilyTreeModel> sisters = [];
  List<FamilyTreeModel> sons = [];
  List<FamilyTreeModel> daughters = [];
  List<FamilyTreeModel> wife = [];

  @override
  void initState() {
    super.initState();
    fetchFamilyTreeData();
  }

  Future<void> fetchFamilyTreeData() async {
    setState(() {
      isLoading = true;
    });
    FamilyTreeServices familyTreeServices = FamilyTreeServices();
    try {
      var newDataList = await familyTreeServices.getAllFamilyTree(LevelThree);
      user =
          newDataList.where((member) => member.relationShip == "user").toList();
      fathers = newDataList
          .where((member) => member.relationShip == "father")
          .toList();
      mothers = newDataList
          .where((member) => member.relationShip == "mother")
          .toList();
      brothers = newDataList
          .where((member) => member.relationShip == "brother")
          .toList();
      sisters = newDataList
          .where((member) => member.relationShip == "sister")
          .toList();
      brothers = newDataList
          .where((member) => member.relationShip == "brother")
          .toList();
      wife =
          newDataList.where((member) => member.relationShip == "wife").toList();
      sons =
          newDataList.where((member) => member.relationShip == "son").toList();
      daughters = newDataList
          .where((member) => member.relationShip == "daughter")
          .toList();

      setState(() {
        familyTreeDataList = newDataList;
        isLoading = false;
        print('Data loaded successfully: ${familyTreeDataList.length} items');
      });
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Transform.scale(
              scale: _zoomLevel,
              child: Container(
                child: Text("data"),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              setState(() {
                _zoomLevel += 0.1;
              });
            },
            child: Icon(Icons.zoom_in),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                _zoomLevel -= 0.1;
              });
            },
            child: Icon(Icons.zoom_out),
          ),
        ],
      ),
    );
  }
}
