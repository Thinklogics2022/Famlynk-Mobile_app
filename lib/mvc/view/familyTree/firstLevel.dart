import 'dart:async';

import 'package:famlynk_version1/mvc/model/familyTree_model/familyTree_model.dart';
import 'package:famlynk_version1/services/familyTreeService/familyTree_service.dart';
import 'package:flutter/material.dart';

class FirstLevelRelation extends StatefulWidget {
  const FirstLevelRelation({super.key});

  @override
  State<FirstLevelRelation> createState() => _FirstLevelRelationState();
}

class _FirstLevelRelationState extends State<FirstLevelRelation> {
  String LevelOne = "firstLevel";
  List<FamilyTreeModel> familyTreeDataList = [];
  int selectedUserIndex = 0;
  List<FamilyTreeModel> userData = [];
  List<FamilyTreeModel> personData = [];
  List<FamilyTreeModel>? grandfatherData = [];
  List<FamilyTreeModel>? grandmotherData = [];
  List<FamilyTreeModel> fatherData = [];
  List<FamilyTreeModel> motherData = [];
  List<FamilyTreeModel> brotherData = [];
  List<FamilyTreeModel> sisterData = [];
  bool Husband = false;
  bool wife = false;
  List<FamilyTreeModel> sonData = [];
  List<FamilyTreeModel> daughterData = [];
  List<FamilyTreeModel> SonDaughterData = [];
  List<FamilyTreeModel> husbandORWifeData = [];
  List<FamilyTreeModel> sonWifeData = [];
  bool withoutWife = false;
  bool wife1Wife2 = false;
  bool wife1 = true;
  bool wife2 = true;
  bool treeLoader = true;
  late Timer _timer;
  final int refreshInterval = 300;

  @override
  void initState() {
    super.initState();
    fetchFamilyTreeData();
    LinePainter(
      hasFatherData: fatherData,
      hasMotherData: motherData,
      hasBrotherData: brotherData,
      hasSisterData: sisterData,
    );

    // Timer.periodic(Duration(milliseconds: refreshInterval), (Timer timer) {
    //   LinePainter(
    //     hasFatherData: fatherData,
    //     hasBrotherData: brotherData,
    //     hasSisterData: sisterData,
    //   );
    // });
  }

  Future<void> fetchFamilyTreeData() async {
    FamilyTreeServices familyTreeServices = FamilyTreeServices();

    try {
      final doc = await familyTreeServices.getAllFamilyTree(LevelOne);

      if (!mounted) {
        return; // Return if the widget is no longer in the tree
      }

      setState(() {
        familyTreeDataList = doc;
        print('${familyTreeDataList} all data');
        userData = familyTreeDataList
            .where((relation) => relation.uId != null)
            .toList();
        grandfatherData = familyTreeDataList
            .where((relation) => relation.gFId != null)
            .toList();
        grandmotherData = familyTreeDataList
            .where((relation) => relation.gMId != null)
            .toList();
        brotherData = familyTreeDataList
            .where((relation) => relation.bId != null)
            .toList();
        sisterData = familyTreeDataList
            .where((relation) => relation.sId != null)
            .toList();
        sonData = familyTreeDataList
            .where((relation) => relation.sonId != null)
            .toList();
        daughterData = familyTreeDataList
            .where((relation) => relation.dId != null)
            .toList();
        fatherData = familyTreeDataList
            .where((relation) => relation.fId != null)
            .toList();
        motherData = familyTreeDataList
            .where((relation) => relation.mId != null)
            .toList();
        SonDaughterData = [...daughterData, ...sonData];

        if (brotherData.isEmpty && sisterData.isEmpty) {
          brotherData = familyTreeDataList
              .where((relation) => relation.fId != null)
              .toList();
          sisterData = familyTreeDataList
              .where((relation) => relation.mId != null)
              .toList();
          fatherData = grandfatherData!;
          motherData = grandmotherData!;
          grandmotherData = null;
          grandfatherData = null;
          print('if');
        } else {
          fatherData = familyTreeDataList
              .where((relation) => relation.fId != null)
              .toList();
          motherData = familyTreeDataList
              .where((relation) => relation.mId != null)
              .toList();
          if (fatherData.isEmpty) {
            fatherData = grandfatherData!;
            motherData = grandmotherData!;
            grandmotherData = null;
            grandfatherData = null;
          }
        }

        if (userData[0].gender == 'female') {
          husbandORWifeData = familyTreeDataList
              .where((relation) => relation.hId != null)
              .toList();
        } else {
          husbandORWifeData = familyTreeDataList
              .where((relation) => relation.wId != null)
              .toList();
        }

        if (husbandORWifeData.length >= 2) {
          wife1Wife2 = !wife1Wife2;
        } else {
          withoutWife = !withoutWife;
        }

        treeLoader = false;

        LinePainter(
          hasFatherData: fatherData,
          hasMotherData: motherData,
          hasBrotherData: brotherData,
          hasSisterData: sisterData,
        );
      });
    } catch (e) {
      print('Error fetching family tree data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomPaint(
          size: Size(800, 600),
          painter: LinePainter(
            hasFatherData: fatherData,
            hasMotherData: motherData,
            hasBrotherData: brotherData,
            hasSisterData: sisterData,
          ),
        ),
      ),
    );
  }
}

class Line extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.5;
    canvas.drawLine(
      Offset(size.width * 1, size.height * -0.05),
      Offset(size.width * 0.456, size.height * -0.05),
      paint,
    );
  }

  @override
  bool shouldRepaint(Line oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(Line oldDelegate) => false;
}

class LinePainter extends CustomPainter {
  List<FamilyTreeModel> hasFatherData;
  List<FamilyTreeModel> hasBrotherData;
  List<FamilyTreeModel> hasMotherData;
  List<FamilyTreeModel> hasSisterData;
  LinePainter(
      {required this.hasFatherData,
      required this.hasMotherData,
      required this.hasBrotherData,
      required this.hasSisterData});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..strokeWidth = 2.5;

    // Main vertical line
    canvas.drawLine(
      Offset(size.width * 0.5, size.height * 0.199),
      Offset(size.width * 0.5, size.height * 0.42),
      paint,
    );

    // Father line
    // Active condition
    if (hasFatherData.isNotEmpty) {
      canvas.drawLine(
        Offset(size.width * 0.445, size.height * 0.155),
        Offset(size.width * 0.5, size.height * 0.205),
        paint,
      );

      // paint
      //   ..color = Color.fromRGBO(248, 172, 145, 1)
      //   ..style = PaintingStyle.fill;

      // canvas.drawCircle(
      //   Offset(size.width * 0.412, size.height * 0.11),
      //   30,
      //   paint,
      // );
      paint
        ..color = Colors.red
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1;

      canvas.drawCircle(
        Offset(size.width * 0.412, size.height * 0.11),
        30,
        paint,
      );
      // Small circle
      // paint
      //   ..color = Colors.black
      //   ..style = PaintingStyle.fill;

      // canvas.drawCircle(
      //   Offset(size.width * 0.5, size.height * 0.2),
      //   6,
      //   paint,
      // );

      // paint
      //   ..color = Colors.red
      //   ..style = PaintingStyle.stroke
      //   ..strokeWidth = 0.2;

      // canvas.drawCircle(
      //   Offset(size.width * 0.5, size.height * 0.2),
      //   6,
      //   paint,
      // );
    }

    if (hasMotherData.isNotEmpty) {
        final paint = Paint()..strokeWidth = 2.5;

      canvas.drawLine(
        Offset(size.width * 0.556, size.height * 0.15),
        Offset(size.width * 0.5, size.height * 0.205),
        paint,
      );

      paint
        ..color = const Color.fromARGB(255, 88, 5, 33)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1;

      canvas.drawCircle(
        Offset(size.width * 0.611, size.height * 0.11),
        30,
        paint,
      );
    }

    // if (hasBrotherData.isNotEmpty) {
    //   final numBrotherLines = hasBrotherData.length;
    //   for (int i = 0; i < numBrotherLines; i++) {
    //     var dx = size.width * 0.5 - (i - (numBrotherLines - 1) / 2) * 100;
    //     var dy = size.height * 0.25 + i * 120;

    //     // Draw the line connecting brother and main line
    //     canvas.drawLine(
    //       Offset(size.width * 0.5, size.height * 0.2),
    //       Offset(dx, dy),
    //       paint,
    //     );

    //     // Draw a vertical line to the left starting from the small circle
    //     canvas.drawLine(
    //       Offset(dx, dy - 15),
    //       Offset(dx, dy + 45), // Adjust these values as needed
    //       paint,
    //     );

    //     // Draw the brother circle
    //     paint
    //       ..color = Colors.red
    //       ..style = PaintingStyle.stroke;
    //     canvas.drawCircle(
    //       Offset(dx, dy),
    //       50,
    //       paint,
    //     );
    //   }
    // }

    // // Sister circles
    // if (hasSisterData.isNotEmpty) {
    //   final numSisterLines = hasSisterData.length;
    //   for (int i = 0; i < numSisterLines; i++) {
    //     var dx = size.width * 0.5 + (i - (numSisterLines - 1) / 2) * 100;
    //     var dy = size.height * 0.25 + i * 120;

    //     // Draw the line connecting sister and main line
    //     canvas.drawLine(
    //       Offset(size.width * 0.5, size.height * 0.2),
    //       Offset(dx, dy),
    //       paint,
    //     );

    //     // Draw a vertical line to the right starting from the small circle
    //     canvas.drawLine(
    //       Offset(dx, dy - 15),
    //       Offset(dx, dy + 45), // Adjust these values as needed
    //       paint,
    //     );

    //     // Draw the sister circle
    //     paint
    //       ..color = Color.fromRGBO(0, 191, 255, 1)
    //       ..style = PaintingStyle.stroke
    //       ..strokeWidth = 1;

    //     canvas.drawCircle(
    //       Offset(dx, dy),
    //       50,
    //       paint,
    //     );
    //   }
    // }

    // brother
    // Active condition for brother circle
    if (hasBrotherData.isNotEmpty) {
      final numBrotherLines = hasBrotherData.length;
      for (int i = 0; i < numBrotherLines; i++) {
        final paint = Paint()..strokeWidth = 2.5;
        var dx = size.width * 0.5 - (i - (numBrotherLines - 1) / 2) * 100;
        var dy = size.height * 0.25 + i * 120;

        // Draw the line connecting brother and main line
        canvas.drawLine(
          Offset(size.width * 0.5, size.height * 0.2),
          Offset(dx, dy),
          paint,
        );

        // Draw a vertical line to the left starting from the small circle
        canvas.drawLine(
          Offset(size.width * 0.5, size.height * 0.31),
          Offset(size.width * 0.35, size.height * 0.31),
          paint,
        );

        // Draw a horizontal line connecting the two vertical lines to the left
        canvas.drawLine(
          Offset(size.width * 0.35, size.height * 0.31),
          Offset(size.width * 0.35, size.height * 0.36),
          paint,
        );

        // Draw the brother circle
        paint
          ..color = Colors.red
          ..style = PaintingStyle.fill;
        canvas.drawCircle(
          Offset(645 - i * 160, size.height * 0.31),
          50,
          paint,
        );

        // Draw a horizontal line to the left starting from the small circle
        canvas.drawLine(
          Offset(645 - i * 160 - 50, size.height * 0.31),
          Offset(645 - i * 160 - 100, size.height * 0.31),
          paint,
        );

        // Small circle
        // paint
        //   ..color = Colors.black
        //   ..style = PaintingStyle.fill;
        // canvas.drawCircle(
        //   Offset(645 - i * 160, size.height * 0.31),
        //   6,
        //   paint,
        // );

        // paint
        //   ..color = Color(0xFF00BFFF)
        //   ..style = PaintingStyle.stroke
        //   ..strokeWidth = 0.2;
        // canvas.drawCircle(
        //   Offset(645 - i * 160, size.height * 0.31),
        //   6,
        //   paint,
        // );
      }
    }

    // Active condition for sister circle
    // Inside the paint method, after drawing the sister's circle and line
    if (hasSisterData.isNotEmpty) {
      final numSisterLines = hasSisterData.length;
      final paint = Paint()..strokeWidth = 2.5;
      for (int i = 0; i < numSisterLines; i++) {
        final dx = size.width * 0.5 + (i - (numSisterLines - 1) / 2) * 100;
        final dy = size.height * 0.31;
        canvas.drawLine(
          Offset(dx, dy),
          Offset(size.width * 0.66, dy),
          paint,
        );

        // Draw the vertical segment of the L-shaped line
        canvas.drawLine(
          Offset(size.width * 0.66, size.height * 0.36),
          Offset(size.width * 0.66, dy),
          paint,
        );

        // Draw the circle for sister
        paint
          ..color = Color.fromRGBO(0, 191, 255, 1)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1;

        canvas.drawCircle(
          Offset(860 + i * 160, size.height * 0.31),
          50,
          paint,
        );

        // Small circle
        // paint
        //   ..color = Colors.black
        //   ..style = PaintingStyle.fill;

        // canvas.drawCircle(
        //   Offset(size.width * 0.5, size.height * 0.31),
        //   6,
        //   paint,
        // );

        // paint
        //   ..color = Color.fromRGBO(0, 191, 255, 1)
        //   ..style = PaintingStyle.stroke
        //   ..strokeWidth = 0.2;

        // canvas.drawCircle(
        //   Offset(size.width * 0.5, size.height * 0.31),
        //   6,
        //   paint,
        // );
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
