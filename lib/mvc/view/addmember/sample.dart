import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';

class Sample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Picture Example'),
      ),
      body: Center(
        child:ProfilePicture(
    name: 'Deepak',
    radius: 31,
    fontsize: 21,
    random: true,
)
      ),
    );
  }
}
