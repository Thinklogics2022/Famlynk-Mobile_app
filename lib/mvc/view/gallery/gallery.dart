import 'package:famlynk_version1/services/gallery_service.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:famlynk_version1/mvc/model/newsfeed_model/newsFeed_model.dart';

class MediaPage extends StatefulWidget {
  @override
  _MediaPageState createState() => _MediaPageState();
}

class _MediaPageState extends State<MediaPage> {
  List<NewsFeedModel> mediaList = [];

  @override
  void initState() {
    super.initState();
    _fetchMedia();
  }

  Future<void> _fetchMedia() async {
    try {
      final service = ShowGalleryService();
      mediaList = await service.getPhotoList();
      setState(() {});
    } catch (e) {
      // Handle error
      print('Failed to fetch media: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final nonEmptyMediaList =
        mediaList.where((media) => media.photo.isNotEmpty).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text('Media Page'),
      ),
      body: nonEmptyMediaList.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: nonEmptyMediaList.length,
              itemBuilder: (context, index) {
                return _buildImage(nonEmptyMediaList[index]);
              },
            ),
    );
  }

  Widget _buildImage(NewsFeedModel media) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.87, 
            child: Column(
              children: [
                Text(media.name),
                Image.network(
                  media.photo,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 10,),
                Divider(thickness: 2,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
