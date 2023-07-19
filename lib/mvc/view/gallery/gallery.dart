import 'package:flutter/material.dart';
import 'package:famlynk_version1/mvc/model/newsfeed_model/newsFeed_model.dart';
import 'package:famlynk_version1/services/gallery_service.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MediaPage extends StatefulWidget {
  @override
  _MediaPageState createState() => _MediaPageState();
}

class _MediaPageState extends State<MediaPage> {
  List<NewsFeedModel> mediaList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchMedia();
  }

Future<void> _fetchMedia() async {
  try {
    final service = ShowGalleryService();
    mediaList = await service.getPhotoList();
    mediaList.sort((a, b) {
      final aDate = a.createdOn as DateTime; 
      final bDate = b.createdOn as DateTime; 
      return bDate.compareTo(aDate);
    }); 
    mediaList = mediaList.reversed.toList(); 
    setState(() {
      isLoading = false;
    });
  } catch (e) {
    print('Failed to fetch media: $e');
    setState(() {
      isLoading = false;
    });
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
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : (nonEmptyMediaList.isEmpty
              ? Center(child: Text('No media available.'))
              : _buildMediaGridView(nonEmptyMediaList)),
    );
  }

  Widget _buildMediaGridView(List<NewsFeedModel> mediaList) {
    final padding = EdgeInsets.symmetric(
      horizontal: MediaQuery.of(context).size.width * 0.01,
      vertical: MediaQuery.of(context).size.width * 0.01,
    );

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      itemCount: mediaList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: padding,
          child: _buildImage(mediaList[index]),
        );
      },
    );
  }

  Widget _buildImage(NewsFeedModel media) {
    return CachedNetworkImage(
      imageUrl: media.photo,
      fit: BoxFit.cover,
      placeholder: (context, url) => CircularProgressIndicator(),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}
