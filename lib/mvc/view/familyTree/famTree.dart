// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CircleAvatarLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: CustomPaint(
          painter: CircleAvatarPainter(),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatarWidget(
                      image: Image.asset('assets/me.png'),
                      label: 'You',
                    ),
                    SizedBox(width: 20),
                    CircleAvatarWidget(
                      image: Image.asset('assets/wife.png'),
                      label: 'Your Wife',
                    ),
                  ],
                ),
                SizedBox(height: 20),
                CircleAvatarWidget(
                  image: Image.asset('assets/parents.png'),
                  label: 'Parents',
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatarWidget(
                      image: Image.asset('assets/child1.png'),
                      label: 'Child 1',
                    ),
                    SizedBox(width: 20),
                    CircleAvatarWidget(
                      image: Image.asset('assets/child2.png'),
                      label: 'Child 2',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CircleAvatarWidget extends StatelessWidget {
  final Image image;
  final String label;

  CircleAvatarWidget({super.key, required this.image, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: image.image,
        ),
        SizedBox(height: 10),
        Text(label),
      ],
    );
  }
}



class CircleAvatarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final avatars = [
      Offset(size.width / 2, 0), // You
      Offset(size.width / 2, size.height / 4), // Your Wife
      Offset(size.width / 2, size.height / 2), // Parents
      Offset(size.width / 2 - 120, size.height * 3 / 4), // Child 1
      Offset(size.width / 2 + 120, size.height * 3 / 4), // Child 2
    ];

    final path = Path();
    final startPoint = avatars[0];

    path.moveTo(startPoint.dx, startPoint.dy);

    for (int i = 1; i < avatars.length; i++) {
      final avatar = avatars[i];
      path.lineTo(avatar.dx, avatar.dy);
    }

    // Connect Parents to Child avatars
    final parentAvatar = avatars[2];
    final childAvatar1 = avatars[3];
    final childAvatar2 = avatars[4];
    path.moveTo(parentAvatar.dx, parentAvatar.dy);
    path.lineTo(childAvatar1.dx, childAvatar1.dy);
    path.moveTo(parentAvatar.dx, parentAvatar.dy);
    path.lineTo(childAvatar2.dx, childAvatar2.dy);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CircleAvatarPainter oldDelegate) => false;
}

