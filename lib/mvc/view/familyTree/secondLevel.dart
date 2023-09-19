import 'dart:async';
import 'dart:ui';

import 'package:famlynk_version1/mvc/model/familyTree_model/familyTree_model.dart';
import 'package:famlynk_version1/services/familyTreeService/familyTree_service.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class SecondLevelRelation extends StatefulWidget {
  const SecondLevelRelation({super.key});

  @override
  State<SecondLevelRelation> createState() => _SecondLevelRelationState();
}

class _SecondLevelRelationState extends State<SecondLevelRelation> {
  double _zoomLevel = 0.6;
  String LevelTwo = "secondLevel";
  bool isLoading = true;
  List<FamilyTreeModel> familyTreeDataList = [];
  List<FamilyTreeModel> mothersSide = [];
  List<FamilyTreeModel> fathersSide = [];
  List<FamilyTreeModel> cousinBrother = [];
  List<FamilyTreeModel> cousinSister = [];
  List<FamilyTreeModel> uncleaunt = [];
  List<FamilyTreeModel> father_mother__in_law = [];
  List<FamilyTreeModel> grandsondaughter = [];

  List<FamilyTreeModel> user = [];

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
      var newDataList = await familyTreeServices.getAllFamilyTree(LevelTwo);
      user =
          newDataList.where((member) => member.relationShip == "user").toList();
      fathersSide = newDataList
          .where((member) =>
              member.relationShip == "paternal father" ||
              member.relationShip == "paternal mother")
          .toList();
      mothersSide = newDataList
          .where((member) =>
              member.relationShip == "maternal mother" ||
              member.relationShip == "maternal father")
          .toList();
      cousinBrother = newDataList
          .where((member) =>
              member.relationShip == "cousin" && member.gender == "male")
          .toList();
      cousinSister = newDataList
          .where((member) =>
              member.relationShip == "cousin" && member.gender == "female")
          .toList();
      uncleaunt = newDataList
          .where((member) =>
              member.relationShip == "uncle" || member.relationShip == "aunt")
          .toList();
      grandsondaughter = newDataList
          .where((member) =>
              member.relationShip == "grandson" ||
              member.relationShip == "granddaughter")
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    isLoading
                        ? Container(
                            height: 90,
                            width: 90,
                            child: CircularProgressIndicator(
                              color: Colors.lightBlueAccent,
                            ),
                          )
                        : CustomPaint(
                            size: Size(500, 700),
                            painter: FamilyTreePainter(
                              familyTreeDataList,
                              user,
                              fathersSide,
                              mothersSide,
                              cousinBrother,
                              cousinSister,
                              uncleaunt,
                              grandsondaughter,
                            ),
                          ),
                  ],
                ),
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

class FamilyTreePainter extends CustomPainter {
  List<FamilyTreeModel> familyTreeDataList;
  List<FamilyTreeModel> user;
  List<FamilyTreeModel> fathersSide;
  List<FamilyTreeModel> mothersSide;
  List<FamilyTreeModel> cousinBrother;
  List<FamilyTreeModel> cousinSister;
  List<FamilyTreeModel> uncleaunt;
  List<FamilyTreeModel> grandsondaughter = [];
  final Map<String, ui.Image> imageCache = {};

  FamilyTreePainter(
    this.familyTreeDataList,
    this.user,
    this.fathersSide,
    this.mothersSide,
    this.cousinBrother,
    this.cousinSister,
    this.uncleaunt,
    this.grandsondaughter,
  );

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < familyTreeDataList.length; i++) {
      if (user.contains(familyTreeDataList[i])) {
        final paint = Paint()..strokeWidth = 2.5;
        final centerX = size.width * 0.5;
        final centerY = size.height * 0.623;
        paint
          ..color = Colors.blue // Change color as needed
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.6;
        canvas.drawCircle(
          Offset(centerX, centerY),
          30,
          paint,
        );
        canvas.drawCircle(
          Offset(centerX, centerY),
          33,
          paint,
        );
        final Paint glowPaint = Paint()
          ..color = Colors.blue.withOpacity(0.3)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, 12);

        canvas.drawCircle(
          Offset(centerX, centerY),
          35,
          glowPaint,
        );
        final image = imageCache[user[0].image];
        if (image == null) {
          loadImage(user[0].image.toString()).then((loadedImage) {
            if (loadedImage != null) {
              imageCache[user[0].image.toString()] = loadedImage;
              _drawImage(canvas, size, loadedImage, i, centerX, centerY);
            }
          });
        } else {
          _drawImage(canvas, size, image, i, centerX, centerY);
        }

        // Draw the user's name
        TextSpan userTextSpan = TextSpan(
          text: user[0].name!.length > 6
              ? user[0].name!.substring(0, 6)
              : user[0].name,
          style: TextStyle(
              fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black),
        );
        TextPainter userTextPainter = TextPainter(
          text: userTextSpan,
          textDirection: TextDirection.ltr,
        );
        userTextPainter.layout();
        userTextPainter.paint(
          canvas,
          Offset(centerX - 40, centerY + 35), // Adjust the position as needed
        );
        TextSpan relationTextSpan = TextSpan(
          text: user[0].relationShip,
          style: TextStyle(
              fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black),
        );
        TextPainter relationTextPainter = TextPainter(
          text: relationTextSpan,
          textDirection: TextDirection.ltr,
        );
        relationTextPainter.layout();
        relationTextPainter.paint(
          canvas,
          Offset(centerX - 30, centerY + 46),
        );
      }
      // Draw father's lines
      if (fathersSide.contains(familyTreeDataList[i])) {
        final paint = Paint()..strokeWidth = 2.5;
        final centerX = size.width * 0.5;
        final centerY = size.height * 0.100;
        final fatherIndex = fathersSide.indexOf(familyTreeDataList[i]);
        final fatherX = centerX - 60 - fatherIndex * 80.0;

        canvas.drawLine(
          Offset(fatherX, centerY),
          Offset(centerX, centerY),
          paint,
        );
        canvas.drawLine(
          Offset(fatherX, centerY),
          Offset(fatherX, size.height * 0.14),
          paint,
        );
        canvas.drawLine(
          Offset(size.width * 0.5, size.height * 0.58),
          Offset(centerX, centerY),
          paint,
        );
        // Draw father's circle
        paint
          ..color = Color.fromARGB(134, 3, 20, 252)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1;
        canvas.drawCircle(
          Offset(fatherX, size.height * 0.182),
          30,
          paint,
        );
        final Paint glowPaint = Paint()
          ..color = Color.fromARGB(134, 3, 20, 252).withOpacity(0.3)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, 12);

        canvas.drawCircle(
          Offset(fatherX, size.height * 0.182),
          35,
          glowPaint,
        );
        final image = imageCache[fathersSide[fatherIndex].image];
        if (image == null) {
          loadImage(fathersSide[fatherIndex].image.toString())
              .then((loadedImage) {
            if (loadedImage != null) {
              imageCache[fathersSide[fatherIndex].image.toString()] =
                  loadedImage;
              _drawImage(
                  canvas, size, loadedImage, i, fatherX, size.height * 0.182);
            }
          });
        } else {
          _drawImage(canvas, size, image, i, fatherX, size.height * 0.182);
        }

        // Draw father's name
        TextSpan fatherTextSpan = TextSpan(
          text: fathersSide[fatherIndex].name,
          style: TextStyle(
              fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black),
        );
        TextPainter fatherTextPainter = TextPainter(
          text: fatherTextSpan,
          textDirection: TextDirection.ltr,
        );
        fatherTextPainter.layout();
        fatherTextPainter.paint(
          canvas,
          Offset(fatherX - 19, size.height * 0.237),
        );
        TextSpan relationTextSpan = TextSpan(
          text: fathersSide[fatherIndex].relationShip!.length > 13
              ? fathersSide[fatherIndex].relationShip!.substring(0, 13)
              : fathersSide[fatherIndex].relationShip,
          style: TextStyle(
              fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black),
        );
        TextPainter relationTextPainter = TextPainter(
          text: relationTextSpan,
          textDirection: TextDirection.ltr,
        );
        relationTextPainter.layout();
        relationTextPainter.paint(
          canvas,
          Offset(fatherX - 29, size.height * 0.257),
        );
      }
      // mother
      if (mothersSide.contains(familyTreeDataList[i])) {
        final centerX = size.width * 0.5;
        final centerY = size.height * 0.100;
        final paint = Paint()..strokeWidth = 2.5;
        final motherIndex = mothersSide.indexOf(familyTreeDataList[i]);
        final motherX = centerX + 60 + motherIndex * 80.0;

        // Draw horizontal line to the right
        canvas.drawLine(
          Offset(centerX, centerY),
          Offset(motherX, centerY),
          paint,
        );
        canvas.drawLine(
          Offset(motherX, centerY),
          Offset(motherX, size.height * 0.14),
          paint,
        );
        //vertical line
        canvas.drawLine(
          Offset(size.width * 0.5, size.height * 0.58),
          Offset(centerX, centerY),
          paint,
        );

        // Draw mother's circle
        paint
          ..color = Colors.pink
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1;
        canvas.drawCircle(
          Offset(motherX, size.height * 0.182),
          30,
          paint,
        );
        final Paint glowPaint = Paint()
          ..color = Colors.pink.withOpacity(0.3)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, 12);

        canvas.drawCircle(
          Offset(motherX, size.height * 0.182),
          35,
          glowPaint,
        );

        // Draw the image inside the circle
        final image = imageCache[mothersSide[motherIndex].image];
        if (image == null) {
          loadImage(mothersSide[motherIndex].image.toString())
              .then((loadedImage) {
            if (loadedImage != null) {
              imageCache[mothersSide[motherIndex].image.toString()] =
                  loadedImage;
              _drawImage(
                  canvas, size, loadedImage, i, motherX, size.height * 0.182);
            }
          });
        } else {
          _drawImage(canvas, size, image, i, motherX, size.height * 0.182);
        }

        TextSpan motherTextSpan = TextSpan(
          text: mothersSide[motherIndex].name,
          style: TextStyle(
              fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black),
        );
        TextPainter motherTextPainter = TextPainter(
          text: motherTextSpan,
          textDirection: TextDirection.ltr,
        );
        motherTextPainter.layout();
        motherTextPainter.paint(
          canvas,
          Offset(motherX - 19, size.height * 0.237),
        );
        TextSpan relationTextSpan = TextSpan(
          text: mothersSide[motherIndex].relationShip!.length > 13
              ? mothersSide[motherIndex].relationShip!.substring(0, 13)
              : mothersSide[motherIndex].relationShip,
          style: TextStyle(
              fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black),
        );
        TextPainter relationTextPainter = TextPainter(
          text: relationTextSpan,
          textDirection: TextDirection.ltr,
        );
        relationTextPainter.layout();
        relationTextPainter.paint(
          canvas,
          Offset(motherX - 20, size.height * 0.254),
        );
      }

      //cousinBrother
      if (cousinBrother.contains(familyTreeDataList[i])) {
        final paint = Paint()
          ..strokeWidth = 2.5
          ..isAntiAlias = true;
        final centerX = size.width * 0.5;
        final centerY = size.height * 0.380;
        final cousinBrotherIndex = cousinBrother.indexOf(familyTreeDataList[i]);
        final horizontalLineX = size.width * 0.36 - cousinBrotherIndex * 70.0;

        canvas.drawLine(
          Offset(size.width * 0.5, centerY),
          Offset(horizontalLineX, centerY),
          paint,
        );
        canvas.drawLine(
          Offset(size.width * 0.5, size.height * 0.58),
          Offset(centerX, centerY),
          paint,
        );
        canvas.drawLine(
          Offset(horizontalLineX, centerY),
          Offset(horizontalLineX, centerY + 30),
          paint,
        );
        paint
          ..color = Colors.green
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1;

        // Draw the circle at the end of the bottom line
        canvas.drawCircle(
          Offset(horizontalLineX, centerY + 59),
          29,
          paint,
        );
        final Paint glowPaint = Paint()
          ..color = Colors.green.withOpacity(0.3)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, 12);

        canvas.drawCircle(
          Offset(horizontalLineX, centerY + 59),
          32,
          glowPaint,
        );
        final image = imageCache[cousinBrother[cousinBrotherIndex].image];
        if (image == null) {
          loadImage(cousinBrother[cousinBrotherIndex].image.toString())
              .then((loadedImage) {
            if (loadedImage != null) {
              imageCache[cousinBrother[cousinBrotherIndex].image.toString()] =
                  loadedImage;
              _drawImage(
                  canvas, size, loadedImage, i, horizontalLineX, centerY + 59);
            }
          });
        } else {
          _drawImage(canvas, size, image, i, horizontalLineX, centerY + 59);
        }
        TextSpan cousinBrotherTextSpan = TextSpan(
          text: cousinBrother[cousinBrotherIndex].name!.length > 6
              ? cousinBrother[cousinBrotherIndex].name!.substring(0, 6)
              : cousinBrother[cousinBrotherIndex].name,
          style: TextStyle(
              fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black),
        );
        TextPainter cousinBrotherTextPainter = TextPainter(
          text: cousinBrotherTextSpan,
          textDirection: TextDirection.ltr,
        );
        cousinBrotherTextPainter.layout();
        cousinBrotherTextPainter.paint(
          canvas,
          Offset(horizontalLineX - 14, centerY + 95),
        );

        TextSpan relationTextSpan = TextSpan(
          text: cousinBrother[cousinBrotherIndex].relationShip,
          style: TextStyle(
              fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black),
        );
        TextPainter relationTextPainter = TextPainter(
          text: relationTextSpan,
          textDirection: TextDirection.ltr,
        );
        relationTextPainter.layout();
        relationTextPainter.paint(
          canvas,
          Offset(horizontalLineX - 14, centerY + 105),
        );
      }
      if (cousinSister.contains(familyTreeDataList[i])) {
        final paint = Paint()..strokeWidth = 2.5;
        final centerX = size.width * 0.5;
        final centerY = size.height * 0.380;
        final cousinSisterIndex = cousinSister.indexOf(familyTreeDataList[i]);
        // Draw horizontal line extending to the right
        final horizontalLineX = size.width * 0.65 + cousinSisterIndex * 70.0;

        // Draw vertical line to right
        canvas.drawLine(
          Offset(centerX, centerY),
          Offset(size.width * 0.65, centerY),
          paint,
        );
        canvas.drawLine(
          Offset(size.width * 0.6, centerY),
          Offset(horizontalLineX, centerY),
          paint,
        );
        //Draw vertical line to connect the user circle
        canvas.drawLine(
          Offset(size.width * 0.5, size.height * 0.58),
          Offset(centerX, centerY),
          paint,
        );

        canvas.drawLine(
          Offset(horizontalLineX, centerY),
          Offset(horizontalLineX, centerY + 30),
          paint,
        );

        paint
          ..color = Colors.red
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1;

        // Draw the circle at the end of the bottom line
        canvas.drawCircle(
          Offset(horizontalLineX, centerY + 59),
          29,
          paint,
        );
        final Paint glowPaint = Paint()
          ..color = Colors.red.withOpacity(0.3)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, 12);

        canvas.drawCircle(
          Offset(horizontalLineX, centerY + 59),
          32,
          glowPaint,
        );

        final image = imageCache[cousinSister[cousinSisterIndex].image];
        if (image == null) {
          loadImage(cousinSister[cousinSisterIndex].image.toString())
              .then((loadedImage) {
            if (loadedImage != null) {
              imageCache[cousinSister[cousinSisterIndex].image.toString()] =
                  loadedImage;
              _drawImage(
                  canvas, size, loadedImage, i, horizontalLineX, centerY + 59);
            }
          });
        } else {
          _drawImage(canvas, size, image, i, horizontalLineX, centerY + 59);
        }

        TextSpan cousinSisterTextSpan = TextSpan(
          text: cousinSister[cousinSisterIndex].name!.length > 6
              ? cousinSister[cousinSisterIndex].name!.substring(0, 6)
              : cousinSister[cousinSisterIndex].name,
          style: TextStyle(
              fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black),
        );
        TextPainter cousinSisterTextPainter = TextPainter(
          text: cousinSisterTextSpan,
          textDirection: TextDirection.ltr,
        );
        cousinSisterTextPainter.layout();
        cousinSisterTextPainter.paint(
          canvas,
          Offset(horizontalLineX - 14, centerY + 95),
        );
        TextSpan relationTextSpan = TextSpan(
          text: cousinSister[cousinSisterIndex].relationShip,
          style: TextStyle(
              fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black),
        );
        TextPainter relationTextPainter = TextPainter(
          text: relationTextSpan,
          textDirection: TextDirection.ltr,
        );
        relationTextPainter.layout();
        relationTextPainter.paint(
          canvas,
          Offset(horizontalLineX - 14, centerY + 105),
        );
      }

      // uncleaunt
      if (uncleaunt.contains(familyTreeDataList[i])) {
        final centerX = size.width * 0.5;
        final centerY = size.height * 0.665;
        final paint = Paint()
          ..strokeWidth = 2.5
          ..isAntiAlias = true;
        final uncleauntIndex = uncleaunt.indexOf(familyTreeDataList[i]);
        final uncleauntY = centerY + 80;

        canvas.drawLine(
          Offset(centerX, centerY),
          Offset(centerX, uncleauntY),
          paint,
        );
        // Draw horizontal line to the left
        final horizontalLineLength = size.width * 0.36 - uncleauntIndex * 70;
        canvas.drawLine(
          Offset(centerX, uncleauntY),
          Offset(horizontalLineLength, uncleauntY),
          paint,
        );
        // Draw vertical line at the end of the horizontal line
        final verticalLineHeight = 30;
        canvas.drawLine(
          Offset(horizontalLineLength, uncleauntY),
          Offset(horizontalLineLength, uncleauntY + verticalLineHeight),
          paint,
        );

        paint
          ..color = const Color.fromARGB(255, 90, 139, 180)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1;

        canvas.drawCircle(
          Offset(horizontalLineLength, uncleauntY + verticalLineHeight + 29),
          29,
          paint,
        );
        final Paint glowPaint = Paint()
          ..color = const Color.fromARGB(255, 90, 139, 180).withOpacity(0.3)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, 12);

        canvas.drawCircle(
          Offset(horizontalLineLength, uncleauntY + verticalLineHeight + 29),
          32,
          glowPaint,
        );

        final image = imageCache[uncleaunt[uncleauntIndex].image];
        if (image == null) {
          loadImage(uncleaunt[uncleauntIndex].image.toString())
              .then((loadedImage) {
            if (loadedImage != null) {
              imageCache[uncleaunt[uncleauntIndex].image.toString()] =
                  loadedImage;
              _drawImage(canvas, size, loadedImage, i, horizontalLineLength,
                  uncleauntY + verticalLineHeight + 29);
            }
          });
        } else {
          _drawImage(canvas, size, image, i, horizontalLineLength,
              uncleauntY + verticalLineHeight + 29);
        }

        TextSpan uncleauntTextSpan = TextSpan(
          text: uncleaunt[uncleauntIndex].name!.length > 6
              ? uncleaunt[uncleauntIndex].name!.substring(0, 6)
              : uncleaunt[uncleauntIndex].name,
          style: TextStyle(
              fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black),
        );
        TextPainter uncleauntTextPainter = TextPainter(
          text: uncleauntTextSpan,
          textDirection: TextDirection.ltr,
        );
        uncleauntTextPainter.layout();
        uncleauntTextPainter.paint(
          canvas,
          Offset(
              horizontalLineLength - 20, uncleauntY + verticalLineHeight + 69),
        );

        TextSpan relationTextSpan = TextSpan(
          text: uncleaunt[uncleauntIndex].relationShip,
          style: TextStyle(
              fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black),
        );
        TextPainter relationTextPainter = TextPainter(
          text: relationTextSpan,
          textDirection: TextDirection.ltr,
        );
        relationTextPainter.layout();
        relationTextPainter.paint(
          canvas,
          Offset(
              horizontalLineLength - 20, uncleauntY + verticalLineHeight + 79),
        );
      }

      //grandsondaughter
      if (grandsondaughter.contains(familyTreeDataList[i])) {
        final paint = Paint()..strokeWidth = 2.5;
        final centerX = size.width * 0.5;
        final centerY = size.height * 0.665;
        final grandsondaughterIndex =
            grandsondaughter.indexOf(familyTreeDataList[i]);
        final grandsondaughterY = centerY + 230;

        canvas.drawLine(
          Offset(centerX, centerY),
          Offset(centerX, grandsondaughterY),
          paint,
        );

        // Draw horizontal line to the left
        final horizontalLineLength =
            size.width * 0.36 - grandsondaughterIndex * 70;
        canvas.drawLine(
          Offset(centerX, grandsondaughterY),
          Offset(horizontalLineLength, grandsondaughterY),
          paint,
        );

        canvas.drawLine(
          Offset(horizontalLineLength, grandsondaughterY),
          Offset(horizontalLineLength, grandsondaughterY + 30),
          paint,
        );

        paint
          ..color = Color.fromARGB(255, 4, 102, 69)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1;

        canvas.drawCircle(
          Offset(horizontalLineLength, grandsondaughterY + 59),
          29,
          paint,
        );
        final Paint glowPaint = Paint()
          ..color = Color.fromARGB(255, 6, 117, 86).withOpacity(0.3)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, 12);
        canvas.drawCircle(
          Offset(horizontalLineLength, grandsondaughterY + 59),
          32,
          glowPaint,
        );

        final image = imageCache[grandsondaughter[grandsondaughterIndex].image];
        if (image == null) {
          loadImage(grandsondaughter[grandsondaughterIndex].image.toString())
              .then((loadedImage) {
            if (loadedImage != null) {
              imageCache[grandsondaughter[grandsondaughterIndex]
                  .image
                  .toString()] = loadedImage;
              _drawImage(canvas, size, loadedImage, i, horizontalLineLength,
                  grandsondaughterY + 59);
            }
          });
        } else {
          _drawImage(canvas, size, image, i, horizontalLineLength,
              grandsondaughterY + 59);
        }

        TextSpan grandsondaughterTextSpan = TextSpan(
          text: grandsondaughter[grandsondaughterIndex].name!.length > 6
              ? grandsondaughter[grandsondaughterIndex].name!.substring(0, 6)
              : grandsondaughter[grandsondaughterIndex].name,
          style: TextStyle(
              fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black),
        );
        TextPainter grandsondaughterTextPainter = TextPainter(
          text: grandsondaughterTextSpan,
          textDirection: TextDirection.ltr,
        );
        grandsondaughterTextPainter.layout();
        grandsondaughterTextPainter.paint(
          canvas,
          Offset(horizontalLineLength - 20, grandsondaughterY + 99),
        );

        TextSpan relationTextSpan = TextSpan(
          text:
              grandsondaughter[grandsondaughterIndex].relationShip!.length > 10
                  ? grandsondaughter[grandsondaughterIndex]
                      .relationShip!
                      .substring(0, 10)
                  : grandsondaughter[grandsondaughterIndex].relationShip,
          style: TextStyle(
              fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black),
        );
        TextPainter relationTextPainter = TextPainter(
          text: relationTextSpan,
          textDirection: TextDirection.ltr,
        );
        relationTextPainter.layout();
        relationTextPainter.paint(
          canvas,
          Offset(horizontalLineLength - 20, grandsondaughterY + 109),
        );
      }
    }
  }

  void _drawImage(Canvas canvas, Size size, ui.Image image, int index,
      double centerX, double centerY) {
    final imageSize = Size(55, 55);

    final imageRect = Rect.fromCenter(
      center: Offset(centerX, centerY),
      width: imageSize.width,
      height: imageSize.height,
    );

    // Create a circular clip path
    final clipPath = Path()
      ..addOval(Rect.fromCircle(
          center: imageRect.center, radius: imageSize.width / 2));

    // Clip the canvas before drawing the image
    canvas.save();
    canvas.clipPath(clipPath);

    canvas.drawImageRect(
      image,
      Rect.fromLTRB(0, 0, image.width.toDouble(), image.height.toDouble()),
      imageRect,
      Paint(),
    );

    canvas.restore(); // Restore the canvas to its previous state
  }

  Future<ui.Image?> loadImage(String imageUrl) async {
    final completer = Completer<ui.Image>();

    final image = NetworkImage(imageUrl);
    final stream = image.resolve(ImageConfiguration.empty);
    stream.addListener(ImageStreamListener((info, _) {
      completer.complete(info.image);
    }));

    return completer.future;
  }

  @override
  bool shouldRepaint(FamilyTreePainter oldDelegate) => false;
}
