import 'package:famlynk_version1/mvc/view/newsFeed/fresh.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class NewsFeedFirstPage extends StatelessWidget {
  late final List<XFile> images;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have no post\'s yet',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => FreshNewsFeed()));
        },
        tooltip: 'Post Here',
        child: const Icon(Icons.add),
      ),
    );
  }
}
