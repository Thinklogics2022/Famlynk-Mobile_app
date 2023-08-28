import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:famlynk_version1/mvc/model/familyTree_model/familyTree_model.dart';
import 'package:famlynk_version1/services/familyTreeService/familyTree_service.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:flutter_svg/flutter_svg.dart';

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
              scale: _zoomLevel, // Set this variable to control the zoom level
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Text(
                    //   'Zoom: ${(_zoomLevel * 100).toStringAsFixed(0)}%',
                    //   style: TextStyle(fontSize: 18),
                    // ),
                    // Your header elements here
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

  Future<ui.Image?> loadImage(String imagePath) async {
    final imageProvider = NetworkImage(imagePath);
    final imageStream = imageProvider.resolve(ImageConfiguration.empty);
    final completer = Completer<ui.Image>();

    final listener = ImageStreamListener((imageInfo, synchronousCall) {
      completer.complete(imageInfo.image);
    });

    imageStream.addListener(listener);

    try {
      final image = await completer.future;
      imageStream.removeListener(listener);
      return image;
    } catch (e) {
      print("Image loading error: $e");
      return null;
    }
  }

  @override
  void paint(Canvas canvas, Size size) async {
    final paint = Paint()..strokeWidth = 2.5;

    for (int i = 0; i < familyTreeDataList.length; i++) {
      Future<ui.Image> loadImage(String imageUrl) async {
        print("Loading image: $imageUrl");
        final NetworkImage imageProvider = NetworkImage(imageUrl);
        final ImageStream stream =
            imageProvider.resolve(ImageConfiguration.empty);
        final Completer<ui.Image> completer = Completer<ui.Image>();
        stream.addListener(ImageStreamListener((ImageInfo info, bool _) {
          completer.complete(info.image);
        }));
        return completer.future;
      }

      if (user.contains(familyTreeDataList[i])) {
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
       
        // Draw the user's name
        TextSpan userTextSpan = TextSpan(
          text: user[0].name,
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
        final centerX = size.width * 0.5;
        final centerY = size.height * 0.110 + i * 2;
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
        final centerY = size.height * 0.130 + i * 2;
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
        final image = imageCache[mothers[motherIndex].uniqueUserID];
        if (image != null) {
          final imageSize = Size(60, 60);
          final imageRect = Rect.fromCenter(
            center: Offset(motherX, centerY),
            width: imageSize.width,
            height: imageSize.height,
          );
          canvas.drawImageRect(
            image,
            Rect.fromLTRB(
                0, 0, image.width.toDouble(), image.height.toDouble()),
            imageRect,
            paint,
          );
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
        final horizontalLineX = size.width * 0.36 - brotherIndex * 50.0;

        canvas.drawLine(
          Offset(size.width * 0.5, centerY),
          Offset(centerX, centerY),
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
          Offset(brotherX, brotherY + 20),
          paint,
        );

        paint
          ..color = Colors.green
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1;

        // Draw the circle at the end of the bottom line
        canvas.drawCircle(
          Offset(brotherX, brotherY + 40),
          20,
          paint,
        );
        final Paint glowPaint = Paint()
          ..color = Colors.green.withOpacity(0.3)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, 12);

        canvas.drawCircle(
          Offset(brotherX, brotherY + 40),
          25,
          glowPaint,
        );

        final image = imageCache[brothers[brotherIndex].image];
        if (image != null) {
          final imageSize = Size(60, 60);
          final imageRect = Rect.fromCenter(
            center: Offset(brotherX, brotherY),
            width: imageSize.width,
            height: imageSize.height,
          );
          canvas.drawImageRect(
            image,
            Rect.fromLTRB(
                0, 0, image.width.toDouble(), image.height.toDouble()),
            imageRect,
            paint,
          );
        }
        // // Draw brother's image if available
        // final imageFuture = loadImage(brothers[brotherIndex].image.toString());

        // // Use a FutureBuilder to paint the image when it's loaded
        // FutureBuilder<ui.Image?>(
        //   future: imageFuture,
        //   builder: (context, snapshot) {
        //     if (snapshot.connectionState == ConnectionState.done &&
        //         snapshot.data != null) {
        //       final image = snapshot.data!;
        //       final imageSize = Size(60, 60); // Adjust size as needed
        //       final imageRect = Rect.fromCenter(
        //         center: Offset(brotherX - 30, brotherY + 60),
        //         width: imageSize.width,
        //         height: imageSize.height,
        //       );
        //       canvas.drawImageRect(
        //         image,
        //         Rect.fromLTRB(
        //             0, 0, image.width.toDouble(), image.height.toDouble()),
        //         imageRect,
        //         paint,
        //       );
        //     }
        //     // Return an empty container if the image is not yet loaded
        //     return Container();
        //   },
        // );

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
          Offset(brotherX - 14, centerY + 65),
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
          Offset(brotherX - 14, centerY + 75),
        );
      }

      // Sister
      if (sisters.contains(familyTreeDataList[i])) {
        final paint = Paint()..strokeWidth = 2.5;
        final centerX = size.width * 0.5;
        final centerY = size.height * 0.300 + i * 0.1;
        final sisterIndex = sisters.indexOf(familyTreeDataList[i]);

        // Draw vertical line to right
        canvas.drawLine(
          Offset(centerX, centerY),
          Offset(size.width * 0.65, centerY),
          paint,
        );

        // Draw horizontal line extending to the right
        final horizontalLineX = size.width * 0.65 + sisterIndex * 50.0;
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
          Offset(sisterX, sisterY + 20),
          paint,
        );

        paint
          ..color = Colors.red
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1;

        // Draw the circle at the end of the bottom line
        canvas.drawCircle(
          Offset(sisterX, sisterY + 40),
          20,
          paint,
        );
        final Paint glowPaint = Paint()
          ..color = Colors.red.withOpacity(0.3)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, 12);

        canvas.drawCircle(
          Offset(sisterX, sisterY + 40),
          25,
          glowPaint,
        );

        final networkImage = NetworkImage('${sisters[sisterIndex].image}');
        final imageStream = networkImage.resolve(ImageConfiguration.empty);
        final listener = ImageStreamListener((info, synchronousCall) async {
          try {
            final ByteData? data =
                await info.image.toByteData(format: ImageByteFormat.png);
            if (data != null) {
              final Uint8List uint8list = data.buffer.asUint8List();
              final uiImage = await decodeImageFromList(uint8list);
              final imageSize = Size(
                uiImage.width.toDouble(),
                uiImage.height.toDouble(),
              );

              final imageRect = Rect.fromCenter(
                center: Offset(sisterX - 30, sisterY + 60),
                width: imageSize.width,
                height: imageSize.height,
              );

              paintImage(
                canvas: canvas,
                rect: imageRect,
                image: uiImage,
                fit: BoxFit.cover,
              );
            }
          } catch (e) {
            print('Image loading error: $e');
          }
        });

        imageStream.addListener(listener);

        // Draw sister's image inside the circle
        // final imagess = imageCache[sisters[sisterIndex].image];
        // print("wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww");
        // print(imagess);

        // if (imagess != null) {
        //   final imageSize = Size(60, 60);
        //   final imageRect = Rect.fromCenter(
        //     center: Offset(sisterX - 30, sisterY + 60),
        //     width: imageSize.width,
        //     height: imageSize.height,
        //   );
        //   // CustomPaint(
        //   //   painter: MyCustomPainter(
        //   //     imageUrl: "${imagess}",
        //   //   ),
        //   //   size: Size(30, 30),
        //   // );
        //   canvas.drawImageRect(
        //     imagess,
        //     Rect.fromLTRB(10, 10, 10, 10),
        //     imageRect,
        //     paint,
        //   );
        // }

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
          Offset(sisterX - 14, centerY + 65),
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
          Offset(sisterX - 14, centerY + 75),
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
        final centerY = size.height * 0.6 + i * 10;
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

  @override
  bool shouldRepaint(FamilyTreePainter oldDelegate) => false;
}

class MyCustomPainter extends CustomPainter {
  final String imageUrl; // URL of the network image

  MyCustomPainter({required this.imageUrl});

  @override
  void paint(Canvas canvas, Size size) async {
    print("sssssssssssssssssssssssssssssssssssssssssss");
    print(imageUrl);
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final imageProvider = NetworkImage(imageUrl);

    final ImageStream stream = imageProvider.resolve(ImageConfiguration.empty);
    final listener = ImageStreamListener((info, synchronousCall) {
      if (info.image != null) {
        paintImage(
          canvas: canvas,
          rect: rect,
          image: info.image!,
          fit: BoxFit.cover,
        );
      }
    });
    stream.addListener(listener);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
