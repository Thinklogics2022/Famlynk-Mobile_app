import 'package:famlynk_version1/mvc/model/familyTree_model/familyTree_model.dart';
import 'package:famlynk_version1/services/familyTreeService/familyTree_service.dart';
import 'package:flutter/material.dart';

class ThirdLevelRelation extends StatefulWidget {
  const ThirdLevelRelation({super.key});

  @override
  State<ThirdLevelRelation> createState() => _ThirdLevelRelationState();
}

class _ThirdLevelRelationState extends State<ThirdLevelRelation> {
  String LevelThree = "thirdLevel";
  List<FamilyTreeModel> familyTreeDataList = [];

  @override
  void initState() {
    super.initState();
    fetchFamilyTreeData();
  }

  Future<void> fetchFamilyTreeData() async {
    FamilyTreeServices familyTreeServices = FamilyTreeServices();
    try {
      var newDataList = await familyTreeServices.getAllFamilyTree(LevelThree);
      setState(() {
        familyTreeDataList = newDataList;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
