import 'dart:async';
import 'dart:typed_data';
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
  double _zoomLevel = 0.7;
  String LevelTwo = "firstLevel";
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
      var newDataList = await familyTreeServices.getAllFamilyTree(LevelTwo);
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Text(
                    //   'Zoom: ${(_zoomLevel * 100).toStringAsFixed(0)}%',
                    //   style: TextStyle(fontSize: 18),
                    // ),
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
                              fathers,
                              mothers,
                              brothers,
                              sisters,
                              wife,
                              sons,
                              daughters,
                            ),
                          ),
                    // Other content here
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
  List<FamilyTreeModel> fathers;
  List<FamilyTreeModel> user;
  List<FamilyTreeModel> mothers;
  List<FamilyTreeModel> brothers;
  List<FamilyTreeModel> sisters;
  List<FamilyTreeModel> wife;
  List<FamilyTreeModel> sons;
  List<FamilyTreeModel> daughters;
  final Map<String, ui.Image> imageCache = {};

  FamilyTreePainter(
      this.familyTreeDataList,
      this.user,
      this.fathers,
      this.mothers,
      this.brothers,
      this.sisters,
      this.wife,
      this.sons,
      this.daughters);

  @override
  void paint(Canvas canvas, Size size) async {

    for (int i = 0; i < familyTreeDataList.length; i++) {
      if (user.contains(familyTreeDataList[i])) {
        final paint = Paint()..strokeWidth = 2.5;
        final centerX = size.width * 0.5;
        final centerY = size.height * 0.523;
        paint
          ..color = Colors.blue // Change color as needed
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.6;
        canvas.drawCircle(
          Offset(centerX, centerY),
          30,
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
          text: user[0].name!.length > 5
              ? user[0].name!.substring(0, 5)
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
          Offset(centerX - 20, centerY + 35), // Adjust the position as needed
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
          Offset(centerX - 20, centerY + 46),
        );
      }

      // Draw father's lines
      if (fathers.contains(familyTreeDataList[i])) {
        final paint = Paint()..strokeWidth = 2.5;
        final centerX = size.width * 0.5;
        final centerY = size.height * 0.100 + i * 0.1;
        final fatherIndex = fathers.indexOf(familyTreeDataList[i]);
        final fatherX = centerX - 51 - fatherIndex * 70.0;

        canvas.drawLine(
          Offset(fatherX, centerY),
          Offset(centerX, centerY),
          paint,
        );
        canvas.drawLine(
          Offset(size.width * 0.5, size.height * 0.4),
          Offset(centerX, centerY),
          paint,
        );
        // Draw father's circle
        paint
          ..color = Color.fromARGB(134, 3, 20, 252)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1;
        canvas.drawCircle(
          Offset(fatherX - 30, centerY),
          30,
          paint,
        );
        final Paint glowPaint = Paint()
          ..color = Color.fromARGB(134, 3, 20, 252).withOpacity(0.3)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, 12);

        canvas.drawCircle(
          Offset(fatherX - 30, centerY),
          35,
          glowPaint,
        );
        final image = imageCache[fathers[fatherIndex].image];
        if (image == null) {
          loadImage(fathers[fatherIndex].image.toString()).then((loadedImage) {
            if (loadedImage != null) {
              imageCache[fathers[fatherIndex].image.toString()] = loadedImage;
              _drawImage(canvas, size, loadedImage, i, fatherX - 30, centerY);
            }
          });
        } else {
          _drawImage(canvas, size, image, i, fatherX - 30, centerY);
        }

        // Draw father's name
        TextSpan fatherTextSpan = TextSpan(
          text: fathers[fatherIndex].name,
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
          Offset(fatherX - 49, centerY + 35),
        );
        TextSpan relationTextSpan = TextSpan(
          text: fathers[fatherIndex].relationShip,
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
          Offset(fatherX - 55, centerY + 46),
        );
      }

      //mother
      if (mothers.contains(familyTreeDataList[i])) {
        final centerX = size.width * 0.5;
        final centerY = size.height * 0.10 + i * 0.2;
        final paint = Paint()..strokeWidth = 2.5;
        final motherIndex = mothers.indexOf(familyTreeDataList[i]);
        final motherX = centerX + 60 + motherIndex * 80.0;

        // Draw horizontal line to the right
        canvas.drawLine(
          Offset(centerX, centerY),
          Offset(motherX, centerY),
          paint,
        );
        canvas.drawLine(
          Offset(size.width * 0.5, size.height * 0.48),
          Offset(centerX, centerY),
          paint,
        );

        // Draw mother's circle
        paint
          ..color = Colors.pink
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1;
        canvas.drawCircle(
          Offset(motherX + 30, centerY),
          30,
          paint,
        );
        final Paint glowPaint = Paint()
          ..color = Colors.pink.withOpacity(0.3)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, 12);

        canvas.drawCircle(
          Offset(motherX + 30, centerY),
          35,
          glowPaint,
        );

        // Draw the image inside the circle
        final image = imageCache[mothers[motherIndex].image];
        if (image == null) {
          loadImage(mothers[motherIndex].image.toString()).then((loadedImage) {
            if (loadedImage != null) {
              imageCache[mothers[motherIndex].image.toString()] = loadedImage;
              _drawImage(canvas, size, loadedImage, i, motherX + 30, centerY);
            }
          });
        } else {
          _drawImage(canvas, size, image, i, motherX + 30, centerY);
        }

        TextSpan motherTextSpan = TextSpan(
          text: mothers[motherIndex].name,
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
          Offset(motherX, centerY + 35),
        );
        TextSpan relationTextSpan = TextSpan(
          text: mothers[motherIndex].relationShip,
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
          Offset(motherX, centerY + 46),
        );
      }

      // Brother
      if (brothers.contains(familyTreeDataList[i])) {
        final paint = Paint()
          ..strokeWidth = 2.5
          ..isAntiAlias = true;
        final centerX = size.width * 0.5;
        final centerY = size.height * 0.300 + i * 0.1;
        final brotherIndex = brothers.indexOf(familyTreeDataList[i]);

        // Draw vertical line to left
        canvas.drawLine(
          Offset(centerX, centerY),
          Offset(size.width * 0.358, centerY),
          paint,
        );

        // Draw horizontal line extending to the left
        final horizontalLineX = size.width * 0.36 - brotherIndex * 70.0;

        canvas.drawLine(
          Offset(size.width * 0.6, centerY),
          Offset(horizontalLineX, centerY),
          paint,
        );
        canvas.drawLine(
          Offset(size.width * 0.5, size.height * 0.48),
          Offset(centerX, centerY),
          paint,
        );

        // Draw the brother's circle
        final brotherY = centerY;
        final brotherX = horizontalLineX;

        // Draw the horizontal line of the Γ shape
        canvas.drawLine(
          Offset(brotherX + 50, brotherY),
          Offset(brotherX, brotherY),
          paint,
        );

        // Draw the bottom line of the Γ shape
        canvas.drawLine(
          Offset(brotherX, brotherY),
          Offset(brotherX, brotherY + 30),
          paint,
        );

        paint
          ..color = Colors.green
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1;

        // Draw the circle at the end of the bottom line
        canvas.drawCircle(
          Offset(brotherX, brotherY + 56),
          27,
          paint,
        );
        final Paint glowPaint = Paint()
          ..color = Colors.green.withOpacity(0.3)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, 12);

        canvas.drawCircle(
          Offset(brotherX, brotherY + 50),
          32,
          glowPaint,
        );

        final image = imageCache[brothers[brotherIndex].image];
        if (image == null) {
          loadImage(brothers[brotherIndex].image.toString())
              .then((loadedImage) {
            if (loadedImage != null) {
              imageCache[brothers[brotherIndex].image.toString()] = loadedImage;
              _drawImage(canvas, size, loadedImage, i, brotherX, brotherY + 56);
            }
          });
        } else {
          _drawImage(canvas, size, image, i, brotherX, brotherY + 56);
        }
        TextSpan brotherTextSpan = TextSpan(
          text: brothers[brotherIndex].name!.length > 5
              ? brothers[brotherIndex].name!.substring(0, 5)
              : brothers[brotherIndex].name,
          style: TextStyle(
              fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black),
        );
        TextPainter brotherTextPainter = TextPainter(
          text: brotherTextSpan,
          textDirection: TextDirection.ltr,
        );
        brotherTextPainter.layout();
        brotherTextPainter.paint(
          canvas,
          Offset(brotherX - 14, centerY + 88),
        );

        TextSpan relationTextSpan = TextSpan(
          text: brothers[brotherIndex].relationShip,
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
          Offset(brotherX - 14, centerY + 99),
        );
      }

      // Sister
      if (sisters.contains(familyTreeDataList[i])) {
        final paint = Paint()..strokeWidth = 2.5;
        final centerX = size.width * 0.5;
        final centerY = size.height * 0.300 + i * 0.07;
        final sisterIndex = sisters.indexOf(familyTreeDataList[i]);

        // Draw vertical line to right
        canvas.drawLine(
          Offset(centerX, centerY),
          Offset(size.width * 0.65, centerY),
          paint,
        );

        // Draw horizontal line extending to the right
        final horizontalLineX = size.width * 0.65 + sisterIndex * 70.0;
        canvas.drawLine(
          Offset(size.width * 0.6, centerY),
          Offset(horizontalLineX, centerY),
          paint,
        );
        canvas.drawLine(
          Offset(size.width * 0.5, size.height * 0.48),
          Offset(centerX, centerY),
          paint,
        );

        // Draw the sister's circle
        final sisterY = centerY;
        final sisterX = horizontalLineX;

        // Draw the horizontal line of the Γ shape
        canvas.drawLine(
          Offset(sisterX, sisterY),
          Offset(sisterX, sisterY),
          paint,
        );

        // Draw the bottom line of the Γ shape
        canvas.drawLine(
          Offset(sisterX, sisterY),
          Offset(sisterX, sisterY + 30),
          paint,
        );

        paint
          ..color = Colors.red
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1;

        // Draw the circle at the end of the bottom line
        canvas.drawCircle(
          Offset(sisterX, sisterY + 56),
          27,
          paint,
        );
        final Paint glowPaint = Paint()
          ..color = Colors.red.withOpacity(0.3)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, 12);

        canvas.drawCircle(
          Offset(sisterX, sisterY + 50),
          32,
          glowPaint,
        );
        // Draw sister's image inside the circle
        final image = imageCache[sisters[sisterIndex].image];
        if (image == null) {
          loadImage(sisters[sisterIndex].image.toString()).then((loadedImage) {
            if (loadedImage != null) {
              imageCache[sisters[sisterIndex].image.toString()] = loadedImage;
              _drawImage(canvas, size, loadedImage, i, sisterX, sisterY + 56);
            }
          });
        } else {
          _drawImage(canvas, size, image, i, sisterX, sisterY + 56);
        }

        TextSpan sisterTextSpan = TextSpan(
          text: sisters[sisterIndex].name!.length > 5
              ? sisters[sisterIndex].name!.substring(0, 5)
              : sisters[sisterIndex].name,
          style: TextStyle(
              fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black),
        );
        TextPainter sisterTextPainter = TextPainter(
          text: sisterTextSpan,
          textDirection: TextDirection.ltr,
        );
        sisterTextPainter.layout();
        sisterTextPainter.paint(
          canvas,
          Offset(sisterX - 14, centerY + 88),
        );
        TextSpan relationTextSpan = TextSpan(
          text: sisters[sisterIndex].relationShip,
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
          Offset(sisterX - 14, centerY + 99),
        );
      }

      //wife
      if (wife.contains(familyTreeDataList[i])) {
        final paint = Paint()..strokeWidth = 2.5;
        final centerX = size.width * 0.56;
        final centerY = size.height * 0.525;
        final wifeIndex = wife.indexOf(familyTreeDataList[i]);

        final wifeX = centerX + 60;
        final wifeY = centerY;

        canvas.drawLine(
          Offset(centerX, centerY),
          Offset(wifeX, centerY),
          paint,
        );

        // Draw wife's circle
        paint
          ..color = Colors.purple // Adjust color as needed
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.6;
        canvas.drawCircle(
          Offset(wifeX + 29, wifeY),
          30,
          paint,
        );
        final Paint glowPaint = Paint()
          ..color = Colors.purple.withOpacity(0.3)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, 12);

        canvas.drawCircle(
          Offset(wifeX + 29, wifeY),
          35,
          glowPaint,
        );
        final image = imageCache[wife[wifeIndex].image];
        if (image == null) {
          loadImage(wife[wifeIndex].image.toString()).then((loadedImage) {
            if (loadedImage != null) {
              imageCache[wife[wifeIndex].image.toString()] = loadedImage;
              _drawImage(canvas, size, loadedImage, i, wifeX + 29, wifeY);
            }
          });
        }else{
           _drawImage(canvas, size, image, i, wifeX + 29, wifeY);
        }

        // Draw wife's name
        TextSpan wifeTextSpan = TextSpan(
          text: wife[wifeIndex].name,
          style: TextStyle(
              fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black),
        );
        TextPainter wifeTextPainter = TextPainter(
          text: wifeTextSpan,
          textDirection: TextDirection.ltr,
        );
        wifeTextPainter.layout();
        wifeTextPainter.paint(
          canvas,
          Offset(wifeX + 15, wifeY + 35), // Adjust position as needed
        );

        // Draw wife's relation
        TextSpan wifeRelationTextSpan = TextSpan(
          text: wife[wifeIndex].relationShip,
          style: TextStyle(
              fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black),
        );
        TextPainter wifeRelationTextPainter = TextPainter(
          text: wifeRelationTextSpan,
          textDirection: TextDirection.ltr,
        );
        wifeRelationTextPainter.layout();
        wifeRelationTextPainter.paint(
          canvas,
          Offset(wifeX + 15, wifeY + 46), // Adjust position as needed
        );

        // You can also draw the wife's image if you have the image data available
        final wifeImage = imageCache[wife[wifeIndex].image];
        if (wifeImage != null) {
          final imageSize = Size(60, 60); // Adjust size as needed
          final wifeImageRect = Rect.fromCenter(
            center: Offset(wifeX, wifeY),
            width: imageSize.width,
            height: imageSize.height,
          );
          canvas.drawImageRect(
            wifeImage,
            Rect.fromLTRB(
                0, 0, wifeImage.width.toDouble(), wifeImage.height.toDouble()),
            wifeImageRect,
            paint,
          );
        }
      }

      //son
      if (sons.contains(familyTreeDataList[i])) {
        final paint = Paint()..strokeWidth = 2.5;
        final centerX = size.width * 0.9;
        final centerY = size.height * 0.5 + i * 18;
        final sonsIndex = sons.indexOf(familyTreeDataList[i]);

        // Draw vertical line to left
        canvas.drawLine(
          Offset(centerX * 0.7, centerY),
          Offset(centerX * 0.7, centerY * 0.8),
          paint,
        );

        // Draw horizontal line extending to the left
        canvas.drawLine(
          Offset(centerX * 0.7, centerY),
          Offset(size.width * 0.5, centerY),
          paint,
        );

        final horizontalLineX = size.width * 0.5 - sonsIndex * 50.0;
        canvas.drawLine(
          Offset(centerX, centerY),
          Offset(centerX, centerY),
          paint,
        );

        final sonY = centerY;
        final sonx = horizontalLineX;

        // Draw the bottom line of the Γ shape
        canvas.drawLine(
          Offset(sonx, sonY),
          Offset(sonx, sonY + 20),
          paint,
        );

        paint
          ..color = Colors.blue // Adjust color as needed
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1;

        // Draw the circle at the end of the bottom line
        canvas.drawCircle(
          Offset(sonx, sonY + 40),
          20,
          paint,
        );
      }
    }
  }

  void _drawImage(Canvas canvas, Size size, ui.Image image, int index,
      double centerX, double centerY) {

    final imageSize = Size(60, 60);
    final imageRect = Rect.fromCenter(
      center: Offset(centerX, centerY),
      width: imageSize.width,
      height: imageSize.height,
    );
    canvas.drawImageRect(
      image,
      Rect.fromLTRB(0, 0, image.width.toDouble(), image.height.toDouble()),
      imageRect,
      Paint(),
    );
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
